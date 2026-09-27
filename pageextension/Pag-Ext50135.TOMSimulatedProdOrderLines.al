pageextension 50135 "TOMSimulatedProdOrder Lines" extends "Simulated Prod. Order Lines"
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
