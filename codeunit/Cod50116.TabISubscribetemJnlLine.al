codeunit 50116 TabSubscribeItemJnlLine
{
    //TOM 1.56 04282022 PS bypass the error to work scrap code with machine center
    [EventSubscriber(ObjectType::Table, 83, 'OnBeforeValidateScrapCode', '', false, false)]
    local procedure CreatePickDocFromWhseShpt(var IsHandled: Boolean; var ItemJournalLine: Record "Item Journal Line")

    begin

        if not IsHandled then begin
            if ItemJournalLine."Entry Type" = ItemJournalLine."Entry Type"::Output then
                IsHandled := true;
        end;
    end;

}
