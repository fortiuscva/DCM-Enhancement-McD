pageextension 50121 "TOMPurchaseQuote" extends "purchase quote"
{
    //TOM 1.38 03202022 MK Created extension to add new field Quote Expiration Date
    layout
    {
        // Adding a new control field Quote Expiration Date in the group 'General'
        addlast(General)
        {
            field("Quote Expiration Date"; Rec."Quote Expiration Date")
            {
                ApplicationArea = all;
            }
        }
    }
}
