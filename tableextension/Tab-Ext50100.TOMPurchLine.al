tableextension 50100 "TOMPurchLine" extends "Purchase Line"
{
    /*
    TOM 1.3 Added fields for "Quantity Rem. On Blanket PO" calculation on item 
    //TOM1.42 03242022 Added new field Sent to Contractor
    */
    fields
    {
        field(50100; TOMBlanketTotalQuantity; Decimal)
        {
            Caption = 'TOMBlanketTotalQuantity';
            FieldClass = FlowField;
            CalcFormula = sum("Purchase Line".Quantity where("Document Type" = const("Blanket Order"), "No." = field("No.")));
        }
        field(50101; TOMBlanketTotalQtyInvoiced; Decimal)
        {
            Caption = 'TOMBlanketTotalQtyInvoiced';
            FieldClass = FlowField;
            CalcFormula = sum("Purchase Line"."Quantity Invoiced" where("Document Type" = const("Blanket Order"), "No." = field("No.")));
        }
        field(50102; TOMPOBlnkTotalOutsdQty; Decimal)
        {
            Caption = 'TOMPOBlnkTotalOutsdQty';
            FieldClass = FlowField;
            CalcFormula = sum("Purchase Line"."Outstanding Quantity" where("Document Type" = const("Order"), "No." = field("No."), "Blanket Order No." = filter(<> '')));
        }
        field(50103; TOMPOBlnkTotalRcvdNotInvQty; Decimal)
        {
            Caption = 'TOMPOBlnkTotalRcvdNotInvQty';
            FieldClass = FlowField;
            CalcFormula = sum("Purchase Line"."Qty. Rcd. Not Invoiced" where("Document Type" = const("Order"), "No." = field("No."), "Blanket Order No." = filter(<> '')));
        }
         field(50104; "Sent to Contractor"; Boolean)
        {
            Caption = 'Sent to Contractor';
            
        }
    }

}
