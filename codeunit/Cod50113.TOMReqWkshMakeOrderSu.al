codeunit 50113 "TOMReqWkshMakeOrderSu"
{
    trigger OnRun();
    begin

    end;

    [EventSubscriber(ObjectType::Codeunit, 333, 'OnBeforePurchOrderHeaderInsert', '', false, false)]
    procedure GetPONofromSubContractNos(var PurchaseHeader: Record "Purchase Header"; RequisitionLine: Record "Requisition Line")
    Var
        PurchSetup: Record "Purchases & Payables Setup";
        NoSeries: Codeunit "No. Series";
        WorkCenterRec: Record "Work Center";
    begin
        if workcenterrec.get(RequisitionLine."Work Center No.") and (WorkCenterRec."Subcontractor No." <> '') then begin
            PurchSetup.get;
            PurchSetup.TestField("Subcontract Purch Order Nos.");
            //if PurchSetup."Subcontract Purch Order Nos." <> '' then
            PurchaseHeader."No." := NoSeries.GetNextNo(PurchSetup."Subcontract Purch Order Nos.", Today);
        end;
    end;
}
