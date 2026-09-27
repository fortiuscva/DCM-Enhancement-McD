pageextension 50142 TOMPostedSalesInvoiceLines extends "Posted Sales Invoice Lines"
{
    layout
    {
        addafter("Amount Including VAT")
        {
            field("Gen. Bus. Posting Group"; Rec."Gen. Bus. Posting Group")
            {
                ApplicationArea = All;
            }
            field("Gen. Prod. Posting Group"; Rec."Gen. Prod. Posting Group")
            {
                ApplicationArea = All;
            }
        }
    }
}
