reportextension 50101 "TOMStdSalesShipment" extends "Standard Sales - Shipment"
{
    /*
    TOM 1.16 12072021 Added new field EORI No.
    */
    dataset
    {
        add(Header)
        {
            column(EORINo; EORINo)
            {

            }
            column(ShippedFrom; ShiippedFromVar)
            {

            }
            column(LAX_E_Ship_Agent_Service;"LAX E-Ship Agent Service")
            {

            }
            column(Shipping_Agent_Code;"Shipping Agent Code")
            {

            }

        }
        modify(Header)
        {
            trigger OnBeforeAfterGetRecord()
            var
                Customer: Record Customer;
            begin
                if customer.get("Sell-to Customer No.") then
                    EORINo := Customer."EORI Number";
                if LocationRec.get("Location Code") then
                    ShiippedFromVar := LocationRec.Name + ' ' + LocationRec.Address + ' ' + LocationRec.City + ' ' + LocationRec."Post Code"
                    + ' ' + LocationRec.County + ' ' + LocationRec."Country/Region Code";

            end;
        }
    }
    Var
        EORINo: Text[30];
        ShiippedFromVar: text[1024];
        LocationRec: Record Location;

}