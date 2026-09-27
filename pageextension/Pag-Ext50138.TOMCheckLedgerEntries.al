pageextension 50138 TOMCheckLedgerEntries extends "Check Ledger Entries"
{
    layout
    {
        addafter(Amount)
        {
            field("Bank Account Ledger Entry No.";Rec."Bank Account Ledger Entry No.")
            {
                ApplicationArea= All;
            }
            field("Check Type";Rec."Check Type")
            {
                ApplicationArea = All;
            }
            field(Open;Rec.Open)
            {
                ApplicationArea = All;
            }
            field("Positive Pay Exported";Rec."Positive Pay Exported")
            {
                ApplicationArea = All;
            }
            field("Transmission File Name";Rec."Transmission File Name")
            {
                ApplicationArea= All;
            }
            field("Statement Status";Rec."Statement Status")
            {
                ApplicationArea= All;
            }
            field("Statement No.";Rec."Statement No.")
            {
                ApplicationArea = All;
            }
            field("Statement Line No.";Rec."Statement Line No.")
            {
                ApplicationArea = All;
            }
            field("User ID";Rec."User ID")
            {
                ApplicationArea = All;
            }
        }
    }
}
