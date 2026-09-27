pageextension 50128 "TOMPurchQuArcList" extends "Purchase Quote Archives"
{
    //TOM 1.39 Added field to purchase quote archive
    layout
    {
        //TOM 1.37 03202022 MK Created extension to add new field Vendor Status
        addafter("Location Code")
        {
            field("Quote Expiration Date"; rec."Quote Expiration Date")
            {
                ApplicationArea = all;
            }
        }
    }
}
