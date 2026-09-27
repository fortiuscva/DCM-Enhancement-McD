codeunit 50119 "TOMReleaseSalesDocument"
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Release Sales Document", 'OnBeforeReleaseSalesDoc', '', false, false)]
    local procedure OnBeforeReleaseSalesDoc(var SalesHeader: Record "Sales Header"; PreviewMode: Boolean; var IsHandled: Boolean; SkipCheckReleaseRestrictions: Boolean);
    var
        SalesLine: Record "Sales Line";
        SalesInfoPaneMgt: Codeunit "Sales Info-Pane Management";
        IsNegInv: Boolean;
        ItemString: Text;
    begin
        if SalesHeader."Document Type" = SalesHeader."Document Type"::Order then begin
            SalesHeader.Reset();
            SalesLine.SetRange("Document Type", SalesHeader."Document Type");
            SalesLine.SetRange("Document No.", SalesHeader."No.");
            SalesLine.Setrange(Type, 2);
            SalesLine.SetFilter(Quantity, '<>0');
            if SalesLine.FindSet() then
                repeat
                    if SalesInfoPaneMgt.CalcAvailability(SalesLine) < 0 then begin
                        IsNegInv := true;
                        ItemString := ItemString + '\' + SalesLine."No."
                    end;
                until SalesLine.Next() = 0;

            if (SalesHeader."Shipping Advice" = SalesHeader."Shipping Advice"::Complete) and IsNegInv then
                error(StrSubstNo('Order is Ship Complete.The following Items are not in stock %1 ', ItemString));
        end;
    end;

}
