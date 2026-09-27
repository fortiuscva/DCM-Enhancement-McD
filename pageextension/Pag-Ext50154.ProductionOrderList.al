pageextension 50154 "Production Order List" extends "Production Order List"
{
    layout
    {
        addfirst(factboxes)
        {
            part(BinContent; "Bin Content FactBox")
            {
                ApplicationArea = All;
                SubPageLink = "Item No." = field("Source No.");
            }
        }
    }
}
