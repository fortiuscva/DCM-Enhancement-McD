pageextension 50150 "TOMFirm Planned Prod. Order" extends "Firm Planned Prod. Order"
{
    layout
    {
        addfirst(factboxes)
        {
            part(ItemSupplyFactbox; TOMItemSupplyFactbox)
            {
                ApplicationArea = All;
                SubPageLink = "No." = field("Item No.");
                Provider = ProdOrderLines;
            }
            part(ItemDemandFactbox; TOMItemDemandFactbox)
            {
                ApplicationArea = All;
                SubPageLink = "No." = field("Item No.");
                Provider = ProdOrderLines;
            }
            part(BinContent; "Bin Content FactBox")
            {
                ApplicationArea = All;
                SubPageLink = "Item No." = field("Source No.");
            }
        }
    }
}
