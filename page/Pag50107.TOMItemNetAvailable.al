page 50107 "TOMItemNetAvailable"
{
    //TOM1.81 05092022 Created New page for Item Net availability
    ApplicationArea = All;
    Caption = 'Items - Net Available';
    PageType = List;
    SourceTable = Item;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {

            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the number of the involved entry or record, according to the specified number series.';
                    ApplicationArea = All;
                    Caption = 'Item No.';
                    TableRelation = Item."No.";
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the Description for the Item.';
                    ApplicationArea = All;
                }
                field("Vendor No."; Rec."Vendor No.")
                {
                    ToolTip = 'Specifies the vendor code of who supplies this item by default.';
                    ApplicationArea = All;
                }
                field("Replenishment System"; Rec."Replenishment System")
                {
                    ToolTip = 'Specifies the type of supply order created by the planning system when the item needs to be replenished.';
                    ApplicationArea = All;
                }
                field(Inventory; Rec.Inventory)
                {
                    ToolTip = 'Specifies the total quantity of the item that is currently in inventory at all locations.';
                    ApplicationArea = All;
                    Caption = 'Qty. on Hand';
                }
                field("Base Unit of Measure"; Rec."Base Unit of Measure")
                {
                    ApplicationArea = All;
                    Caption = 'Base UOM';
                }

                field("Qty. on PLYM"; Rec."Qty. on PLYM")
                {
                    Visible = IsPLYMHARTALBVisible;
                    ToolTip = 'Specifies the total quantity of the item that is currently in inventory at all locations.';
                    ApplicationArea = All;
                }
                field("Qty. on HART"; Rec."Qty. on HART")
                {
                    Visible = IsPLYMHARTALBVisible;
                    ToolTip = 'Specifies the total quantity of the item that is currently in inventory at all locations.';
                    ApplicationArea = All;
                }
                field("Qty. on ALB"; Rec."Qty. on ALB")
                {
                    Visible = IsPLYMHARTALBVisible;
                    ToolTip = 'Specifies the total quantity of the item that is currently in inventory at all locations.';
                    ApplicationArea = All;
                }
                field("Qty. on LAG"; Rec."Qty. on LAG")
                {
                    Visible = IsLAGVisible;
                    ToolTip = 'Specifies the total quantity of the item that is currently in inventory at all locations.';
                    ApplicationArea = All;
                }
                field("Qty. on Sales Order"; Rec."Qty. on Sales Order")
                {
                    ToolTip = 'Specifies how many units of the item are allocated to sales orders, meaning listed on outstanding sales orders lines.';
                    ApplicationArea = All;
                }
                field("Sales Unit of Measure"; Rec."Sales Unit of Measure")
                {
                    ApplicationArea = All;
                    Caption = 'Sales UOM';
                }

                field("Qty. on Purch. Order"; Rec."Qty. on Purch. Order")
                {
                    ToolTip = 'Specifies how many units of the item are inbound on purchase orders, meaning listed on outstanding purchase order lines.';
                    ApplicationArea = All;
                }
                field("Purch. Unit of Measure"; Rec."Purch. Unit of Measure")
                {
                    ApplicationArea = All;
                    Caption = 'Purch. UOM';
                }
                field("Qty. on Component Lines"; Rec."Qty. on Component Lines")
                {
                    ToolTip = 'Specifies how many units of the item are allocated as production order components, meaning listed under outstanding production order lines.';
                    ApplicationArea = All;
                    Caption = 'Qty. on Components';
                }
                field("Qty. on PLYM Component"; Rec."Qty. on PLYM Components")
                {
                    Visible = IsPLYMHARTALBVisible;
                    ToolTip = 'Specifies the total quantity of the item that is currently in inventory at all locations.';
                    ApplicationArea = All;
                }
                field("Qty. on HART Component"; Rec."Qty. on HART Components")
                {
                    Visible = IsPLYMHARTALBVisible;
                    ToolTip = 'Specifies the total quantity of the item that is currently in inventory at all locations.';
                    ApplicationArea = All;
                }
                field("Qty. on ALB Component"; Rec."Qty. on ALB Components")
                {
                    Visible = IsPLYMHARTALBVisible;
                    ToolTip = 'Specifies the total quantity of the item that is currently in inventory at all locations.';
                    ApplicationArea = All;
                }
                field("Qty. on LAG Component"; Rec."Qty. on LAG Components")
                {
                    Visible = IsLAGVisible;
                    ToolTip = 'Specifies the total quantity of the item that is currently in inventory at all locations.';
                    ApplicationArea = All;
                }

                field("Net Available"; Rec."Net Available")
                {
                    ApplicationArea = All;
                }
                field("Purchasing Code"; Rec."Purchasing Code")
                {
                    ToolTip = 'Specifies the code for a special procurement method, such as drop shipment.';
                }
                field(NextNeedDateVarGbl; CalculatePeriodEntries)
                {
                    Caption = 'Next Need Date';
                }
                field("Quantity Rem. On Blanket PO"; Rec."Quantity Rem. On Blanket PO")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the value of Quantity Rem. On Blanket PO';
                }
                field("THK Purchaser Code"; Rec."THK Purchaser Code")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the value of Purchaser Code';
                }
            }
        }
        area(factboxes)
        {
            part(ItemSupplyFactbox; TOMItemSupplyFactbox)
            {
                ApplicationArea = All;
                SubPageLink = "No." = field("No.");
            }
            part(ItemDemandFactbox; TOMItemDemandFactbox)
            {
                ApplicationArea = All;
                SubPageLink = "No." = field("No.");
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(Card)
            {
                Caption = 'Card';
                Image = Card;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                ApplicationArea = all;

                trigger OnAction()
                begin
                    page.RunModal(page::"Item Card", Rec);
                end;
            }

            action(UpdateNetAvailable)
            {
                Caption = 'Update Net Available';
                Image = UpdateUnitCost;
                Promoted = true;
                PromotedCategory = "Process";
                PromotedIsBig = true;
                PromotedOnly = true;
                ApplicationArea = all;
                trigger OnAction()
                var
                    ItemLclRec: Record item;
                    NetDemand: Decimal;
                    NetSupply: Decimal;
                    Counter: Integer;
                begin
                    CurrPage.SETSELECTIONFILTER(ItemLclRec);
                    //ItemLclRec.SETRANGE(Blocked, FALSE);
                    IF ItemLclRec.FINDSET THEN BEGIN
                        REPEAT
                            CLEAR(NetDemand);
                            CLEAR(NetSupply);
                            ItemLclRec.CALCFIELDS(ItemLclRec.Inventory, ItemLclRec."Purch. Req. Receipt (Qty.)", ItemLclRec."Qty. on Purch. Order",
                            ItemLclRec."Qty. on Prod. Order", ItemLclRec."Qty. in Transit", ItemLclRec."Qty. on Assembly Order",
                            ItemLclRec."Qty. on Sales Order", ItemLclRec."Qty. on Service Order", ItemLclRec."Qty. on Component Lines",
                            ItemLclRec."Qty. on Job Order", ItemLclRec."Qty. on Asm. Component");

                            NetSupply := ItemLclRec.Inventory + ItemLclRec."Purch. Req. Receipt (Qty.)" + ItemLclRec."Qty. on Purch. Order" +
                                        ItemLclRec."Qty. on Prod. Order" + ItemLclRec."Qty. in Transit" + ItemLclRec."Qty. on Assembly Order";

                            NetDemand := ItemLclRec."Qty. on Sales Order" + ItemLclRec."Qty. on Service Order" + ItemLclRec."Qty. on Component Lines" +
                                        ItemLclRec."Qty. on Job Order" + ItemLclRec."Qty. on Asm. Component";

                            ItemLclRec."Net Available" := NetSupply - NetDemand;
                            ItemLclRec.MODIFY;
                            Counter += 1;
                        UNTIL ItemLclRec.NEXT = 0;
                    END;

                    CurrPage.UPDATE(TRUE);

                    IF Counter > 0 THEN
                        MESSAGE('Net Available is updated successfully');

                end;
            }
        }

    }
    trigger OnOpenPage()
    var
        NetSupply: Decimal;
        ItemLclRec: Record item;
        NetDemand: Decimal;
    begin
        if CompanyName = 'Tomahawk Automation - Prod' then
            IsLAGVisible := true
        else
            IsPLYMHARTALBVisible := true;
    end;


    procedure CalculatePeriodEntries(): Date
    begin
        PeriodType := PeriodType::Day;
        ForecastName := '';
        IncludeBlanketOrders := false;
        IncludePlanningSuggestions := false;
        RunningInventorySuggestion := 0;
        RunningInventoryForecast := 0;
        RunningInventory := 0;

        Clear(CalcInventoryPageData);

        ItemRecGbl.reset;
        ItemRecGbl.SetRange("No.", Rec."No.");
        ItemRecGbl.SetRange("Drop Shipment Filter", false);
        ItemRecGbl.FindFirst();

        CalcInventoryPageData.Initialize(ItemRecGbl, ForecastName, IncludeBlanketOrders, 0D, IncludePlanningSuggestions);

        TempInvtPageData.Reset();
        TempInvtPageData.DeleteAll();
        TempInvtPageData.SetCurrentKey("Period Start", "Line No.");
        CalcInventoryPageData.CreatePeriodEntries(TempInvtPageData, PeriodType);

        TempInvtPageData.SetRange(Level, 0);
        if TempInvtPageData.Find('-') then
            repeat
                CalcInventoryPageData.DetailsForPeriodEntry(TempInvtPageData, true);
                CalcInventoryPageData.DetailsForPeriodEntry(TempInvtPageData, false);
            until TempInvtPageData.Next() = 0;
        TempInvtPageData.SetRange(Level);

        if TempInvtPageData.FindSet() then
            repeat
                TempInvtPageData."Projected Inventory" :=
                  RunningInventory +
                  (TempInvtPageData."Gross Requirement" - TempInvtPageData."Reserved Requirement") + (TempInvtPageData."Scheduled Receipt" - TempInvtPageData."Reserved Receipt");
                TempInvtPageData."Forecasted Projected Inventory" :=
                  RunningInventoryForecast + TempInvtPageData."Remaining Forecast" +
                  (TempInvtPageData."Gross Requirement" - TempInvtPageData."Reserved Requirement") + (TempInvtPageData."Scheduled Receipt" - TempInvtPageData."Reserved Receipt");
                TempInvtPageData."Suggested Projected Inventory" :=
                  RunningInventorySuggestion + TempInvtPageData."Action Message Qty." + TempInvtPageData."Remaining Forecast" +
                  (TempInvtPageData."Gross Requirement" - TempInvtPageData."Reserved Requirement") + (TempInvtPageData."Scheduled Receipt" - TempInvtPageData."Reserved Receipt");

                if TempInvtPageData.Level = 1 then begin
                    RunningInventory := TempInvtPageData."Projected Inventory";
                    RunningInventoryForecast := TempInvtPageData."Forecasted Projected Inventory";
                    RunningInventoryForecast := TempInvtPageData."Suggested Projected Inventory"
                end;
                TempInvtPageData.Modify();
            until TempInvtPageData.Next() = 0;

        /*
        TempInvtPageData.Reset();
        if TempInvtPageData.FindSet() then
            repeat
                Message('%1,%2,%3', TempInvtPageData."Period Start", TempInvtPageData."Projected Inventory", TempInvtPageData."Suggested Projected Inventory");
            until TempInvtPageData.Next() = 0;
        */
        TempInvtPageData.Reset();
        TempInvtPageData.Setfilter("Projected Inventory", '<%1', 0);
        if TempInvtPageData.FindFirst() then
            exit(TempInvtPageData."Period Start");

        exit(0D);
    end;

    var
        IsPLYMHARTALBVisible: Boolean;
        IsLAGVisible: Boolean;
        TempInvtPageData: Record "Inventory Page Data" temporary;
        CalcInventoryPageData: Codeunit "Calc. Inventory Page Data";
        PeriodType: Option Day,Week,Month,Quarter,Year;
        NextNeedDateVarGbl: Date;
        ForecastName: Code[10];
        IncludeBlanketOrders: Boolean;
        IncludePlanningSuggestions: Boolean;
        ItemRecGbl: Record Item;
        RunningInventory: Decimal;
        RunningInventoryForecast: Decimal;
        RunningInventorySuggestion: Decimal;
}
