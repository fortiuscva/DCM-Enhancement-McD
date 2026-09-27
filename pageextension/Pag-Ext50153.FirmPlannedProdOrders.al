pageextension 50153 "Firm Planned Prod. Orders" extends "Firm Planned Prod. Orders"
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
