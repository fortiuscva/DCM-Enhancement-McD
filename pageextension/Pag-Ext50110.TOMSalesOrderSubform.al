pageextension 50110 "TOMSalesOrderSubform" extends "Sales Order Subform"
{
    /*
    TOM 1.19 12202021 Expose field for General Product Posting Group (to allow for Warranty orders) in two areas.
    */
    layout
    {
        addbefore("No.")
        {
            /*
            TOM 1.31 On Sales Oder Lines and Purchase Order Lines expose the Line No. field so user can display it on the line section the order
            */
            field(LineNo; Rec."Line No.")
            {
                ApplicationArea = All;
            }

        }
        modify("Gen. Prod. Posting Group")
        {
            Visible = true;
        }
        /*
        TOM 1.30 "Prevent the same item number from being entered in the sales order lines section of Sales Orders"
        */
        modify("No.")
        {
            trigger OnBeforeValidate()
            begin
                //CheckIfItemIsDuplicated
            end;
        }
    }
    /*
       TOM 1.30 "Prevent the same item number from being entered in the sales order lines section of Sales Orders"
    */
    local procedure CheckIfItemIsDuplicated()
    var
        sl: Record "Sales Line";
    begin
        if (Rec.Type <> Rec.Type::Item) or (Rec."No." = '') then exit;
        sl.SetFilter("Line No.", '<>%1', Rec."Line No.");
        sl.SetRange("Document No.", Rec."Document No.");
        sl.SetRange("No.", Rec."No.");
        sl.SetRange(Type, Rec.Type::Item);
        if not sl.IsEmpty then
            Error('Item No. %1 is duplicated', Rec."No.");
    end;
}