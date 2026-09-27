pageextension 50140 "TOMItemLedgerEntries" extends "Item Ledger Entries"
{
    layout
    {
        moveafter("Document No."; "Source Type")
        moveafter("Document No."; "Source No.")
        modify("Source Type")
        {
            Visible = true;
        }
        modify("Source No.")
        {
            Visible = true;
        }
    }
}
