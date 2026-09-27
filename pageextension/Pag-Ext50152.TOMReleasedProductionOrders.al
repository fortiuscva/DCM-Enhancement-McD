pageextension 50152 "TOMReleased Production Orders" extends "Released Production Orders"
{
    layout
    {
        addlast(Control1)
        {
            field("THK Sub-Contractor PO Lines"; Rec."THK Sub-Contractor PO Lines")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Sub-Contractor PO Lines field.';
            }
            field("THK Transfer Order Lines"; Rec."THK Transfer Order Lines")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Transfer Order Lines field.';
            }
            field("THK Floor"; Rec."THK Floor")
            {
                Caption = 'Floor';
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the THK Floor field';
            }
        }
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
