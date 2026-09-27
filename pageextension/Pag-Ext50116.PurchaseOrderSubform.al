pageextension 50116 "PurchaseOrderSubform" extends "Purchase Order Subform"
{
    layout
    {
        /*

       TOM 1.31 On Sales Oder Lines and Purchase Order Lines expose the Line No. field so user can display it on the line section the order
        
        */
        addbefore("No.")
        {
            field(LineNo; Rec."Line No.")
            {
                ApplicationArea = All;
            }
            field("Sent to Contractor"; rec."Sent to Contractor")
            {
                ApplicationArea = All;
            }

        }

    }
}
