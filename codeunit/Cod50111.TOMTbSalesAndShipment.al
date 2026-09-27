codeunit 50111 "TOMTbSalesAndShipment"
{
    // [EventSubscriber(ObjectType::Table, Database::"Warehouse Shipment Line", 'OnAfterInsertEvent', '', false, false)]
    // local procedure OnAfterSalesShipmentLineInsert(var Rec: Record "Warehouse Shipment Line"; RunTrigger: Boolean)
    // var
    //     sshipHdr: Record "Warehouse Shipment Header";
    //     sh: Record "Sales Header";
    // begin
    //     if sshipHdr.Get(Rec."No.") then begin
    //         if (sshipHdr."Order No." = '') or (sshipHdr."E-Ship Agent Service" = '') or (sshipHdr."Customer No." = '') then begin
    //             if (sshipHdr."Order No." = '') then
    //                 sshipHdr."Order No." := Rec."Source No.";
    //             if sshipHdr."E-Ship Agent Service" = '' then begin
    //                 if sh.Get(sh."Document Type"::Order, Rec."No.") then
    //                     sshipHdr."E-Ship Agent Service" := sh."LAX E-Ship Agent Service";
    //             end;
    //             if (sshipHdr."Customer No." = '') then begin
    //                 if (Rec."Destination Type" = "Warehouse Destination Type"::Customer) then
    //                     sshipHdr."Customer No." := Rec."Destination No.";
    //             end;
    //             sshipHdr.Modify(true);
    //         end;
    //     end;
    // end;

    // [EventSubscriber(ObjectType::Table, Database::"Registered Whse. Activity Line", 'OnAfterInsertEvent', '', false, false)]
    // local procedure OnAfterInsertWhseActivityLine(var Rec: Record "Registered Whse. Activity Line")
    // var
    //     sshipHdr: Record "Warehouse Shipment Header";
    // begin
    //     if (Rec."Activity Type" = "Warehouse Activity Type"::Pick) and
    //         (Rec."Source Document" = "Warehouse Activity Source Document"::"Sales Order") and
    //         (Rec."Whse. Document Type" = "Warehouse Activity Document Type"::Shipment) then begin
    //         if sshipHdr.Get(Rec."Whse. Document No.") then begin
    //             sshipHdr.
    //         end;
    //     end;
    // end;

}
