pageextension 50120 "TOMPurchasePay" extends "Purchases & Payables Setup"
{
    //TOM 1.36 03202022 MK Created extension to add new field Sub Contract Purchase Order Nos, it is used to create purchase order with different no series.
    layout
    {
        // Adding a new control field 'ShoeSize' in the group 'General'
        addafter("Price List Nos.")
        {
            field("Subcontract Purch Order Nos."; Rec."Subcontract Purch Order Nos.")
            {
                Caption = 'Subcontracting Purchase Order Nos.';
                ApplicationArea = all;
            }
        }
    }
}