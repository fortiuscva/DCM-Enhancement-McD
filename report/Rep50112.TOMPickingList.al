report 50112 "TOMPickingList"
{
    //TOM 1.53 Created new picking list
    DefaultLayout = RDLC;
    RDLCLayout = './reportlayout//PickingList.rdl';
    Caption = 'Picking List';
    UsageCategory = Administration;
    ApplicationArea = all;
    dataset
    {
        dataitem("Warehouse Activity Header"; "Warehouse Activity Header")
        {
            DataItemTableView = SORTING(Type, "No.") WHERE(Type = FILTER(Pick | "Invt. Pick"));
            RequestFilterFields = "No.", "No. Printed";
            CalcFields = "TOMSourceNo.";
            column(No_WhseActivHeader; "No.")
            {
            }
            column(PurchaserCodeCaption; PurchaserCodeCaptionLbl)
            { }
            Column(ShiptoAdd1; ShiptoAddr[1])
            {

            }
            Column(ShiptoAdd2; ShiptoAddr[2])
            {

            }
            Column(ShiptoAdd3; ShiptoAddr[3])
            {

            }
            Column(ShiptoAdd4; ShiptoAddr[4])
            {

            }
            Column(ShiptoAdd5; ShiptoAddr[5])
            {

            }
            column(ShippingAgent; SalesHeaderRec."Shipping Agent Code")
            {

            }
            column(ShippingAgentService; SalesHeaderRec."LAX E-Ship Agent Service")
            {

            }
            column(SourceNo; WhseActLineRec."Source No.")
            {

            }
            column(SourceLineNo; WhseActLineRec."Source Line No.")
            {

            }
            column(BarCodeText; BarCodeTxt)
            {

            }
            column(BarCodePickTxt; BarCodePickTxt)
            {

            }
            column(SourceDocument; WhseActLineRec."Source Document")
            {

            }
            column(DueDate; WhseActLineRec."Due Date")
            {

            }
            column(SortByItem; SortByItem)
            { }
            //<--
            dataitem("Integer"; "Integer")
            {
                DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));
                column(CompanyName; COMPANYPROPERTY.DisplayName)
                {
                }
                column(TodayFormatted; Format(Today, 0, 4))
                {
                }
                column(Time; Time)
                {
                }
                column(PickFilter; PickFilter)
                {
                }
                column(DirectedPutAwayAndPick; Location."Directed Put-away and Pick")
                {
                }
                column(BinMandatory; Location."Bin Mandatory")
                {
                }
                column(InvtPick; InvtPick)
                {
                }
                column(ShowLotSN; ShowLotSN)
                {
                }
                column(SumUpLines; SumUpLines)
                {
                }
                column(No_WhseActivHeaderCaption; "Warehouse Activity Header".FieldCaption("No."))
                {
                }
                column(WhseActivHeaderCaption; "Warehouse Activity Header".TableCaption + ': ' + PickFilter)
                {
                }
                column(ItemRec_ProdBomNo; ItemRec."Production BOM No.")
                { }
                column(LoctnCode_WhseActivHeader; "Warehouse Activity Header"."Location Code")
                {
                }
                column(SortingMtd_WhseActivHeader; "Warehouse Activity Header"."Sorting Method")
                {
                }
                column(AssgUserID_WhseActivHeader; "Warehouse Activity Header"."Assigned User ID")
                {
                }
                column(SourcDocument_WhseActLine; "Warehouse Activity Line"."Source Document")
                {
                }
                column(LoctnCode_WhseActivHeaderCaption; "Warehouse Activity Header".FieldCaption("Location Code"))
                {
                }
                column(SortingMtd_WhseActivHeaderCaption; "Warehouse Activity Header".FieldCaption("Sorting Method"))
                {
                }
                column(AssgUserID_WhseActivHeaderCaption; "Warehouse Activity Header".FieldCaption("Assigned User ID"))
                {
                }
                column(SourcDocument_WhseActLineCaption; "Warehouse Activity Line".FieldCaption("Source Document"))
                {
                }
                column(SourceNo_WhseActLineCaption; WhseActLine.FieldCaption("Source No."))
                {
                }
                column(ShelfNo_WhseActLineCaption; WhseActLine.FieldCaption("Shelf No."))
                {
                }
                column(VariantCode_WhseActLineCaption; WhseActLine.FieldCaption("Variant Code"))
                {
                }
                column(Description_WhseActLineCaption; WhseActLine.FieldCaption(Description))
                {
                }
                column(ItemNo_WhseActLineCaption; WhseActLine.FieldCaption("Item No."))
                {
                }
                column(WhseActLineItem_PurchaserCode_Caption; WhseActLineItem.FieldCaption("THK Purchaser Code"))
                { }
                column(UOMCode_WhseActLineCaption; 'UOM')
                {
                }
                column(QtytoHandle_WhseActLineCaption; 'Pick Qty')
                {
                }
                column(QtyBase_WhseActLineCaption; 'Total Qty')
                {
                }
                column(DestinatnType_WhseActLineCaption; WhseActLine.FieldCaption("Destination Type"))
                {
                }
                column(DestinationNo_WhseActLineCaption; WhseActLine.FieldCaption("Destination No."))
                {
                }
                column(ZoneCode_WhseActLineCaption; WhseActLine.FieldCaption("Zone Code"))
                {
                }
                column(BinCode_WhseActLineCaption; WhseActLine.FieldCaption("Bin Code"))
                {
                }
                column(ActionType_WhseActLineCaption; WhseActLine.FieldCaption("Action Type"))
                {
                }
                column(CurrReportPageNoCaption; CurrReportPageNoCaptionLbl)
                {
                }
                column(PickingListCaption; PickingListCaptionLbl)
                {
                }
                column(WhseActLineDueDateCaption; WhseActLineDueDateCaptionLbl)
                {
                }
                column(QtyHandledCaption; QtyHandledCaptionLbl)
                {
                }

                column(BomNoCaption; BomNoCaptionLbl)
                { }
                column(ItemsShortLbl; ItemsShortLbl)
                { }
                //-->TOM
                /*
                Column(ShiptoAdd1; ShiptoAddr[1])
                {

                }
                Column(ShiptoAdd2; ShiptoAddr[2])
                {

                }
                Column(ShiptoAdd3; ShiptoAddr[3])
                {

                }
                Column(ShiptoAdd4; ShiptoAddr[4])
                {

                }
                Column(ShiptoAdd5; ShiptoAddr[5])
                {

                }
                column(ShippingAgent; SalesHeaderRec."Shipping Agent Code")
                {

                }
                column(ShippingAgentService; SalesHeaderRec."Shipping Agent Service Code")
                {

                }
                */
                //<--
                column(WhseShptHeadRecGbl_PickNotes; WhseShptHeadRecGbl."TOM Pick Notes")
                { }
                dataitem("Warehouse Activity Line"; "Warehouse Activity Line")
                {
                    DataItemLink = "Activity Type" = FIELD(Type), "No." = FIELD("No.");
                    DataItemLinkReference = "Warehouse Activity Header";
                    DataItemTableView = SORTING("Activity Type", "No.", "Sorting Sequence No.");

                    trigger OnAfterGetRecord()
                    begin
                        if SumUpLines and
                           ("Warehouse Activity Header"."Sorting Method" <>
                            "Warehouse Activity Header"."Sorting Method"::Document)
                        then begin
                            if TempWhseActivLine."No." = '' then begin
                                TempWhseActivLine := "Warehouse Activity Line";
                                TempWhseActivLine.Insert();
                                Mark(true);
                            end else begin
                                TempWhseActivLine.SetSumLinesFilters("Warehouse Activity Line");
                                if "Warehouse Activity Header"."Sorting Method" =
                                   "Warehouse Activity Header"."Sorting Method"::"Ship-To"
                                then begin
                                    TempWhseActivLine.SetRange("Destination Type", "Destination Type");
                                    TempWhseActivLine.SetRange("Destination No.", "Destination No.")
                                end;
                                if TempWhseActivLine.FindFirst then begin
                                    TempWhseActivLine."Qty. (Base)" := TempWhseActivLine."Qty. (Base)" + "Qty. (Base)";
                                    TempWhseActivLine."Qty. to Handle" := TempWhseActivLine."Qty. to Handle" + "Qty. to Handle";
                                    TempWhseActivLine."Source No." := '';
                                    if "Warehouse Activity Header"."Sorting Method" <>
                                       "Warehouse Activity Header"."Sorting Method"::"Ship-To"
                                    then begin
                                        TempWhseActivLine."Destination Type" := TempWhseActivLine."Destination Type"::" ";
                                        TempWhseActivLine."Destination No." := '';
                                    end;
                                    TempWhseActivLine.Modify();
                                end else begin
                                    TempWhseActivLine := "Warehouse Activity Line";
                                    TempWhseActivLine.Insert();
                                    Mark(true);
                                end;
                            end;
                        end else
                            Mark(true);

                        tempWHSEHdr."No." := "Warehouse Activity Line"."Whse. Document No.";
                        if not tempWHSEHdr.Find then begin
                            tempWHSEHdr.Insert;
                            TotalWhseQty := GetWhseShipmentQty("Warehouse Activity Line"."Whse. Document No.");
                        end;


                    end;

                    trigger OnPostDataItem()
                    begin
                        MarkedOnly(true);
                    end;

                    trigger OnPreDataItem()
                    begin
                        TempWhseActivLine.SetRange("Activity Type", "Warehouse Activity Header".Type);
                        TempWhseActivLine.SetRange("No.", "Warehouse Activity Header"."No.");
                        TempWhseActivLine.DeleteAll();
                        if BreakbulkFilter then
                            TempWhseActivLine.SetRange("Original Breakbulk", false);
                        Clear(TempWhseActivLine);
                    end;
                }
                dataitem(WhseActLine; "Warehouse Activity Line")
                {
                    DataItemLink = "Activity Type" = FIELD(Type), "No." = FIELD("No.");
                    DataItemLinkReference = "Warehouse Activity Header";
                    DataItemTableView = SORTING("Activity Type", "No.", "Sorting Sequence No.");
                    column(SourceNo_WhseActLine; "Source No.")
                    {
                    }
                    column(FormatSourcDocument_WhseActLine; Format("Source Document"))
                    {
                    }
                    column(ShelfNo_WhseActLine; "Shelf No.")
                    {
                    }
                    column(ItemNo_WhseActLine; "Item No.")
                    {
                    }
                    column(WhseActLineItem_PurchaserCode; WhseActLineItem."THK Purchaser Code")
                    { }
                    column(Description_WhseActLine; Description)
                    {
                    }
                    column(LineItemRec_ProdBomNo; ProdOrderLineRecGbl."Production BOM No.")
                    { }
                    column(VariantCode_WhseActLine; "Variant Code")
                    {
                    }
                    column(UOMCode_WhseActLine; "Unit of Measure Code")
                    {
                    }
                    column(DueDate_WhseActLine; Format("Due Date"))
                    {
                    }
                    column(QtytoHandle_WhseActLine; "Qty. to Handle")
                    {
                    }
                    column(QtyBase_WhseActLine; "Qty. (Base)")
                    {
                    }
                    column(DestinatnType_WhseActLine; "Destination Type")
                    {
                    }
                    column(DestinationNo_WhseActLine; "Destination No.")
                    {
                    }
                    column(ZoneCode_WhseActLine; "Zone Code")
                    {
                    }
                    column(BinCode_WhseActLine; "Bin Code")
                    {
                    }
                    column(ActionType_WhseActLine; "Action Type")
                    {
                    }
                    column(LotNo_WhseActLine; "Lot No.")
                    {
                    }
                    column(SerialNo_WhseActLine; "Serial No.")
                    {
                    }
                    column(LotNo_WhseActLineCaption; FieldCaption("Lot No."))
                    {
                    }
                    column(SerialNo_WhseActLineCaption; FieldCaption("Serial No."))
                    {
                    }
                    column(LineNo_WhseActLine; "Line No.")
                    {
                    }
                    column(BinRanking_WhseActLine; "Bin Ranking")
                    {
                    }
                    column(EmptyStringCaption; EmptyStringCaptionLbl)
                    {
                    }
                    column(TotalWhseQty; TotalWhseQty)
                    {

                    }
                    column(TotalPickQty; TotalPickQty)
                    {

                    }
                    Column(ShortQtyVarGbl; ShortQtyVarGbl)
                    { }
                    column(TotalQtyVarGbl; TotalQtyVarGbl)
                    { }
                    column(PickQtyVarGbl; PickQtyVarGbl)
                    { }

                    /*//-->TOM
                    Column(ShiptoAdd1; ShiptoAddr[1])
                    {

                    }
                    Column(ShiptoAdd2; ShiptoAddr[2])
                    {

                    }
                    Column(ShiptoAdd3; ShiptoAddr[3])
                    {

                    }
                    Column(ShiptoAdd4; ShiptoAddr[4])
                    {

                    }
                    Column(ShiptoAdd5; ShiptoAddr[5])
                    {

                    }
                    column(ShippingAgent; SalesHeaderRec."Shipping Agent Code")
                    {

                    }
                    column(ShippingAgentService; SalesHeaderRec."Shipping Agent Service Code")
                    {

                    }
                    //<--
                    */
                    dataitem(WhseActLine2; "Warehouse Activity Line")
                    {
                        DataItemLink = "Activity Type" = FIELD("Activity Type"), "No." = FIELD("No."), "Bin Code" = FIELD("Bin Code"), "Item No." = FIELD("Item No."), "Action Type" = FIELD("Action Type"), "Variant Code" = FIELD("Variant Code"), "Unit of Measure Code" = FIELD("Unit of Measure Code"), "Due Date" = FIELD("Due Date");
                        DataItemLinkReference = WhseActLine;
                        DataItemTableView = SORTING("Activity Type", "No.", "Bin Code", "Breakbulk No.", "Action Type");
                        column(LotNo_WhseActLine2; "Lot No.")
                        {
                        }
                        column(SerialNo_WhseActLine2; "Serial No.")
                        {
                        }
                        column(QtyBase_WhseActLine2; "Qty. (Base)")
                        {
                        }
                        column(QtytoHandle_WhseActLine2; "Qty. to Handle")
                        {
                        }
                        column(LineNo_WhseActLine2; "Line No.")
                        {
                        }
                    }

                    trigger OnAfterGetRecord()
                    var
                        WhseShipmentLineRecLcl: Record "Warehouse Shipment Line";
                        ProdOrderCompRecLcl: Record "Prod. Order Component";
                    begin
                        if SumUpLines then begin
                            TempWhseActivLine.Get("Activity Type", "No.", "Line No.");
                            "Qty. (Base)" := TempWhseActivLine."Qty. (Base)";
                            "Qty. to Handle" := TempWhseActivLine."Qty. to Handle";
                        end;
                        if WhseActLine."Action Type" = WhseActLine."Action Type"::Take then
                            TotalPickQty += "Qty. (Base)";

                        //-->
                        //if SalesHeaderRec.Get(SalesHeaderRec."Document Type"::Order, TempWhseActivLine."Source No.") then
                        //  FormatAddrCU.SalesHeaderShipTo(ShiptoAddr, CustAddr, SalesHeaderRec);
                        //<--

                        // Clear(LineItemRec);
                        // if LineItemRec.Get("Item No.") then;
                        ProdOrderLineRecGbl.Reset();
                        ProdOrderLineRecGbl.SetRange("Prod. Order No.", WhseActLine."Source No.");
                        ProdOrderLineRecGbl.setrange("Line No.", WhseActLine."Source Line No.");
                        IF ProdOrderLineRecGbl.FindFirst() then;

                        clear(ShortQtyVarGbl);
                        clear(TotalQtyVarGbl);
                        Clear(PickQtyVarGbl);
                        if WhseActLine."Action Type" = WhseActLine."Action Type"::Take then begin
                            if WhseActLine."Source Document" = WhseActLine."Source Document"::"Sales Order" then begin
                                WhseShipmentLineRecLcl.Reset();
                                WhseShipmentLineRecLcl.SetRange("No.", WhseActLine."Whse. Document No.");
                                WhseShipmentLineRecLcl.SetRange("Line No.", WhseActLine."Whse. Document Line No.");
                                if WhseShipmentLineRecLcl.FindFirst() then begin
                                    WhseShipmentLineRecLcl.CalcFields("Pick Qty.");
                                    ShortQtyVarGbl := WhseShipmentLineRecLcl.Quantity - WhseShipmentLineRecLcl."Qty. Picked" - WhseShipmentLineRecLcl."Pick Qty.";
                                    TotalQtyVarGbl := WhseShipmentLineRecLcl.Quantity;
                                    PickQtyVarGbl := WhseActLine.Quantity;
                                end;
                            end else
                                if WhseActLine."Source Document" = WhseActLine."Source Document"::"Prod. Consumption" then begin
                                    ProdOrderCompRecLcl.Reset();
                                    ProdOrderCompRecLcl.SetRange("Prod. Order No.", WhseActLine."Source No.");
                                    ProdOrderCompRecLcl.SetRange("Prod. Order Line No.", WhseActLine."Source Line No.");
                                    ProdOrderCompRecLcl.SetRange("Line No.", WhseActLine."Source Subline No.");
                                    if ProdOrderCompRecLcl.FindFirst() then begin
                                        ProdOrderCompRecLcl.CalcFields("Pick Qty.");
                                        ShortQtyVarGbl := ProdOrderCompRecLcl."Expected Quantity" - ProdOrderCompRecLcl."Qty. Picked" - ProdOrderCompRecLcl."Pick Qty.";
                                        TotalQtyVarGbl := ProdOrderCompRecLcl."Expected Quantity";
                                        PickQtyVarGbl := WhseActLine.Quantity;
                                    end;
                                end;

                        end;
                        if WhseActLineItem.Get(WhseActLine."Item No.") then;
                    end;

                    trigger OnPreDataItem()
                    begin
                        Copy("Warehouse Activity Line");
                        Counter := Count;
                        if Counter = 0 then
                            CurrReport.Break();

                        if BreakbulkFilter then
                            SetRange("Original Breakbulk", false);
                    end;
                }
            }
            dataitem("Prod. Order Component"; "Prod. Order Component")
            {
                column(Line_No_; "Line No.")
                { }
                column(Item_No_; "Item No.")
                { }
                column(Description; Description)
                { }
                column(Unit_of_Measure_Code; "Unit of Measure Code")
                { }
                column(Expected_Quantity; "Expected Quantity")
                { }
                column(ShortItemQtyVarGbl; ShortItemQtyVarGbl)
                { }
                column(ProdOrdCompItem_PurchaserCode_Caption; ProdOrdCompItem.FieldCaption("THK Purchaser Code"))
                { }
                column(ProdOrdCompItem_PurchaserCode; ProdOrdCompItem."THK Purchaser Code")
                { }
                trigger OnPreDataItem()
                var
                    WarehouseActLineRecLcl: Record "Warehouse Activity Line";
                begin
                    WarehouseActLineRecLcl.Reset();
                    WarehouseActLineRecLcl.SetRange("No.", "Warehouse Activity Header"."No.");
                    WarehouseActLineRecLcl.setrange("Source Document", WarehouseActLineRecLcl."Source Document"::"Prod. Consumption");
                    if WarehouseActLineRecLcl.FindFirst() then;

                    SetRange("Prod. Order No.", WarehouseActLineRecLcl."Source No.");
                    //SetRange("Line No.", WarehouseActLineRecLcl."Source Line No.");
                    SetRange("Prod. Order Line No.", WarehouseActLineRecLcl."Source Line No.");
                end;

                trigger OnAfterGetRecord()
                var
                    WarehouseActLineRecLcl: Record "Warehouse Activity Line";
                begin
                    WarehouseActLineRecLcl.Reset();
                    WarehouseActLineRecLcl.SetRange("Source No.", "Prod. Order No.");
                    WarehouseActLineRecLcl.SetRange("Source Line No.", "Prod. Order Line No.");
                    WarehouseActLineRecLcl.SetRange("Source Subline No.", "Line No.");
                    if WarehouseActLineRecLcl.FindFirst() then
                        CurrReport.Skip();

                    Clear(ShortItemQtyVarGbl);
                    CalcFields("Pick Qty.");
                    ShortItemQtyVarGbl := "Expected Quantity" - "Qty. Picked" - "Pick Qty.";
                    if ShortItemQtyVarGbl = 0 then
                        CurrReport.Skip();

                    if ProdOrdCompItem.Get("Prod. Order Component"."Item No.") then;
                end;
            }
            dataitem("Sales Line"; "Sales Line")
            {
                column(SalesLine_No_; "Line No.")
                { }
                column(SalesItem_No_; "No.")
                { }
                column(SalesDescription; Description)
                { }
                column(SalesUnit_of_Measure_Code; "Unit of Measure Code")
                { }
                column(SalesExpected_Quantity; Quantity)
                { }
                column(SalesShortItemQtyVarGbl; ShortSalesItemQtyVarGbl)
                { }
                column(SalesLineItem_PurchaserCode; SalesLineItem."THK Purchaser Code")
                { }
                trigger OnPreDataItem()
                var
                    WarehouseActLineRecLcl: Record "Warehouse Activity Line";
                begin
                    WarehouseActLineRecLcl.Reset();
                    WarehouseActLineRecLcl.SetRange("No.", "Warehouse Activity Header"."No.");
                    WarehouseActLineRecLcl.setrange("Source Document", WarehouseActLineRecLcl."Source Document"::"Sales Order");
                    if WarehouseActLineRecLcl.FindFirst() then;

                    SetRange("Document No.", WarehouseActLineRecLcl."Source No.");
                    //SetRange("Line No.", WarehouseActLineRecLcl."Source Line No.");
                end;

                trigger OnAfterGetRecord()
                var
                    WarehouseActLineRecLcl: Record "Warehouse Activity Line";
                    WhseShipmentLineRecLcl: Record "Warehouse Shipment Line";
                begin
                    WarehouseActLineRecLcl.Reset();
                    WarehouseActLineRecLcl.SetRange("Source No.", "Document No.");
                    WarehouseActLineRecLcl.SetRange("Source Line No.", "Line No.");
                    if WarehouseActLineRecLcl.FindFirst() then
                        CurrReport.Skip();

                    clear(ShortSalesItemQtyVarGbl);
                    WhseShipmentLineRecLcl.Reset();
                    WhseShipmentLineRecLcl.SetRange("Source No.", "Document No.");
                    WhseShipmentLineRecLcl.SetRange("Source Line No.", "Line No.");
                    if WhseShipmentLineRecLcl.FindFirst() then begin
                        WhseShipmentLineRecLcl.CalcFields("Pick Qty.");
                        ShortSalesItemQtyVarGbl := WhseShipmentLineRecLcl.Quantity - WhseShipmentLineRecLcl."Qty. Picked" - WhseShipmentLineRecLcl."Pick Qty.";
                    end;

                    if ShortSalesItemQtyVarGbl = 0 then
                        CurrReport.Skip();

                    if SalesLineItem.Get("Sales Line"."No.") then;
                end;

            }
            trigger OnAfterGetRecord()
            var

                BarCodeSymbology: Enum "Barcode Symbology";//TOM
                BarCodeFontProvider: Interface "Barcode Font Provider";//TOM
                BarCodeString: text;//TOM
            begin
                GetLocation("Location Code");
                InvtPick := Type = Type::"Invt. Pick";
                if InvtPick then
                    BreakbulkFilter := false
                else
                    BreakbulkFilter := "Breakbulk Filter";

                if not IsReportInPreviewMode then
                    CODEUNIT.Run(CODEUNIT::"Whse.-Printed", "Warehouse Activity Header");

                //TOM-->
                WhseActLineRec.Reset();
                WhseActLineRec.SetRange("No.", "Warehouse Activity Header"."No.");
                if WhseActLineRec.FindFirst() then
                    if WhseActLineRec."Source Document" = WhseActLineRec."Source Document"::"Sales Order" then begin
                        if SalesHeaderRec.Get(SalesHeaderRec."Document Type"::Order, WhseActLineRec."Source No.") then
                            //FormatAddrCU.SalesHeaderShipTo(ShiptoAddr, CustAddr, SalesHeaderRec);
                            FormatAddrCU.FormatAddr(
              ShiptoAddr, SalesHeaderRec."Ship-to Name", SalesHeaderRec."Ship-to Name 2", '', SalesHeaderRec."Ship-to Address", SalesHeaderRec."Ship-to Address 2",
              SalesHeaderRec."Ship-to City", SalesHeaderRec."Ship-to Post Code", SalesHeaderRec."Ship-to County", SalesHeaderRec."Ship-to Country/Region Code");
                    end else
                        if WhseActLineRec."Source Document" = WhseActLineRec."Source Document"::"Outbound Transfer" then begin
                            if TransHeaderRec.get(WhseActLineRec."Source No.") then
                                FormatAddrCU.TransferHeaderTransferTo(ShiptoAddr, TransHeaderRec);
                        end else
                            if WhseActLineRec."Source Document" = WhseActLineRec."Source Document"::"Prod. Consumption" then begin
                                ProdHdrRec.reset;
                                ProdHdrRec.SetRange("No.", WhseActLineRec."Source No.");
                                if ProdHdrRec.FindFirst() then
                                    if LocationRec.Get(ProdHdrRec."Location Code") then
                                        FormatAddrCU.FormatAddr(ShiptoAddr, LocationRec.Name, LocationRec."Name 2", LocationRec.Contact, LocationRec.Address,
                                        LocationRec."Address 2", LocationRec.City, LocationRec."Post Code", LocationRec.County, LocationRec."Country/Region Code");
                            end;

                //For Transfer Orders, please use the Address for Transfer To Location
                //For Production orders, use the Address from Location card.
                BarCodeFontProvider := Enum::"Barcode Font Provider"::IDAutomation1D;
                BarCodeSymbology := Enum::"Barcode Symbology"::Code39;
                BarCodeString := WhseActLineRec."Source No.";
                BarCodeFontProvider.ValidateInput(BarCodeString, BarCodeSymbology);
                BarCodeTxt := BarCodeFontProvider.EncodeFont(BarCodeString, BarCodeSymbology); //'*' + SalesHeaderRec."No." + '*';//
                //<--TOM

                BarCodeFontProvider := Enum::"Barcode Font Provider"::IDAutomation1D;
                BarCodeSymbology := Enum::"Barcode Symbology"::Code39;
                BarCodeString := WhseActLineRec."No.";
                BarCodeFontProvider.ValidateInput(BarCodeString, BarCodeSymbology);
                BarCodePickTxt := BarCodeFontProvider.EncodeFont(BarCodeString, BarCodeSymbology);


                WhseActLineRec.Reset();
                WhseActLineRec.SetRange("No.", "Warehouse Activity Header"."No.");
                WhseActLineRec.SetFilter("Whse. Document No.", '<>%1', '');
                if WhseActLineRec.FindFirst() then begin
                    if not WhseShptHeadRecGbl.get(WhseActLineRec."Whse. Document No.") then
                        WhseShptHeadRecGbl.Init();
                end;

                clear(ItemRec);
                clear(ProdOrder);
                ProdOrder.SetRange("No.", "Warehouse Activity Header"."TOMSourceNo.");
                if ProdOrder.Findfirst() then
                    If ItemRec.Get(ProdOrder."Source No.") then;
            end;
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(Breakbulk; BreakbulkFilter)
                    {
                        ApplicationArea = Warehouse;
                        Caption = 'Set Breakbulk Filter';
                        Editable = BreakbulkEditable;
                        ToolTip = 'Specifies if you do not want to view the intermediate lines that are created when the unit of measure is changed in pick instructions.';
                    }
                    field(SumUpLines; SumUpLines)
                    {
                        ApplicationArea = Warehouse;
                        Caption = 'Sum up Lines';
                        Editable = SumUpLinesEditable;
                        ToolTip = 'Specifies if you want the lines to be summed up for each item, such as several pick lines that originate from different source documents that concern the same item and bins.';
                    }
                    field(LotSerialNo; ShowLotSN)
                    {
                        ApplicationArea = Warehouse;
                        Caption = 'Show Serial/Lot Number';
                        ToolTip = 'Specifies if you want to show lot and serial number information for items that use item tracking.';
                    }
                    field(SortByItem; SortByItem)
                    {
                        ApplicationArea = All;
                        Caption = 'Sort By Item';
                    }
                }
            }
        }

        actions
        {
        }

        trigger OnInit()
        begin
            SumUpLinesEditable := true;
            BreakbulkEditable := true;
            SortByItem := false;
        end;

        trigger OnOpenPage()
        begin
            if HideOptions then begin
                BreakbulkEditable := false;
                SumUpLinesEditable := false;
            end;
        end;
    }

    labels
    {
    }

    trigger OnPreReport()
    begin
        //PickFilter := "Warehouse Activity Header".GetFilters;
        PickFilter := "Warehouse Activity Header".GetFilter(Type);
        PickFilter := PickFilter + 'No.: ';
    end;

    var
        Location: Record Location;
        TempWhseActivLine: Record "Warehouse Activity Line" temporary;
        ProdOrderLineRecGbl: Record "Prod. Order Line";
        PickFilter: Text;
        BreakbulkFilter: Boolean;
        SumUpLines: Boolean;
        HideOptions: Boolean;
        InvtPick: Boolean;
        ShowLotSN: Boolean;
        Counter: Integer;
        [InDataSet]
        BreakbulkEditable: Boolean;
        [InDataSet]
        SumUpLinesEditable: Boolean;
        ShortQtyVarGbl: Decimal;
        ShortItemQtyVarGbl: Decimal;
        ShortSalesItemQtyVarGbl: Decimal;
        CurrReportPageNoCaptionLbl: Label 'Page';
        PickingListCaptionLbl: Label 'Picking List';
        WhseActLineDueDateCaptionLbl: Label 'Due Date';
        QtyHandledCaptionLbl: Label 'Short Qty';
        ItemsShortLbl: Label 'Short Items for pick';
        EmptyStringCaptionLbl: Label '____________';
        SalesHeaderRec: Record "Sales Header"; //TOM
        ShiptoAddr: Array[8] of Text[50]; //TOM
        CustAddr: Array[8] of Text[50]; //TOM
        FormatAddrCU: Codeunit "Format Address";//TOM
        WhseActLineRec: Record "Warehouse Activity Line";//TOM
        BarCodeTxt: Text[100]; //TOM
        BarCodePickTxt: Text[100];
        TransHeaderRec: record "Transfer Header";//TOM
        ProdHdrRec: Record "Production Order";//TOM
        LocationRec: Record Location; //TOM
        tempWHSEHdr: Record "Warehouse Shipment Header" temporary;
        TotalPickQty: Decimal;
        TotalWhseQty: Decimal;
        SortByItem: Boolean;
        WhseShptHeadRecGbl: Record "Warehouse Shipment Header";
        ItemRec: Record Item;
        LineItemRec: Record Item;
        BomNoCaptionLbl: Label 'BOM No.';
        ProdOrder: Record "Production Order";
        TotalQtyVarGbl: Decimal;
        PickQtyVarGbl: Decimal;
        WhseActLineItem, SalesLineItem, ProdOrdCompItem : Record Item;
        PurchaserCodeCaptionLbl: Label 'Purchaser Code';


    local procedure GetLocation(LocationCode: Code[10])
    begin
        if LocationCode = '' then
            Location.Init
        else
            if Location.Code <> LocationCode then
                Location.Get(LocationCode);
    end;

    local procedure IsReportInPreviewMode(): Boolean
    var
        MailManagement: Codeunit "Mail Management";
    begin
        exit(CurrReport.Preview or MailManagement.IsHandlingGetEmailBody);
    end;

    procedure SetBreakbulkFilter(BreakbulkFilter2: Boolean)
    begin
        BreakbulkFilter := BreakbulkFilter2;
    end;

    procedure SetInventory(SetHideOptions: Boolean)
    begin
        HideOptions := SetHideOptions;
    end;

    local procedure GetWhseShipmentQty(DocNo: Code[20]): Decimal
    var
        WHSELine: Record "Warehouse Shipment Line";
    begin
        WHSELine.SetRange("No.", DocNo);
        WHSELine.CalcSums(Quantity);
        exit(WHSELine.Quantity);
    end;
}

