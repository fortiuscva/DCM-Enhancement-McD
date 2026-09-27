codeunit 50112 "TOMGetSourceDocuments"
{
    [EventSubscriber(ObjectType::Report, Report::"Get Source Documents", 'OnBeforeWhseShptHeaderInsert', '', false, false)]
    local procedure OnBeforeWhseShptHeaderInsert(var WarehouseShipmentHeader: Record "Warehouse Shipment Header"; var WarehouseRequest: Record "Warehouse Request"; SalesLine: Record "Sales Line"; TransferLine: Record "Transfer Line"; SalesHeader: Record "Sales Header");
    begin
        WarehouseShipmentHeader."E-Ship Agent Service" := SalesHeader."LAX E-Ship Agent Service";
        // WarehouseShipmentHeader."Order No." := SalesHeader."No.";
        WarehouseShipmentHeader."TOM Pick Notes" := SalesHeader."TOM Pick Notes";
    end;

}
