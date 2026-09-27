codeunit 50104 "TOMTbVendor"
{
    [EventSubscriber(ObjectType::Table, Database::Vendor, 'OnBeforeInsertEvent', '', true, true)]
    local procedure Item_Insert(RunTrigger: Boolean; var Rec: Record Vendor)
    begin
        if not RunTrigger then
            exit;
        rec."Date Created" := WorkDate();
    end;
    [EventSubscriber(ObjectType::Table, database::Vendor, 'OnAfterInsertEvent', '', false, false)]
    local procedure OnAfterInsertEvent(RunTrigger: Boolean;var Rec: Record Vendor)
    begin
        rec."Name 2" := Rec."No.";
    end;   
}
