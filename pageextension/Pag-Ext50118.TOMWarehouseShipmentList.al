pageextension 50118 "TOMWarehouseShipmentList" extends "Warehouse Shipment List"
{
    layout
    {
        addafter(Status)
        {
            field("Order No."; rec."Order No.")
            {
                ApplicationArea = All;
            }
            field("Customer No."; rec."Customer No.")
            {
                ApplicationArea = All;
            }
            field("E-Ship Agent Service"; rec."E-Ship Agent Service")
            {
                ApplicationArea = All;
            }
            field("Pick No."; rec."Pick No.")
            {
                ApplicationArea = All;
            }
            field("Registered Pick No."; rec."Registered Pick No.")
            {
                ApplicationArea = All;
            }
        }
    }
}
