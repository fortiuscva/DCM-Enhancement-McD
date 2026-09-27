pageextension 50147 "Posted Whse. Shipment" extends "Posted Whse. Shipment"
{
    layout
    {
        addlast(General)
        {
            group("Pick Notes")
            {
                Caption = 'Pick Notes';
                field("TOM Pick Notes"; Rec."TOM Pick Notes")
                {
                    ApplicationArea = All;
                    MultiLine = true;
                    ShowCaption = false;
                    ToolTip = 'Specifies the value of the Pick Notes field.';
                }
            }
        }
    }
}
