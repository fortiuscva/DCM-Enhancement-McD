tableextension 50119 TOMProdOrderComponent extends "Prod. Order Component"
{
    fields
    {
        field(50100; "Prod. Order Line Item No."; Code[20] )
        {
            CalcFormula = Lookup("Prod. Order Line"."Item No." WHERE (Status=FIELD(Status),
                                                                      "Prod. Order No."=FIELD("Prod. Order No."),
                                                                      "Line No."=FIELD("Prod. Order Line No.")));
            FieldClass = FlowField;
        }
    }
}
