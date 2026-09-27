pageextension 50132 TOMWarehousePicks extends "Warehouse Picks"
{
    //TOM1.59 05042022 Added Fields TOMSourceDocument,TOMSourceNo
    layout
    {
        addafter("No.")
        {
            field(TOMSourceDocument; rec.TOMSourceDocument)
            {
                ApplicationArea = All;
            }
            field("TOMSourceNo."; rec."TOMSourceNo.")
            {
                ApplicationArea = All;
            }
        }
        modify("Source No.")
        {
            Visible = false;
        }
        modify("Source Document")
        {
            Visible = false;
        }
    }
}
