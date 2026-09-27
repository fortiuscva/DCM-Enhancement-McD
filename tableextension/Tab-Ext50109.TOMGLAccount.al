tableextension 50109 "TOMGLAccount" extends "G/L Account"
{
    /*
     TOM 1.14 11122021 Change caption of field "No. 2"
     TOM 1.18 11152021 Updated the "No 2" field to say "Legacy Acct No."
    */
    fields
    {
        modify("No. 2")
        {
            CaptionML = ENU = 'Legacy Acct No.';

        }
    }
}
