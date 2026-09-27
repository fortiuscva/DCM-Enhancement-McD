pageextension 50144 TOMApplyCustomerEntries extends "Apply Customer Entries"
{
    layout
    {
        addafter("Customer Name")
        {
            field(TOMCustomerPONo; Rec."External Document No.")
            {
                ApplicationArea = All;
                Caption = 'Customer PO No.';
            }
        }
    }
}
