codeunit 50100 "TOMBlanketPurchOrdtoOrdExt"
{
    /*
    TOM 1.1 10302021 Added function OnBeforeInsertPurchOrderHeader 
    Requirement : 
        condition 1 - if no PO is created with Blanket PO - Create manual document no. for purchase order by adding '_1' with current blanket order no. 
        condition 2 - if a PO is present with current Blanket PO (in Posted and unposted both), find the largest PO ,increase last no and assign as document no.
    */
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Blanket Purch. Order to Order", 'OnBeforeInsertPurchOrderHeader', '', false, false)]
    local procedure OnBeforeInsertPurchOrderHeader(var PurchOrderHeader: Record "Purchase Header"; BlanketOrderPurchHeader: Record "Purchase Header");
    var
        TempPurchLine: Record "Purchase Line" temporary;
        PurchLine: Record "Purchase Line";
        PurchInvLine: Record "Purch. Inv. Line";
        i: Integer;
    begin
        PurchLine.Reset();
        PurchLine.SetRange("Blanket Order No.", BlanketOrderPurchHeader."No.");
        if PurchLine.FindSet() then
            repeat
                i += 1;
                TempPurchLine.init;
                TempPurchLine."Document No." := PurchLine."Document No.";
                TempPurchLine."Line No." := i;
                TempPurchLine.Insert();
            until PurchLine.Next() = 0;
        PurchInvLine.Reset();
        PurchInvLine.SetRange("Blanket Order No.", BlanketOrderPurchHeader."No.");
        if PurchInvLine.FindSet() then
            repeat
                i += 1;
                TempPurchLine.Init();
                TempPurchLine."Document No." := PurchInvLine."Order No.";
                TempPurchLine."Line No." := i;
                TempPurchLine.Insert();
            until PurchInvLine.Next() = 0;
        if TempPurchLine.FindLast() then
            PurchOrderHeader.validate("No.", IncStr(TempPurchLine."Document No."))
        else
            PurchOrderHeader.validate("No.", BlanketOrderPurchHeader."No." + '-01');
    end;
}