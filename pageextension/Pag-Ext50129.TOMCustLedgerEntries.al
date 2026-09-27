pageextension 50129 TOMCustLedgerEntries extends "Customer Ledger Entries"
{
    //TOM 1.48 04102022 Added base field "Sell-to Customer No."
    layout
    {
        addafter(Description)
        {
            field("Sell-to Customer No."; rec."Sell-to Customer No.")
            {
                ApplicationArea = All;
            }
        }
    }
}
