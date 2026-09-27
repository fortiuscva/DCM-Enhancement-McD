pageextension 50134 "TOMProdOrderComponents" extends "Prod. Order Components"
{
    layout
    {
        
        addafter("Qty. Picked")
        {
           
            field("Qty. Picked Base";Rec."Qty. Picked (Base)")
            {
                ApplicationArea = All;
                Editable = true;
            }
            field("Completely Picked";Rec."Completely Picked")
            {
                ApplicationArea = All;
                Editable = true;
            }
             field("Prod. Order Line No.";Rec."Prod. Order Line No.")
            {
                ApplicationArea = All;
            }
            field("Prod. Order Line Item No.";Rec."Prod. Order Line Item No.")
            {
                ApplicationArea = All;
            }
        }
        addfirst(factboxes)
        {
            part(BinContent; "Bin Content FactBox")
            {
                ApplicationArea = All;
                SubPageLink = "Item No." = field("Item No.");
            }

            part(ItemSupplyFactbox; TOMItemSupplyFactbox)
            {
                ApplicationArea = All;
                SubPageLink = "No." = field("Item No.");
            }
            part(ItemDemandFactbox; TOMItemDemandFactbox)
            {
                ApplicationArea = All;
                SubPageLink = "No." = field("Item No.");
            }

        }

    }
}
