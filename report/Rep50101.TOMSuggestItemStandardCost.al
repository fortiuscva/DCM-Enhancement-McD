report 50101 "TOMSuggestItemStandardCost"
{
    /*
    TOM 1.8 11132021
    When Suggest Item Standard Cost is run from the Standard Cost Worksheet for "Replenishment 
    System" = Purchase, the “New Standard Cost” equal “Last Direct Cost” value in the item table for that
    item
    */
    Caption = 'Suggest Item Standard Cost';
    ProcessingOnly = true;

    dataset
    {

        dataitem(Item; Item)
        {
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "No.", "Vendor No.", "Replenishment System", "Costing Method";

            trigger OnAfterGetRecord()
            begin
                InsertStdCostWksh("No.");
                if CurrentDateTime - WindowUpdateDateTime >= 750 then begin
                    Window.Update(1, "No.");
                    WindowUpdateDateTime := CurrentDateTime;
                end;
            end;

            trigger OnPostDataItem()
            begin
                Window.Close;
            end;

            trigger OnPreDataItem()
            begin
                WindowUpdateDateTime := CurrentDateTime;
                Window.Open(Text007 + Text008);
            end;
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    group("Standard Cost")
                    {
                        Caption = 'Standard Cost';
                        field("AmtAdjustFactor[1]"; AmtAdjustFactor[1])
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Adjustment Factor';
                            DecimalPlaces = 0 : 5;
                            MinValue = 0;
                            NotBlank = true;
                            ToolTip = 'Specifies an adjustment factor to multiply the standard cost that you want suggested. By entering an adjustment factor, you can increase or decrease the amounts that are suggested.';
                        }
                        field("RoundingMethod[1]"; RoundingMethod[1])
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Rounding Method';
                            TableRelation = "Rounding Method";
                            ToolTip = 'Specifies a code for the rounding method that you want to apply to costs that you adjust.';
                        }
                    }
                    group("Indirect Cost %")
                    {
                        Caption = 'Indirect Cost %';
                        field("AmtAdjustFactor[2]"; AmtAdjustFactor[2])
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Adjustment Factor';
                            DecimalPlaces = 0 : 5;
                            MinValue = 0;
                            NotBlank = true;
                            ToolTip = 'Specifies an adjustment factor to multiply the standard cost that you want suggested. By entering an adjustment factor, you can increase or decrease the amounts that are suggested.';
                        }
                        field("RoundingMethod[2]"; RoundingMethod[2])
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Rounding Method';
                            TableRelation = "Rounding Method";
                            ToolTip = 'Specifies a code for the rounding method that you want to apply to costs that you adjust.';
                        }
                    }
                    group("Overhead Rate")
                    {
                        Caption = 'Overhead Rate';
                        field("AmtAdjustFactor[3]"; AmtAdjustFactor[3])
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Adjustment Factor';
                            DecimalPlaces = 0 : 5;
                            MinValue = 0;
                            NotBlank = true;
                            ToolTip = 'Specifies an adjustment factor to multiply the standard cost that you want suggested. By entering an adjustment factor, you can increase or decrease the amounts that are suggested.';
                        }
                        field("RoundingMethod[3]"; RoundingMethod[3])
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Rounding Method';
                            TableRelation = "Rounding Method";
                            ToolTip = 'Specifies a code for the rounding method that you want to apply to costs that you adjust.';
                        }
                    }
                }
            }
        }

        actions
        {
        }

        trigger OnOpenPage()
        var
            i: Integer;
        begin
            for i := 1 to ArrayLen(AmtAdjustFactor) do
                if AmtAdjustFactor[i] = 0 then
                    AmtAdjustFactor[i] := 1;
        end;
    }

    labels
    {
    }

    trigger OnInitReport()
    var
        i: Integer;
    begin
        for i := 1 to ArrayLen(AmtAdjustFactor) do
            if AmtAdjustFactor[i] = 0 then
                AmtAdjustFactor[i] := 1;
    end;

    trigger OnPreReport()
    var
        StdCostWkshName: Record "Standard Cost Worksheet Name";
    begin
        if ToStdCostWkshName = '' then
            Error(Text004);
        StdCostWkshName.Get(ToStdCostWkshName);

        ToStdCostWksh.LockTable
    end;

    var
        Text004: Label 'You must specify a worksheet name to copy to.';
        Text007: Label 'Copying worksheet...\\';
        Text008: Label 'Item No. #1####################\';
        ToStdCostWksh: Record "Standard Cost Worksheet";
        Window: Dialog;
        ToStdCostWkshName: Code[10];
        RoundingMethod: array[3] of Code[10];
        AmtAdjustFactor: array[3] of Decimal;
        WindowUpdateDateTime: DateTime;

    local procedure InsertStdCostWksh(No2: Code[20])
    begin
        ToStdCostWksh.Init;
        ToStdCostWksh.Validate(ToStdCostWksh."Standard Cost Worksheet Name", ToStdCostWkshName);
        ToStdCostWksh.Validate(ToStdCostWksh.Type, ToStdCostWksh.Type::Item);
        ToStdCostWksh.Validate(ToStdCostWksh."No.", No2);
        /*
        Validate(
          "New Standard Cost",
          RoundAndAdjustAmt("Standard Cost", RoundingMethod[1], AmtAdjustFactor[1]));
        */
        //TOM Blocked Std Code
        //>> TOM
        if item."Replenishment System" = item."Replenishment System"::Purchase then
            ToStdCostWksh.Validate(ToStdCostWksh."New Standard Cost", item."Last Direct Cost")
        else
            ToStdCostWksh.Validate(ToStdCostWksh."New Standard Cost", RoundAndAdjustAmt(ToStdCostWksh."Standard Cost", RoundingMethod[1], AmtAdjustFactor[1]));
        //<<TOM
        ToStdCostWksh.Validate(
          ToStdCostWksh."New Indirect Cost %",
          RoundAndAdjustAmt(ToStdCostWksh."Indirect Cost %", RoundingMethod[2], AmtAdjustFactor[2]));
        ToStdCostWksh.Validate(
          ToStdCostWksh."New Overhead Rate",
          RoundAndAdjustAmt(ToStdCostWksh."Overhead Rate", RoundingMethod[3], AmtAdjustFactor[3]));

        if not ToStdCostWksh.Insert(true) then
            ToStdCostWksh.Modify(true);

    end;

    procedure RoundAndAdjustAmt(Amt: Decimal; RoundingMethodCode: Code[10]; AmtAdjustFactor: Decimal): Decimal
    var
        RoundingMethod: Record "Rounding Method";
        Sign: Decimal;
    begin
        if Amt = 0 then
            exit(Amt);

        Amt := Round(Amt * AmtAdjustFactor, 0.00001);

        if RoundingMethodCode <> '' then begin
            if Amt >= 0 then
                Sign := 1
            else
                Sign := -1;

            RoundingMethod.SetRange(RoundingMethod.Code, RoundingMethodCode);
            RoundingMethod.Code := RoundingMethodCode;
            RoundingMethod."Minimum Amount" := Abs(Amt);
            if RoundingMethod.Find('=<') then begin
                Amt := Amt + Sign * RoundingMethod."Amount Added Before";
                if RoundingMethod.Precision > 0 then
                    Amt := Sign * Round(Abs(Amt), RoundingMethod.Precision, CopyStr('=><', RoundingMethod.Type + 1, 1));
                Amt := Amt + Sign * RoundingMethod."Amount Added After";
            end;
        end;

        exit(Amt);
    end;

    procedure SetCopyToWksh(ToStdCostWkshName2: Code[10])
    begin
        ToStdCostWkshName := ToStdCostWkshName2;
    end;

    procedure Initialize(ToStdCostWkshName2: Code[10]; AmtAdjustFactor1: Decimal; AmtAdjustFactor2: Decimal; AmtAdjustFactor3: Decimal; RoundingMethod1: Code[10]; RoundingMethod2: Code[10]; RoundingMethod3: Code[10])
    begin
        ToStdCostWkshName := ToStdCostWkshName2;
        AmtAdjustFactor[1] := AmtAdjustFactor1;
        AmtAdjustFactor[2] := AmtAdjustFactor2;
        AmtAdjustFactor[3] := AmtAdjustFactor3;
        RoundingMethod[1] := RoundingMethod1;
        RoundingMethod[2] := RoundingMethod2;
        RoundingMethod[3] := RoundingMethod3;
    end;
}

