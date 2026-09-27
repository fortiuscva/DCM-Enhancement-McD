pageextension 50146 "TOMSales Lines" extends "Sales Lines"
{
    layout
    {
        addfirst(FactBoxes)
        {
            part(ItemSupplyFactbox; TOMItemSupplyFactbox)
            {
                ApplicationArea = All;
                SubPageLink = "No." = field("No.");
            }
            part(ItemDemandFactbox; TOMItemDemandFactbox)
            {
                ApplicationArea = All;
                SubPageLink = "No." = field("No.");
            }
        }
    }
}
