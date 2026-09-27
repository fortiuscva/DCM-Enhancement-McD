tableextension 50127 "TOMProd. Order Routing Line" extends "Prod. Order Routing Line"
{
    fields
    {
        field(50000; "THK Sub-Contractor PO Lines"; Integer)
        {
            Caption = 'Sub-Contractor PO Lines';
            FieldClass = FlowField;
            CalcFormula = count("Purchase Line" where("Prod. Order No." = field("Prod. Order No."), "Routing No." = field("Routing No."),
                                                      "Routing Reference No." = field("Routing Reference No."), "Operation No." = field("Operation No.")));
            Editable = false;
        }
    }
}
