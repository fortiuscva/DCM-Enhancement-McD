codeunit 50117 "CodeSubsCriber"
{
    [EventSubscriber(ObjectType::Report, 1305, 'OnLineOnAfterGetRecordOnAfterCalcTotals', '', false, false)]
    local procedure TotalVatAmt(var SalesHeader: Record "Sales Header"; var SalesLine: Record "Sales Line"; var TotalAmountInclVAT: Decimal; var VATAmount: Decimal; var VATBaseAmount: Decimal)

    begin
        //SalesLine.CalcFields("Ava Tax Amount");
        //VATAmount := SalesLine."Ava Tax Amount";
        //message('Pankaj %1--%2', VATAmount, SalesLine."Amount Including VAT" - SalesLine.Amount);
    end;

    [EventSubscriber(ObjectType::Page, Page::"Item Card", 'OnBeforeActionEvent', 'Action5', false, false)]
    local procedure CalcStandardCost_ItemCard(var Rec: Record Item)
    begin
        Rec.CalcFields(Inventory);
        IF Rec.Inventory > 0 then
            Error('You can not roll up Std. Cost since Qty. On Hand is not 0');
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Job Create-Invoice", 'OnBeforeModifySalesHeader', '', false, false)]
    local procedure OnBeforeModifySalesHeader_JobCreateInvoice(Job: Record Job; JobPlanningLine: Record "Job Planning Line"; var SalesHeader: Record "Sales Header")

    begin
        SalesHeader."External Document No." := Job."External Document No.";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::ItemCostManagement, 'OnAfterUpdateUnitCost', '', false, false)]
    local procedure OnAfterUpdateUnitCostSKU(CalledByFieldNo: Integer; var Item: Record Item)
    var
        locSKU: Record "Stockkeeping Unit";
    begin
        locSKU.SetRange("Item No.", Item."No.");
        IF locSKU.FindSet() then
            repeat
                locSKU."Standard Cost" := Item."Standard Cost";
                locSKU."Unit Cost" := Item."Standard Cost";
                locSKU.Modify();
            until locSKU.next = 0;
    end;


    [EventSubscriber(ObjectType::Table, Database::"Production Order", 'OnBeforeAssignItemNo', '', false, false)]
    local procedure OnBeforeAssignItemNo(var ProdOrder: Record "Production Order"; xProdOrder: Record "Production Order"; var Item: Record Item; CallingFieldNo: Integer);
    begin
        ProdOrder."THK Blanket PO Item" := Item."Blanket PO Item";
    end;


    [EventSubscriber(ObjectType::Table, Database::"Prod. Order Line", 'OnAfterCopyFromItem', '', false, false)]
    local procedure OnAfterCopyFromItem(var ProdOrderLine: Record "Prod. Order Line"; Item: Record Item; var xProdOrderLine: Record "Prod. Order Line"; CurrentFieldNo: Integer);
    begin
        ProdOrderLine."THK Blanket PO Item" := Item."Blanket PO Item";
    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Prod. Order Status Management", 'OnCopyFromProdOrder', '', false, false)]
    local procedure Cod5407_OnCopyFromProdOrder(var ToProdOrder: Record "Production Order"; FromProdOrder: Record "Production Order");
    begin
        ToProdOrder."THK Blanket PO Item" := FromProdOrder."THK Blanket PO Item";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Prod. Order Status Management", 'OnCopyFromProdOrderLine', '', false, false)]
    local procedure Cod5407_OnCopyFromProdOrderLine(var ToProdOrderLine: Record "Prod. Order Line"; FromProdOrderLine: Record "Prod. Order Line");
    begin
        ToProdOrderLine."THK Blanket PO Item" := ToProdOrderLine."THK Blanket PO Item";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Carry Out Action", 'OnInsertProdOrderWithReqLine', '', false, false)]
    local procedure Cod99000813_OnInsertProdOrderWithReqLine(var ProductionOrder: Record "Production Order"; var RequisitionLine: Record "Requisition Line");
    var
        ItemRecLcl: Record Item;
    begin
        if not ItemRecLcl.get(ProductionOrder."Source No.") then
            ItemRecLcl.Init();
        ProductionOrder."THK Blanket PO Item" := ItemRecLcl."Blanket PO Item";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Carry Out Action", 'OnInsertProdOrderLineWithReqLine', '', false, false)]
    local procedure Cod99000813_OnInsertProdOrderLineWithReqLine(var ProdOrderLine: Record "Prod. Order Line"; var RequisitionLine: Record "Requisition Line");
    var
        ItemRecLcl: Record Item;
    begin
        if not ItemRecLcl.get(ProdOrderLine."Item No.") then
            ItemRecLcl.Init();
        ProdOrderLine."THK Blanket PO Item" := ItemRecLcl."Blanket PO Item";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::ItemCostManagement, 'OnUpdateUnitCostOnBeforeUpdateSKU', '', false, false)]
    local procedure OnUpdateUnitCostOnBeforeUpdateSKU(var Item: Record Item; var UpdateSKU: Boolean);
    begin
        UpdateSKU := true;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Copy Item", 'OnAfterCopyItem', '', false, false)]
    local procedure "Copy Item_OnAfterCopyItem"(var CopyItemBuffer: Record "Copy Item Buffer"; SourceItem: Record Item; var TargetItem: Record Item)
    begin
        TargetItem."Date Created" := today;
        TargetItem."Quantity Rem. On Blanket PO" := 0;
        TargetItem.Modify();
    end;
}
