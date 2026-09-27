report 50106 "TOMRefereshProductionLine"
{
    /*
        TOM 1.26 Line level - Production Order Refresh - Firmed Planned & Released Production Order
    */
    Caption = 'Refresh Production Order';
    ProcessingOnly = true;
    dataset
    {
        dataitem("ProdOrderLine"; "Prod. Order Line")
        {
            DataItemTableView = SORTING(Status, "Prod. Order No.", "Line No.");
            RequestFilterFields = Status, "Prod. Order No.", "Line No.", "Item No.";

            trigger OnAfterGetRecord()
            var
                Item: Record Item;
                prodOrder: Record "Production Order";
                ProdOrderLine: Record "Prod. Order Line";
                prodBomLine: Record "Production BOM Line";
                routingLine: Record "Routing Line";
                porl: Record "Prod. Order Routing Line";
                poc: Record "Prod. Order Component";
                lineNo: Integer;
                SKU: Record "Stockkeeping Unit";
                Location: Record Location;

            begin

                if not prodOrder.Get(Status, "Prod. Order No.") then
                    Error('Production order can''t be fetched');
                if Item.Get("Item No.") then;

                porl.SetRange("Prod. Order No.", "Prod. Order No.");
                porl.SetRange("Routing Reference No.", "Line No.");
                if porl.IsEmpty then begin
                    routingLine.SetRange("Routing No.", Item."Routing No.");
                    if routingLine.FindSet() then begin

                        repeat
                            porl.Init();
                            porl.Status := Status;
                            porl.Validate("Prod. Order No.", "Prod. Order No.");
                            porl.Validate("Routing No.", routingLine."Routing No.");
                            porl."Routing Reference No." := "Line No.";
                            porl.CopyFromRoutingLine(routingLine);
                            porl.Insert(true);

                        until routingLine.Next() = 0;
                    end;
                end;
                poc.SetRange("Prod. Order No.", "Prod. Order No.");
                poc.SetRange("Prod. Order Line No.", "Line No.");
                if poc.IsEmpty then begin
                    prodBomLine.SetRange("Production BOM No.", "Item No.");
                    prodBomLine.SetRange("Version Code", "Production BOM Version Code");
                    if prodBomLine.FindSet() then begin
                        lineNo := 10000;
                        repeat
                            poc.Init();
                            poc.Status := Status;
                            poc.Validate("Prod. Order No.", "Prod. Order No.");
                            poc."Prod. Order Line No." := "Line No.";
                            poc."Line No." := lineNo;
                            poc.Validate("Item No.", prodBomLine."No.");
                            poc.Description := prodBomLine.Description;
                            poc.Validate("Unit of Measure Code", prodBomLine."Unit of Measure Code");
                            //poc.Quantity := ProdOrderLine.Quantity;
                            //poc."Quantity (Base)" := prodBomLine.Quantity;
                            poc.validate("Quantity per", prodBomLine."Quantity per");
                            poc.Position := prodBomLine.Position;
                            poc."Position 2" := prodBomLine."Position 2";
                            poc."Position 3" := prodBomLine."Position 3";
                            poc."Lead-Time Offset" := prodBomLine."Lead-Time Offset";
                            poc.Validate("Routing Link Code", prodBomLine."Routing Link Code");
                            poc.Validate("Scrap %", prodBomLine."Scrap %");
                            poc.Validate("Variant Code", prodBomLine."Variant Code");

                            SKU.Reset();
                            SKU.SetRange("Item No.", prodBomLine."No.");
                            SKU.SetRange("Location Code", prodOrder."Location Code");
                            SKU.SetRange("Variant Code", prodBomLine."Variant Code");
                            if SKU.FindFirst() then
                                poc.Validate("Flushing Method", sku."Flushing Method");


                            poc.Length := prodBomLine.Length;
                            poc.Width := prodBomLine.Width;
                            poc.Weight := prodBomLine.Weight;
                            poc.Depth := prodBomLine.Depth;
                            poc.validate("Calculation Formula", prodBomLine."Calculation Formula");
                            poc.validate("Location Code", prodOrder."Location Code");
                            //poc.validate("Bin Code", prodOrder."Bin Code");
                            //poc.validate("Bin Code", GetDefaultBin(poc));
                            Location.Get(poc."Location Code");
                            poc.validate("Bin Code", Location."To-Production Bin Code");
                            poc.Insert(true);
                            lineNo += 10000;
                        until prodBomLine.Next() = 0;
                    end;
                end;

            end;

            trigger OnPreDataItem()
            begin
                Window.Open(
                  Text000 +
                  Text001 +
                  Text002);
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(Direction; Direction)
                    {
                        ApplicationArea = Manufacturing;
                        Caption = 'Scheduling direction';
                        OptionCaption = 'Forward,Back';
                        ToolTip = 'Specifies whether you want the scheduling to be refreshed forward or backward.';
                    }
                    group(Calculate)
                    {
                        Caption = 'Calculate';
                        field(CalcLines; CalcLines)
                        {
                            ApplicationArea = Manufacturing;
                            Caption = 'Lines';
                            ToolTip = 'Specifies if you want the program to calculate the production order lines.';

                            trigger OnValidate()
                            begin
                                if CalcLines then begin
                                    CalcRoutings := true;
                                    CalcComponents := true;
                                end;
                            end;
                        }
                        field(CalcRoutings; CalcRoutings)
                        {
                            ApplicationArea = Manufacturing;
                            Caption = 'Routings';
                            ToolTip = 'Specifies if you want the program to calculate the routing.';

                            trigger OnValidate()
                            begin
                                if not CalcRoutings then
                                    if CalcLines then
                                        Error(Text003);
                            end;
                        }
                        field(CalcComponents; CalcComponents)
                        {
                            ApplicationArea = Manufacturing;
                            Caption = 'Component Need';
                            ToolTip = 'Specifies if you want the program to calculate the component requirement.';

                            trigger OnValidate()
                            begin
                                if not CalcComponents then
                                    if CalcLines then
                                        Error(Text004);
                            end;
                        }
                    }
                    group(Warehouse)
                    {
                        Caption = 'Warehouse';
                        field(CreateInbRqst; CreateInbRqst)
                        {
                            ApplicationArea = Manufacturing;
                            Caption = 'Create Inbound Request';
                            ToolTip = 'Specifies if you want to create an inbound request when calculating and updating a production order.';
                        }
                    }
                }
            }
        }

        actions
        {
        }

        trigger OnInit()
        begin
            CalcLines := false;
            CalcRoutings := true;
            CalcComponents := true;

            OnAfterOnInit(Direction, CalcLines, CalcRoutings, CalcComponents, CreateInbRqst);
        end;
    }

    labels
    {
    }

    trigger OnInitReport()
    begin
        Direction := Direction::Backward;
    end;

    var
        Text000: Label 'Refreshing Production Orders...\\';
        Text001: Label 'Status         #1##########\';
        Text002: Label 'No.            #2##########';
        Text003: Label 'Routings must be calculated, when lines are calculated.';
        Text004: Label 'Component Need must be calculated, when lines are calculated.';
        CalcProdOrder: Codeunit "Calculate Prod. Order";
        CreateProdOrderLines: Codeunit "Create Prod. Order Lines";
        WhseProdRelease: Codeunit "Whse.-Production Release";
        WhseOutputProdRelease: Codeunit "Whse.-Output Prod. Release";
        Window: Dialog;
        Direction: Option Forward,Backward;
        CalcLines: Boolean;
        CalcRoutings: Boolean;
        CalcComponents: Boolean;
        CreateInbRqst: Boolean;
        Text005: Label 'One or more of the lines on this %1 require special warehouse handling. The %2 for these lines has been set to blank.';
        DeletePickedLinesQst: Label 'Components for production order %1 have already been picked. Do you want to continue?', Comment = 'Production order no.: Components for production order 101001 have already been picked. Do you want to continue?';

    local procedure GetDefaultBin(var ProdOrderComp: Record "Prod. Order Component") BinCode: Code[20]
    var
        Location: Record Location;
        ProdOrderWarehouseMgt: Codeunit "Prod. Order Warehouse Mgt.";
    begin
        if ProdOrderComp."Location Code" <> '' then begin
            if Location.Code <> ProdOrderComp."Location Code" then
                Location.Get(ProdOrderComp."Location Code");
            if Location."Bin Mandatory" and (not Location."Directed Put-away and Pick") then
                ProdOrderWarehouseMgt.GetDefaultBin(ProdOrderComp."Item No.", ProdOrderComp."Variant Code", ProdOrderComp."Location Code", BinCode);
        end;
    end;

    procedure InitializeRequest(var Rec: Record "Prod. Order Line")
    begin

        ProdOrderLine.SetRange("Prod. Order No.", Rec."Prod. Order No.");
        ProdOrderLine.SetFilter("Line No.", '%1', Rec."Line No.");
        ProdOrderLine.SetRecFilter();
    end;

    procedure InitializeRequest(No: code[20]; lineNo: Integer)
    begin

        ProdOrderLine.SetFilter("Prod. Order No.", No);
        ProdOrderLine.SetFilter("Line No.", '%1', lineNo);

    end;

    procedure InitializeRequest(Direction2: Option Forward,Backward; CalcLines2: Boolean; CalcRoutings2: Boolean; CalcComponents2: Boolean; CreateInbRqst2: Boolean)
    begin
        Direction := Direction2;
        CalcLines := CalcLines2;
        CalcRoutings := CalcRoutings2;
        CalcComponents := CalcComponents2;
        CreateInbRqst := CreateInbRqst2;
    end;

    local procedure IsComponentPicked(ProdOrder: Record "Production Order"): Boolean
    var
        ProdOrderComp: Record "Prod. Order Component";
    begin
        ProdOrderComp.SetRange(Status, ProdOrder.Status);
        ProdOrderComp.SetRange("Prod. Order No.", ProdOrder."No.");
        ProdOrderComp.SetFilter("Qty. Picked", '<>0');
        exit(not ProdOrderComp.IsEmpty);
    end;

    local procedure GetRoutingNo(ProdOrder: Record "Production Order") RoutingNo: Code[20]
    var
        Item: Record Item;
        StockkeepingUnit: Record "Stockkeeping Unit";
        Family: Record Family;
    begin
        RoutingNo := ProdOrder."Routing No.";
        case ProdOrder."Source Type" of
            ProdOrder."Source Type"::Item:
                begin
                    if Item.Get(ProdOrder."Source No.") then
                        RoutingNo := Item."Routing No.";
                    if StockkeepingUnit.Get(ProdOrder."Location Code", ProdOrder."Source No.", ProdOrder."Variant Code") and
                        (StockkeepingUnit."Routing No." <> '')
                    then
                        RoutingNo := StockkeepingUnit."Routing No.";
                end;
            ProdOrder."Source Type"::Family:
                if Family.Get(ProdOrder."Source No.") then
                    RoutingNo := Family."Routing No.";
        end;

        OnAfterGetRoutingNo(ProdOrder, RoutingNo);
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterGetRoutingNo(var ProductionOrder: Record "Production Order"; var RoutingNo: Code[20])
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterRefreshProdOrder(var ProductionOrder: Record "Production Order"; ErrorOccured: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterOnInit(var Direction: Option; var CalcLines: Boolean; var CalcRoutings: Boolean; var CalcComponents: Boolean; var CreateInbRqst: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeCalcProdOrder(var ProductionOrder: Record "Production Order"; Direction: Option Forward,Backward)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeCalcProdOrderLine(var ProdOrderLine: Record "Prod. Order Line"; Direction: Option Forward,Backward; CalcLines: Boolean; CalcRoutings: Boolean; CalcComponents: Boolean; var IsHandled: Boolean; var ErrorOccured: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeCalcProdOrderLines(var ProductionOrder: Record "Production Order"; Direction: Option Forward,Backward; CalcLines: Boolean; CalcRoutings: Boolean; CalcComponents: Boolean; var IsHandled: Boolean; var ErrorOccured: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeCalcRoutingsOrComponents(var ProductionOrder: Record "Production Order"; var ProdOrderLine: Record "Prod. Order Line"; var CalcComponents: Boolean; var CalcRoutings: Boolean; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeUpdateRoutingNo(var ProductionOrder: Record "Production Order"; RoutingNo: Code[20]; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnCheckReservationExistOnBeforeCheckProdOrderComp2ReservedQtyBase(var ProdOrderComp2: Record "Prod. Order Component")
    begin
    end;
}