tableextension 50104 "CustLedgEntry" extends "Cust. Ledger Entry"
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
    }
}
