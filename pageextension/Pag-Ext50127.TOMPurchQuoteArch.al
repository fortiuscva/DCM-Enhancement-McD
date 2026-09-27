pageextension 50127 "TOMPurchQuoteArch" extends "Purchase Quote Archive"
{
    layout
    {
        //TOM 1.37 03202022 MK Created extension to add new field Vendor Status
        addlast(General)
        {
            field("Quote Expiration Date"; Rec."Quote Expiration Date")
            {
                ApplicationArea = all;
            }
        }
    }
}
