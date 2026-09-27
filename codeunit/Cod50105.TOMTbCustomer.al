codeunit 50105 "TOMTbCustomer"
{
    [EventSubscriber(ObjectType::Table, Database::Customer, 'OnBeforeInsertEvent', '', true, true)]
    local procedure Item_Insert(RunTrigger: Boolean; var Rec: Record Customer)
    begin
        if not RunTrigger then
            exit;
        rec."Date Created" := WorkDate();
    end;
}
