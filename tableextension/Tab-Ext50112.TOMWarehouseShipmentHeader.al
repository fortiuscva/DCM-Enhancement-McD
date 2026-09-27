tableextension 50112 "TOMWarehouseShipmentHeader" extends "Warehouse Shipment Header"
{
    fields
    {
        field(50100; "Order No."; Code[20])
        {
            Caption = 'Order No.';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup("Warehouse Shipment Line"."Source No." where("No." = field("No.")));
        }
        field(50101; "E-Ship Agent Service"; Code[30])
        {
            Caption = 'Shipping Agent Service Code';
        }
        field(50102; "Customer No."; Code[20])
        {
            Caption = 'Customer No.';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup("Warehouse Shipment Line"."Destination No." where("No." = field("No.")));
        }
        field(50103; "Pick No."; Code[20])
        {
            Caption = 'Pick No.';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup("Warehouse Activity Line"."No." where("Whse. Document No." = field("No.")));
        }
        field(50104; "Registered Pick No."; Code[20])
        {
            Caption = 'Registered Pick No.';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup("Registered Whse. Activity Line"."No." where("Whse. Document No." = field("No.")));

        }
        field(50150; "TOM Pick Notes"; Text[100])
        {
            Caption = 'Pick Notes';
        }
    }
}
