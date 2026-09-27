codeunit 50106 "TOMTbProductionOrder"
{
    /*
    TOM 1.25 01152022 Assigned User ID automation on Firm Planned Prod Order
    */
    [EventSubscriber(ObjectType::Table, Database::"Production Order", 'OnBeforeInsertEvent', '', true, true)]
    local procedure ProdOrder_OnInsert(RunTrigger: Boolean; var Rec: Record "Production Order")
    begin
        if not RunTrigger then
            exit;
        if rec.Status = rec.Status::"Firm Planned" then
            rec."Assigned User ID" := userid();
    end;
}
