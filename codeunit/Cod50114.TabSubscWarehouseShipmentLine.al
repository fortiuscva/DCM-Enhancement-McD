codeunit 50114 "Tab-SubscWarehouseShipmentLine"
{
    //TOM 1.42 Created subsciber to flow default values to report request
    [EventSubscriber(ObjectType::Table, 7321, 'OnBeforeCreatePickDoc', '', false, false)]
    local procedure CreatePickDocFromWhseShpt(var WarehouseShipmentLine: Record "Warehouse Shipment Line"; WarehouseShipmentHeader: Record "Warehouse Shipment Header"; HideValidationDialog: Boolean; var IsHandled: Boolean)
    var
        WhseShipmentCreatePick: Report "Whse.-Shipment - Create Pick";
    begin
        //OnBeforeCreatePickDoc(WhseShptLine, WhseShptHeader, HideValidationDialog, IsHandled);
        if not IsHandled then begin
            WhseShipmentCreatePick.SetWhseShipmentLine(WarehouseShipmentLine, WarehouseShipmentHeader);
            WhseShipmentCreatePick.SetHideValidationDialog(HideValidationDialog);
            WhseShipmentCreatePick.Initialize('', "Whse. Activity Sorting Method"::"Shelf or Bin", true, false, false);
            WhseShipmentCreatePick.UseRequestPage(not HideValidationDialog);
            WhseShipmentCreatePick.RunModal;
            WhseShipmentCreatePick.GetResultMessage;
            Clear(WhseShipmentCreatePick);
            IsHandled := true;
        end;
    end;

    [EventSubscriber(ObjectType::Report, 7318, 'OnAfterOpenPage', '', false, false)]
    local procedure OnafterOpenRequestPage(var DoNotFillQtytoHandle: Boolean)
    begin
        DoNotFillQtytoHandle := false;

    end;

}
