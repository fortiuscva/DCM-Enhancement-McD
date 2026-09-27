pageextension 50122 "TOMPurchQuoteList" extends "Purchase Quotes"
{
    layout
    {
        //TOM 1.38 03202022 MK Created extension to add new field Quote expiration date
        addafter("Assigned User ID")
        {
            field("Quote Expiration Date"; Rec."Quote Expiration Date")
            {
                ApplicationArea = all;
            }
        }
    }
}
