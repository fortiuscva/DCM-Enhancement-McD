pageextension 50004 "TOMPlanning Components" extends "Planning Components"
{
    layout
    {
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
