codeunit 50120 TOMItemSubscriber
{
    [EventSubscriber(ObjectType::Table, Database::Item, 'OnAfterValidateEvent', 'Standard Cost', false, false)]
    local procedure ItemOnAfterValidateStandardCost(var Rec: Record Item; var xRec: Record Item; CurrFieldNo: Integer)
    VAR
        CostCalcLogT2: Record "TOMStdCostChangeLog";
        CostCalcLogT: Record "TOMStdCostChangeLog";
        NextEntryNo: Integer;
    begin
        //WITH Rec DO BEGIN
        IF Rec."Standard Cost" <> xRec."Standard Cost" THEN BEGIN
            Rec."Last Unit Cost Calc. Date" := WORKDATE;
            //"CCS Last Std Cost Change" := WORKDATE;

            //update audit
            CostCalcLogT2.RESET;
            IF CostCalcLogT2.FINDLAST THEN
                NextEntryNo := CostCalcLogT2."Entry No." + 1
            ELSE
                NextEntryNo := 1;

            CostCalcLogT.INIT;
            CostCalcLogT."Entry No." := NextEntryNo;
            CostCalcLogT."Item No." := Rec."No.";
            CostCalcLogT."Action Date" := WORKDATE;
            CostCalcLogT."Calculation Date" := 0D;
            CostCalcLogT."User ID" := USERID;
            CostCalcLogT."Entry Type" := CostCalcLogT."Entry Type"::"Std Cost Field Change";
            CostCalcLogT."Previous Std. Cost" := xRec."Unit Cost";
            CostCalcLogT."Calcd or Entered Std. Cost" := Rec."Standard Cost";
            CostCalcLogT."Item Card Lot Size" := Rec."Lot Size";
            CostCalcLogT."Time of Day" := TIME;
            CostCalcLogT."Last CurrCost Calc BOM No." := Rec."Production BOM No.";
            CostCalcLogT."Last CurrCost Calc Router No." := Rec."Routing No.";
            CostCalcLogT."Indirect Cost %" := Rec."Indirect Cost %";
            CostCalcLogT."Scrap %" := Rec."Scrap %";
            CostCalcLogT."Overhead Rate" := Rec."Overhead Rate";
            CostCalcLogT.INSERT;
        END;
    end;

}
