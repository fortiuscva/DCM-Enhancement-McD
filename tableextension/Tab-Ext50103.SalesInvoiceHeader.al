tableextension 50103 "SalesInvoiceHeader" extends "Sales Invoice Header"
{
    /*
    TOM 1.13 11122021 Change caption of field "External Document No."
    */
    fields
    {
        modify("External Document No.")
        {
            CaptionML = ENU = 'Customer PO No.';


        }
        field(50150; "TOM Pick Notes"; Text[100])
        {
            Caption = 'Pick Notes';
        }
    }
}
