tableextension 50113 "TOMPurchandPayabl" extends "Purchases & Payables Setup"
{
    //TOM 1.35 03202022 MK Created extension to add new field Sub Contract Purchase Order Nos, it is used to create purchase order with different no series.
    fields
    {
        field(50100; "Subcontract Purch Order Nos."; Code[10])
        {
            Caption = 'Subcontract Purchase Order Nos.';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series".Code;
        }
    }
}
