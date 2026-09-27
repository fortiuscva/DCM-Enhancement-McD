pageextension 50139 TOMFinishedProdOrderLines extends "Finished Prod. Order Lines"
{
    layout
    {
        addafter("Bin Code")
        {
        field("Planning Level Code";Rec."Planning Level Code")
        {
            ApplicationArea = All;
        }
        }
    }
}
