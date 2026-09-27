tableextension 50108 "TOMContact" extends Contact
{
    /*
    TOM 1.7 Added new field  "Customer/Vendor No."
    */
    fields
    {
        field(50100; "Customer/Vendor No."; Text[100])
        {
            Editable = false;
            Caption = 'Customer/Vendor No.';
            FieldClass = FlowField;
            CalcFormula = lookup("Contact Business Relation"."No." where("Contact No." = field("Company No.")));
        }
    }
}
