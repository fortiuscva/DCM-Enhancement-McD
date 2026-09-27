codeunit 50110 "TOMItemRefMgmt"
{
    /*
    TOM 1.24 Modified Item Reference List (5735, List) from the PO line to display manufacturer's reference number
    */
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Reference Management", 'OnPurchaseReferenceNoLookUpOnAfterSetFilters', '', false, false)]
    local procedure OnPurchaseReferenceNoLookUpOnAfterSetFilters(var ItemReference: Record "Item Reference"; PurchaseLine: Record "Purchase Line");
    var
        PurchHeader: Record "Purchase Header";
    begin
        PurchHeader.Get(PurchaseLine."Document Type", PurchaseLine."Document No.");
        ItemReference.SetRange("Reference Type");
        ItemReference.SetRange("Reference Type No.");
        ItemReference.SetFilter("Reference Type", '%1|%2|%3', ItemReference."Reference Type"::Vendor, ItemReference."Reference Type"::"Manufacturer Code", ItemReference."Reference Type"::" ");
        if ItemReference.FindSet() then
            repeat
                if ItemReference."Reference Type No." = PurchHeader."Buy-from Vendor No." then
                    ItemReference.Mark(true);
                if (ItemReference."Reference Type" = ItemReference."Reference Type"::"Manufacturer Code")
                 and (ItemReference."Item No." = PurchaseLine."No.") then
                    ItemReference.Mark(true);
            until ItemReference.Next() = 0;
        ItemReference.MarkedOnly(true);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Reference Management", 'OnBeforeReferenceLookupPurchaseItem', '', false, false)]
    local procedure OnBeforeReferenceLookupPurchaseItem(var PurchaseLine: Record "Purchase Line"; var ItemReference: Record "Item Reference"; ShowDialog: Boolean; var IsHandled: Boolean);
    begin
        if PurchaseLine."Item Reference No." <> '' then begin
            ItemReference.Reset();
            ItemReference.SetRange("Item No.", PurchaseLine."No.");
            ItemReference.SetRange("Reference No.", PurchaseLine."Item Reference No.");
            ItemReference.SetRange("Reference Type", ItemReference."Reference Type"::"Manufacturer Code");
            if ItemReference.FindFirst() then
                IsHandled := true;
        end;
    end;



}
