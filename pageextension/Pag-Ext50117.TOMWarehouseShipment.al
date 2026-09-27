pageextension 50117 "TOMWarehouseShipment" extends "Warehouse Shipment"
{
    layout
    {
        addbefore("Sorting Method")
        {
            field(OrderNo; Rec."Order No.")
            {
                ApplicationArea = All;
                Editable = false;
                Enabled = false;
            }
            field("Customer No."; Rec."Customer No.")
            {
                ApplicationArea = all;
                Editable = false;
            }


        }
        addafter("Sorting Method")
        {
            field("Pick No."; rec."Pick No.")
            {
                ApplicationArea = All;
            }
            field("Registered Pick No."; rec."Registered Pick No.")
            {
                ApplicationArea = All;
            }
        }
        addafter("Shipping Agent Code")
        {
            field("E-Ship Agent Service"; Rec."E-Ship Agent Service")
            {
                ApplicationArea = All;
            }


        }
        addfirst(factboxes)
        {
            part(BinContent; "Bin Content FactBox")
            {
                ApplicationArea = All;
                Provider = WhseShptLines;
                SubPageLink = "Item No." = field("Item No.");
            }
        }
        modify("Shipping Agent Service Code")
        {
            Visible = false;
        }
        addlast(General)
        {
            group("Pick Notes")
            {
                Caption = 'Pick Notes';
                field("TOM Pick Notes"; Rec."TOM Pick Notes")
                {
                    ApplicationArea = All;
                    MultiLine = true;
                    ShowCaption = false;
                    ToolTip = 'Specifies the value of the Pick Notes field.';
                }
            }
        }
    }
}
