tableextension 50115 "TOMPurchHdrArch" extends "Purchase Header Archive"
{
    //TOM 1.39 Added field to purchase quote archive
    fields
    {
        field(50101; "Quote Expiration Date"; Date)
        {
            Caption = 'Quote Expiration Date';
            DataClassification = ToBeClassified;
        }
    }
}
