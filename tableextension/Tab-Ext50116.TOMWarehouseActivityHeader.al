tableextension 50116 TOMWarehouseActivityHeader extends "Warehouse Activity Header"
{
    //TOM1.59 05042022 Added Fields TOMSourceDocument,TOMSourceNo
    fields
    {
        field(50100; TOMSourceDocument; Enum "Warehouse Activity Source Document")
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Warehouse Activity Line"."Source Document" where("Action Type" = field(Type), "No." = field("No.")));
            Caption = 'Source Document';
        }
        field(50101; "TOMSourceNo."; Code[20])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Warehouse Activity Line"."Source No." where("Action Type" = field(Type), "No." = field("No.")));
            Caption = 'Source No.';
        }
    }
}
