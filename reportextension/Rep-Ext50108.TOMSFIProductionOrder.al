reportextension 50108 "TOMSFIProductionOrder" extends "SFI Production Order"
{
    //RDLCLayout = './reportlayout/TOMSFIProductionOrder.rdl';
    dataset
    {

        modify("Prod. Order Component")
        {
            trigger OnBeforeAfterGetRecord()
            var

                BinContent: Record "Bin Content";
                MaxQty: Decimal;
            begin
                /*
                clear(MaxQty);
                Clear(BinCode);
                BinContent.Reset();
                BinContent.SetRange("Item No.", "Item No.");
                BinContent.SetFilter("Bin Code", '<>%1&<>%2', 'CON', 'CON-ASSY');
                BinContent.SetAutoCalcFields(Quantity);
                if BinContent.FindSet() then
                    repeat
                        if MaxQty < BinContent.Quantity then begin
                            MaxQty := BinContent.Quantity;
                            BinCode := BinContent."Bin Code";
                        end;
                    until BinContent.Next() = 0;
                if BinCode = '' then begin
                    BinContent.SetRange(Default, true);
                    if BinContent.FindFirst() then
                        BinCode := BinContent."Bin Code";
                end;

                WmsManagementCULcl.GetDefaultBin("Item No.", "Variant Code", "Location Code", BinCode);
                */
                Clear(BinCode);
                BinContent.Reset();
                BinContent.SetRange("Item No.", "Item No.");
                BinContent.SetRange("Location Code", "Location Code");
                BinContent.SetFilter("Bin Code", '<>%1&<>%2', 'CON', 'CON-ASSY');
                BinContent.SetRange(Default, true);
                if BinContent.FindFirst() then
                    BinCode := BinContent."Bin Code";

            end;
        }
        modify("Production Order")
        {
            trigger OnBeforeAfterGetRecord()
            var
                ResEntry: Record "Reservation Entry";
                ResEntry1: Record "Reservation Entry";
                SONo: Code[20];
                SalesHeader: Record "Sales Header";

            begin
                clear(CustomerName);
                if "Source Type" = "Source Type"::Item then begin
                    ResEntry.Reset();
                    ResEntry.SetRange("Source ID", "No.");
                    ResEntry.SetRange("Item No.", "Source No.");
                    if ResEntry.FindFirst() then begin
                        ResEntry1.Reset();
                        ResEntry1.SetRange("Entry No.", ResEntry."Entry No.");
                        ResEntry1.SetRange("Source Type", 37);
                        if ResEntry1.FindFirst() then
                            SONo := ResEntry1."Source ID";
                    end;
                end else
                    if "Source Type" = "Source Type"::"Sales Header" then
                        SONo := "Source No.";
                if SalesHeader.get(SalesHeader."Document Type"::Order, SONo) then
                    CustomerName := SalesHeader."Sell-to Customer Name";
            end;
        }
        add("Production Order")
        {
            column(CustomerName; CustomerName)
            {

            }
            column(SFIProdOrder_Location_Code; "Location Code")
            {

            }
            column(SFIProdOrder_Bin_Code; "Bin Code")
            {

            }
        }
        add("Prod. Order Line")
        {
            column(Production_BOM_No_; "Production BOM No.") { }
            column(Production_BOM_Version_Code; "Production BOM Version Code") { }
            column(Routing_No_; "Routing No.") { }
            column(Routing_Version_Code; "Routing Version Code") { }
            column(NumberLbl; NumberLbl) { }
            column(DescriptionLbl; DescriptionLbl) { }
        }
        add("Prod. Order Component")
        {
            column(ProdOrderComponent_BinCode; "Bin Code")
            {

            }
            column(ProdOrderComponent_UOM; "Unit of Measure Code")
            {

            }
            column(Bin_Code; BinCode)
            {

            }
            //TOM 1.55
            column(ExpectedQtyBase; "Expected Qty. (Base)")
            {

            }
            //<--TOM 1.55

        }
    }
    rendering
    {
        layout(TOMSFIProductionOrder)
        {
            Type = RDLC;
            Caption = 'TOMSFIProductionOrder';
            Summary = 'Regular Job card';
            LayoutFile = './reportlayout/TOMSFIProductionOrder.rdl';
        }
        layout(TOMSFIPLYMProductionOrder)
        {
            Type = RDLC;
            Caption = 'TOMSFIPLYMProductionOrder';
            Summary = 'Regular Job card';
            LayoutFile = './reportlayout/TOMSFIPLYMProductionOrder.rdl';
        }
    }
    var
        BinCode: Code[20];
        CustomerName: Text[100];
        NumberLbl: Label 'No.';
        DescriptionLbl: Label 'Description';
}
