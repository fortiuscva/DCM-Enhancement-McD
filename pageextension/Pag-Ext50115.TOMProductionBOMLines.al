pageextension 50115 "TOMProductionBOMLines" extends "Production BOM Lines"
{
    layout
    {
        /*
        TOM 1.29 Prevent the same item number from being entered in the production BOM lines
        */
        modify("No.")
        {
            trigger OnBeforeValidate()
            begin
                //CheckIfItemIsDuplicated
            end;
        }
    }
    /*
       TOM 1.29 Prevent the same item number from being entered in the production BOM lines
    */
    local procedure CheckIfItemIsDuplicated()
    var
        pbl: Record "Production BOM Line";
    begin
        if (Rec.Type <> Rec.Type::Item) or (Rec."No." = '') then exit;
        pbl.SetFilter("Line No.", '<>%1', Rec."Line No.");
        pbl.SetRange("Production BOM No.", Rec."Production BOM No.");
        pbl.SetRange("No.", Rec."No.");
        pbl.SetRange(Type, Rec.Type::Item);
        if not pbl.IsEmpty then
            Error('Item No. %1 is duplicated', Rec."No.");
    end;
}
