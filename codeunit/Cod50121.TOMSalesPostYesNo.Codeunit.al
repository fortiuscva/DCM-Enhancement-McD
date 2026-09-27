codeunit 50121 "TOMSalesPostYesNo.Codeunit"
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post (Yes/No)", 'OnAfterConfirmPost', '', false, false)]
    local procedure OnAfterConfirmPost(var SalesHeader: Record "Sales Header");
    begin
        if Date2DMY(SalesHeader."Document Date", 2) <> Date2DMY(SalesHeader."Posting Date", 2) then
            Error('Please ensure Document Date is in the same month as Posting Date.');
    end;

}
