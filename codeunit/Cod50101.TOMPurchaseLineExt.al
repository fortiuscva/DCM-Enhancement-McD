codeunit 50101 "TOMPurchaseLineExt"
{
    /*
    TOM 1.2 Added functions to update "Quantity Rem. On Blanket PO" on item table
    */
    [EventSubscriber(ObjectType::Table, Database::"Purchase Line", 'OnAfterInsertEvent', '', true, true)]
    local procedure PurchLineOnAfterInsert(RunTrigger: Boolean; var Rec: Record "Purchase Line")
    begin
        rec.CalcFields(TOMBlanketTotalQuantity, TOMBlanketTotalQtyInvoiced, TOMPOBlnkTotalOutsdQty, TOMPOBlnkTotalRcvdNotInvQty);
        if Item.get(rec."No.") then begin
            Item."Quantity Rem. On Blanket PO" := rec.TOMBlanketTotalQuantity - rec.TOMBlanketTotalQtyInvoiced - rec.TOMPOBlnkTotalOutsdQty - rec.TOMPOBlnkTotalRcvdNotInvQty;
            Item.Modify();
        end;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Line", 'OnAfterModifyEvent', '', true, true)]
    local procedure PurchLineOnAfterModify(RunTrigger: Boolean; var Rec: Record "Purchase Line")
    begin
        rec.CalcFields(TOMBlanketTotalQuantity, TOMBlanketTotalQtyInvoiced, TOMPOBlnkTotalOutsdQty, TOMPOBlnkTotalRcvdNotInvQty);
        if Item.get(rec."No.") then begin
            Item."Quantity Rem. On Blanket PO" := rec.TOMBlanketTotalQuantity - rec.TOMBlanketTotalQtyInvoiced - rec.TOMPOBlnkTotalOutsdQty - rec.TOMPOBlnkTotalRcvdNotInvQty;
            Item.Modify();
        end;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Line", 'OnAfterDeleteEvent', '', true, true)]
    local procedure PurchLineOnAfterDelete(RunTrigger: Boolean; var Rec: Record "Purchase Line")
    begin
        rec.CalcFields(TOMBlanketTotalQuantity, TOMBlanketTotalQtyInvoiced, TOMPOBlnkTotalOutsdQty, TOMPOBlnkTotalRcvdNotInvQty);
        if Item.get(rec."No.") then begin
            Item."Quantity Rem. On Blanket PO" := rec.TOMBlanketTotalQuantity - rec.TOMBlanketTotalQtyInvoiced - rec.TOMPOBlnkTotalOutsdQty - rec.TOMPOBlnkTotalRcvdNotInvQty;
            Item.Modify();
        end;
    end;

    var
        Item: Record Item;
}
