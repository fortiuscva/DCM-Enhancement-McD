reportextension 50111 TOMStdSalesOrderConf extends "Standard Sales - Order Conf."
{
    dataset
    {
        add(Header)
        {
            column(TaxExemptionNo; TaxExemptionNo)
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
            column(RemitToCity; CompInfo."Remit-To City")
            {

            }
            column(RemitToState; CompInfo."Remit-To COunty")
            {

            }
            column(RemitToPostCode; CompInfo."Remit-To Post Code")
            {

            }
            column(RemitToCountryRegion; CompInfo."Remit-To Country/Region Code")
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
            column(ShipmentAgentCode; "Shipping Agent Code")
            {
            }
            column(ShippingAgentCodeLbl; ShippingAgentCodeLbl)
            {

            }
            column(Amount_Including_VAT; "Amount Including VAT")
            {

            }
            column(TaxAmount; "Amount Including VAT" - Amount)
            { }
            column(AmountSubTax; AmountSubTax)
            { }
            column(AmountExemptTax; AmountExemptTax)
            { }
            column(Customer_PO_Caption; Customer_PO_CaptionLbl)
            { }
            column(BillTo_Caption; BillTo_CaptionLbl)
            { }
            column(AmtSubjecttoVat_Caption; AmtSubjecttoVat_CaptionLbl)
            { }
            column(AmtExemptfromVat_Caption; AmtExemptfromVat_CaptionLbl)
            { }
            column(Document_Title; DocumentTitle)
            { }
        }
        add(Line)
        {
            column(Currency_Code; "Currency Code")
            {

            }
            column(CurrencyCodeLbl; CurrencyCodeLbl)
            {

            }
        }
        modify(Header)
        {
            trigger OnBeforeAfterGetRecord()
            begin
                CompInfo.get;
                TaxExemptionNo := CompInfo."Tax Exemption No.";
                RemitToCityStateZip := CompInfo."Remit-To City";
                If CompInfo."Remit-To County" <> '' then
                    RemitToCityStateZip += ', ' + CompInfo."Remit-To County";
                If CompInfo."Remit-To Post Code" <> '' then
                    RemitToCityStateZip += ', ' + CompInfo."Remit-To Post Code";

                CalcFields(Amount, "Amount Including VAT");
                if "Amount Including VAT" - Amount <> 0 then
                    AmountSubTax := Amount
                else
                    AmountExemptTax := Amount;

            end;

        }
    }
    rendering
    {
        layout(Order_Confirmation_RDLC)
        {
            Type = RDLC;
            Caption = 'Order Confirmation';
            LayoutFile = './reportlayout/StandardSalesOrderConf.rdl';
        }
    }
    var
        TaxExemptionNo: Text[30];

        CompInfo: Record "Company Information";
        RemitToCityStateZip: Text[250];
        ShippingAgentCodeLbl: Label 'Shipping Agent Code';
        CurrencyCodeLbl: Label 'Currency Code';
        AmountSubTax: Decimal;
        AmountExemptTax: Decimal;
        Customer_PO_CaptionLbl: Label 'Customer PO Number';
        BillTo_CaptionLbl: Label 'Bill-To';
        AmtSubjecttoVat_CaptionLbl: Label 'Amount Subject To VAT';
        AmtExemptfromVat_CaptionLbl: Label 'Amount Exempt From VAT';
        DocumentTitle: Label 'Order Acknowledgement';
}
