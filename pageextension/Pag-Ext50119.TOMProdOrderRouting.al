pageextension 50119 "TOMProdOrderRouting" extends "Prod. Order Routing"
{
    layout
    {
        /*
        TOM 1.33 make the Routing Link Code a dropdown in the Prod order routing page
        */
        modify("Routing Link Code")
        {
            Editable = true;
        }
        addafter("Routing Link Code")
        {
            field("THK Sub-Contractor PO Lines"; Rec."THK Sub-Contractor PO Lines")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Sub-Contractor PO Lines field.';

                trigger OnDrillDown()
                var
                    PurchaseLine: Record "Purchase Line";
                begin
                    PurchaseLine.SetRange("Prod. Order No.", Rec."Prod. Order No.");
                    PurchaseLine.SetRange("Routing No.", Rec."Routing No.");
                    PurchaseLine.SetRange("Routing Reference No.", Rec."Routing Reference No.");
                    PurchaseLine.SetRange("Operation No.", Rec."Operation No.");
                    Page.RunModal(Page::TOMPurchaseLineSubPage, PurchaseLine);
                end;
            }
        }
    }
}
