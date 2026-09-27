pageextension 50104 "StdCostWorksheet" extends "Standard Cost Worksheet"
{
    /*
    TOM 1.8 Added new process only report 
    */
    actions
    {
        addfirst("F&unctions")
        {
            action("Suggest I&tem Standard Cost1")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Suggest I&tem Standard Cost';
                Ellipsis = true;
                Image = SuggestItemCost;
                Promoted = true;
                PromotedCategory = Process;
                ToolTip = 'Creates suggestions for changing the cost shares of standard costs on Item cards. Note that the suggested changes are not implemented.';

                trigger OnAction()
                var
                    Item: Record Item;
                    SuggItemStdCost: Report TOMSuggestItemStandardCost;//TOM
                begin
                    Item.SetRange("Replenishment System", Item."Replenishment System"::Purchase);
                    SuggItemStdCost.SetTableView(Item);
                    SuggItemStdCost.SetCopyToWksh(rec."Standard Cost Worksheet Name");//TOM
                    SuggItemStdCost.RunModal;
                end;
            }
        }
        modify("Suggest I&tem Standard Cost")
        {
            Visible = false;
        }
    }
}

