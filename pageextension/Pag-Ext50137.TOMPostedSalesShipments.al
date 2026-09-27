pageextension 50137 TOMPostedSalesShipments extends "Posted Sales Shipments"
{
    layout
    {
       addafter("Location Code")
       {
        field("Order No.";Rec."Order No.")
        {
            ApplicationArea = All;
        }
       }     
    }
}
