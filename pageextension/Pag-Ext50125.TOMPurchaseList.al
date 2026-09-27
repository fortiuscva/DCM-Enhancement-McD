pageextension 50125 "TOMPurchaseList" extends "Purchase Order List"
{
    layout
    {
        //TOM 1.37 03202022 MK Created extension to add new field Vendor Status
        addafter("Amount Including VAT")
        {
            field("Vendor Status"; Rec."Vendor Status")
            {
                ApplicationArea = all;
            }
        }
    }
}
