reportextension 50102 "TOMSalesInvoice" extends "Standard Sales - Invoice"
{
    /*
    TOM 1.12 11122021 Added new field External Document No.
    TOM 1.15 12072021 Added new field EORI No.
    */
    RDLCLayout = './reportlayout/TOMSalesInvoiceMfg.rdl'; //PS 05172022 Created rdlc layout
    //RDLCLayout = './reportlayout/1306-000008_Tom Sales Invoice.rdl';
    dataset
    {
        add(Header)
        {
            column(External_Document_No_; 'Reference Tomahawk Manufacturing ' + "External Document No.")
            {
            }
            column(EORINo; EORINo)
            {

            }
            column(ExternalTrackingNo; PostedPackageRec."External Tracking No.") //PS
            {

            }
            column(ShippingAgentService; "Shipping Agent Code" + ' ' + "LAX E-Ship Agent Service")  //PS
            {

            }
            column(TotalTaxAmt; TotalTaxAmt)
            {

            }

            column(RemitToName; CompInfo."Remit-To Name")
            {

            }

            column(RemitToAddress; CompInfo."Remit-To Address")
            {

            }
            column(RemitToAddress2; CompInfo."Remit-To Address 2")
            {

            }
            column(RemitToCity; UPPERCASE(COPYSTR(CompInfo."Remit-To City", 1, 1)) + LOWERCASE(COPYSTR(CompInfo."Remit-To City", 2)))
            {

            }
            column(RemitToState; CompInfo."Remit-To COunty")
            {

            }
            column(RemitToPostCode; CompInfo."Remit-To Post Code")
            {

            }
            column(RemitToCountryRegion; countryRegion.Name)
            {

            }
            column(Shipping_Agent_Code; "Shipping Agent Code")
            {

            }
            column(RemitToCityStateZip; RemitToCityStateZip)
            {

            }
            column(LAX_E_Ship_Agent_Service; "LAX E-Ship Agent Service")
            {

            }
            column(THKDueDateE; "Due Date")
            {
            }
            column(THKShipmentDate; HeaderShipmentDate)
            {
            }
        }
        add(Line)
        {
            column(LineAmount; "Line AMount")
            {

            }
            column(THKActualShipmetnDate; SalesShipmentDate)
            {

            }
        }
        modify(line)
        {
            trigger OnAfterAfterGetRecord()
            var
                SalesShipmentLine: Record "Sales Shipment Line";
                SalesShptLine: Record "Sales Shipment Line";
                ItemLedgEntry: Record "Item Ledger Entry";
                ValueEntry: Record "Value Entry";
                td: Date;
            begin
                SalesShipmentDate := GetSalesShipmentPostingDate(Line);
            end;
        }
        modify(Header)
        {
            trigger OnBeforeAfterGetRecord()
            var
                Customer: Record Customer;
                TempSalesShptLineRecLcl: Record "Sales Shipment Line" temporary;
                SalesInvLineRecLcl: Record "Sales Invoice Line";
                TrackingFoundVarLcl: Boolean;
            begin
                CompInfo.Get;
                RemitToCityStateZip := UPPERCASE(COPYSTR(CompInfo."Remit-To City", 1, 1)) + LOWERCASE(COPYSTR(CompInfo."Remit-To City", 2));
                If CompInfo."Remit-To County" <> '' then
                    RemitToCityStateZip += ', ' + CompInfo."Remit-To County";
                If CompInfo."Remit-To Post Code" <> '' then
                    RemitToCityStateZip += ' ' + CompInfo."Remit-To Post Code";
                if countryRegion.Get(CompInfo."Remit-To Country/Region Code") then;
                if customer.get("Sell-to Customer No.") then
                    EORINo := Customer."EORI Number";


                PostedPackageRec.Init();
                if "Order No." <> '' then begin
                    //-->PS
                    PostedPackageRec.reset;
                    PostedPackageRec.SetRange("Source ID", "order No.");
                    if not PostedPackageRec.FindFirst() then
                        PostedPackageRec.Init();
                end;
                //<--PS

                TrackingFoundVarLcl := false;
                SalesInvLineRecLcl.reset;
                SalesInvLineRecLcl.SetRange("Document No.", Header."No.");
                SalesInvLineRecLcl.SetRange(Type, SalesInvLineRecLcl.Type::Item);
                SalesInvLineRecLcl.SetFilter("No.", '<>%1', '');
                SalesInvLineRecLcl.SetFilter(Quantity, '<>%1', 0);
                if SalesInvLineRecLcl.FindSet() then
                    repeat
                        Clear(TempSalesShptLineRecLcl);
                        TempSalesShptLineRecLcl.DeleteAll();
                        SalesInvLineRecLcl.GetSalesShptLines(TempSalesShptLineRecLcl);
                        if TempSalesShptLineRecLcl.FindFirst() then begin
                            PostedPackageRec.reset;
                            PostedPackageRec.SetRange("Posted Source ID", TempSalesShptLineRecLcl."Document No.");
                            if not PostedPackageRec.FindFirst() then
                                PostedPackageRec.Init();
                            TrackingFoundVarLcl := true;
                        end;
                    until (SalesInvLineRecLcl.Next() = 0) or TrackingFoundVarLcl;


                //-->PS
                SalInvLine.reset;
                SalInvLine.SetRange("Document No.", Header."No.");
                if SalInvLine.FindFirst() then
                    repeat
                        if SalInvLine."Amount Including VAT" <> 0 then
                            TotalTaxAmt += SalInvLine."Amount Including VAT" - SalInvLine.Amount;
                    until SalInvLine.Next() = 0;

                //<--PS
                HeaderShipmentDate := 0D;
                SalInvLine.reset;
                SalInvLine.SetRange("Document No.", Header."No.");
                if SalInvLine.FindFirst() then
                    HeaderShipmentDate := GetSalesShipmentPostingDate(SalInvLine);
            end;
        }

    }
    /// <summary>
    /// GetSalesShipmentPostingDate.
    /// </summary>
    /// <param name="SalesInvoiceLine">Record "Sales Invoice Line".</param>
    /// <returns>Return value of type Date.</returns>
    procedure GetSalesShipmentPostingDate(SalesInvoiceLine: Record "Sales Invoice Line"): Date
    var
        SalesShptLine: Record "Sales Shipment Line";
        ItemLedgEntry: Record "Item Ledger Entry";
        ValueEntry: Record "Value Entry";
    begin

        if SalesInvoiceLine.Type <> SalesInvoiceLine.Type::Item then
            exit;

        //FilterPstdDocLineValueEntries(ValueEntry);
        ValueEntry.Reset();
        ValueEntry.SetCurrentKey("Document No.");
        ValueEntry.SetRange("Document No.", SalesInvoiceLine."Document No.");
        ValueEntry.SetRange("Document Type", ValueEntry."Document Type"::"Sales Invoice");
        ValueEntry.SetRange("Document Line No.", SalesInvoiceLine."Line No.");
        if ValueEntry.FindSet() then
            repeat
                ItemLedgEntry.Get(ValueEntry."Item Ledger Entry No.");
                if ItemLedgEntry."Document Type" = ItemLedgEntry."Document Type"::"Sales Shipment" then
                    if SalesShptLine.Get(ItemLedgEntry."Document No.", ItemLedgEntry."Document Line No.") then
                        exit(SalesShptLine."Posting Date");

            until ValueEntry.Next() = 0;
    end;

    Var
        countryRegion: Record "Country/Region";
        EORINo: Text[30];
        PostedPackageRec: Record "LAX Posted Package";
        PSVar: Text[30];
        SalInvLine: Record "Sales Invoice Line";
        TotalTaxAmt: Decimal;
        CompInfo: record "Company Information";
        RemitToCityStateZip: Text[250];
        SalesShipmentDate: Date;
        HeaderShipmentDate: Date;
}
