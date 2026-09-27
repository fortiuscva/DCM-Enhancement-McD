codeunit 50115 "Cod50114.TOMSubstituteReport"
//TOM 1.63 05152022 Added function to substitute "Blanket Purchase Order"
{
    //TOM 1.52 new CU for substituting report
    [EventSubscriber(ObjectType::Codeunit, Codeunit::ReportManagement, 'OnAfterSubstituteReport', '', false, false)]
    local procedure OnSubstituteReport(ReportId: Integer; var NewReportId: Integer)
    begin
        if ReportId = Report::"Prod. Order - Shortage List" then
            NewReportId := Report::"Rep50111.TOMProdShortageList";
    end;
    //TOM 1.53 TOMPickingList
    [EventSubscriber(ObjectType::Codeunit, Codeunit::ReportManagement, 'OnAfterSubstituteReport', '', false, false)]
    local procedure OnSubstituteReportPicking(ReportId: Integer; var NewReportId: Integer)
    begin
        if ReportId = Report::"Picking List" then
            NewReportId := Report::TOMPickingList;
    end;
    //TOM 1.57 TOMCheck
    [EventSubscriber(ObjectType::Codeunit, Codeunit::ReportManagement, 'OnAfterSubstituteReport', '', false, false)]
    local procedure OnSubstituteReportCheck(ReportId: Integer; var NewReportId: Integer)
    begin
        if ReportId = 10411 then //Report::"Check (Stub/Check/Stub)" then
            NewReportId := Report::TOMCheck;
    end;
    //TOM 1.58 TOM Warehouse Shipment
    [EventSubscriber(ObjectType::Codeunit, Codeunit::ReportManagement, 'OnAfterSubstituteReport', '', false, false)]
    local procedure OnSubstituteReportWarehouseShipment(ReportId: Integer; var NewReportId: Integer)
    begin
        if ReportId = 7317 then //Report::"Check (Stub/Check/Stub)" then
            NewReportId := Report::TOMWarehouseShipment;
    end;

    //>>TOM 1.63 
    local procedure OnSubstituteReportBlanketPurchaseOrder(ReportId: Integer; var NewReportId: Integer)
    begin
        if ReportId = 10119 then
            NewReportId := Report::TOMBlanketPurchaseOrder;
    end;
    //<<TOM 1.63 

}