page 50111 "TOMStdCostChangeLog"
{
    ApplicationArea = All;
    Caption = 'Std. Cost Change Log';
    PageType = List;
    SourceTable = "TOMStdCostChangeLog";
    UsageCategory = Lists;
    Editable = false;
    layout
    {
        area(content)
        {
            repeater(General)
            {
                ShowCaption = false;
                field("Item No."; Rec."Item No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'No. of the Item the Change Log applies to.';
                }
                field("Action Date"; Rec."Action Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Date the change occured.';
                }
                field("Calculation Date"; Rec."Calculation Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Date used for the Calculation change.';
                }
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Who requested the change.';
                }
                field("Entry Type"; Rec."Entry Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'What type of cost was calculated.';
                }
                field("Calculation Method"; Rec."Calculation Method")
                {
                    ApplicationArea = All;
                    ToolTip = 'How was the cost calculated.';
                }
                field("Previous Std. Cost"; Rec."Previous Std. Cost")
                {
                    ApplicationArea = All;
                    ToolTip = 'What was the previous cost amount.';
                }
                field("Calcd or Entered Std. Cost"; Rec."Calcd or Entered Std. Cost")
                {
                    ApplicationArea = All;
                    ToolTip = 'The new standard cost for the Item.';
                }
                field("Item Card Lot Size"; Rec."Item Card Lot Size")
                {
                    ApplicationArea = All;
                    ToolTip = 'Base lot size from the Item.';
                }
                field("Current Cost Calc Lot Size"; Rec."Current Cost Calc Lot Size")
                {
                    ApplicationArea = All;
                    ToolTip = 'Lot size used to do the new calculation';
                }
                field("Calculated Current Cost"; Rec."Calculated Current Cost")
                {
                    ApplicationArea = All;
                    ToolTip = 'The new calculated Current Cost.';
                }
                field("Time of Day"; Rec."Time of Day")
                {
                    ApplicationArea = All;
                    ToolTip = 'What time was the calculation done';
                }
                field("Last UnitCost Calc BOM No."; Rec."Last UnitCost Calc BOM No.")
                {
                    ApplicationArea = All;
                }
                field("Last UnitCost Calc BOM Rev."; Rec."Last UnitCost Calc BOM Rev.")
                {
                    ApplicationArea = All;
                }
                field("Last UnitCost Calc Router No."; Rec."Last UnitCost Calc Router No.")
                {
                    ApplicationArea = All;
                }
                field("Last UnitCost Calc Router Rev."; Rec."Last UnitCost Calc Router Rev.")
                {
                    ApplicationArea = All;
                }
                field("Last CurrCost Calc BOM No."; Rec."Last CurrCost Calc BOM No.")
                {
                    ApplicationArea = All;
                }
                field("Last CurrCost Calc BOM Rev."; Rec."Last CurrCost Calc BOM Rev.")
                {
                    ApplicationArea = All;
                }
                field("Last CurrCost Calc Router No."; Rec."Last CurrCost Calc Router No.")
                {
                    ApplicationArea = All;
                }
                field("Last CurrCost Calc Router Rev."; Rec."Last CurrCost Calc Router Rev.")
                {
                    ApplicationArea = All;
                }
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
