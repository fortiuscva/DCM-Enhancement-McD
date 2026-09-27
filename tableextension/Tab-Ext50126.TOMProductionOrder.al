tableextension 50126 "TOMProduction Order" extends "Production Order"
{
    fields
    {
        field(50000; "THK Sub-Contractor PO Lines"; Integer)
        {
            Caption = 'Sub-Contractor PO Lines';
            FieldClass = FlowField;
            CalcFormula = count("Purchase Line" where("Prod. Order No." = field("No.")));
            Editable = false;
        }
        field(50001; "THK Transfer Order Lines"; Integer)
        {
            Caption = 'Transfer Order Lines';
            FieldClass = FlowField;
            CalcFormula = count("Transfer Line" where("Item No." = field("Source No.")));
            editable = false;
        }
    }
}