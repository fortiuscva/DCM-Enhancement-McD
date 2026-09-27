codeunit 50107 "TOM Sales Header Events"
{

    /*
        TOM 1.32 On Purchase Quotes & Orders, Sales Quotes & Orders, automatically populate the Assigned User ID field with the user that created the document. This appears to be happening automatically on Purchase Return Orders, requesting the same functionality across Purchase and Sales documents.
    */
    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnAfterInsertEvent', '', false, false)]
    local procedure OnAfterInsertSalesHeader(var Rec: Record "Sales Header");
    begin
        if Rec.IsTemporary then exit;
        if Rec."Document Type" in [Rec."Document Type"::Quote, Rec."Document Type"::Order] then begin
            Rec."Assigned User ID" := UserId;
            Rec.Modify();
        end;
    end;


}
