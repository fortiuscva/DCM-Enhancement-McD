tableextension 50107 "TOMCustomer" extends Customer
{
    /*
    TOM 1.9 Added new fields "Customer Parent","Customer Parent Name"
    TOM 1.22 Create a new field of type Date "Date Created"
    */
    fields
    {
        field(50100; "Customer Parent"; Code[20])
        {
            TableRelation = Customer;
            Caption = 'Customer Parent';
            DataClassification = ToBeClassified;
        }
        field(50101; "Customer Parent Name"; Text[100])
        {
            Caption = 'Customer Parent Name';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup(customer.Name where("No." = field("Customer Parent")));
        }
        field(50103; "Date Created"; Date)
        {

        }
    }
}
