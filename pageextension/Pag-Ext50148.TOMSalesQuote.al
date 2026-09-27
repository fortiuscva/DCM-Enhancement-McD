pageextension 50148 TOMSalesQuote extends "Sales Quote"
{
    layout
    {
        addfirst(factboxes)
        {
            part(BinContent; "Bin Content FactBox")
            {
                ApplicationArea = All;
                Provider = SalesLines;
                SubPageLink = "Item No." = field("No.");
            }
        }
    }
}