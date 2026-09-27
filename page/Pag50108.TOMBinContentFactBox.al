page 50108 "Bin Content FactBox"
{
    Caption = 'Bin Content Details';
    PageType = ListPart;
    SourceTable = "Bin Content";
    Editable = false;
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Item No."; Rec."Item No.")
                {
                    ToolTip = 'Specifies the number of the item that will be stored in the bin.';
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ToolTip = 'Specifies the location code of the bin.';
                    ApplicationArea = All;
                }
                field("Bin Code"; Rec."Bin Code")
                {
                    ToolTip = 'Specifies the bin where the items are picked or put away.';
                    ApplicationArea = All;
                }
                field("AvailQtyToPick"; rec.CalcQtyAvailToTake(0))
                {
                    Caption = 'Available Qty. To Pick';
                    ApplicationArea = All;
                }
                field("Quantity (Base)"; Rec."Quantity (Base)")
                {
                    ToolTip = 'Specifies how many units of the item, in the base unit of measure, are stored in the bin.';
                    ApplicationArea = All;
                }

            }
        }
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    var
        myInt: Integer;
    begin
        if xRec."Location Code" <> '' then
            Rec."Location Code" := xRec."Location Code";
        if xRec."Bin Code" <> '' then
            Rec."Bin Code" := xRec."Bin Code";
        Rec.SetUpNewLine;
    end;
}
