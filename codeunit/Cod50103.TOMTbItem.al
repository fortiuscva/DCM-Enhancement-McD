codeunit 50103 "TOMTbItem"
{
    [EventSubscriber(ObjectType::Table, Database::item, 'OnBeforeInsertEvent', '', true, true)]
    local procedure Item_Insert(RunTrigger: Boolean; var Rec: Record Item)
    begin
        if not RunTrigger then
            exit;
        rec."Date Created" := WorkDate();
    end;
}
