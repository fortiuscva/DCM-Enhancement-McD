reportextension 50107 "ProdOrderShortageList" extends "Prod. Order - Shortage List"
{
    RDLCLayout = './reportlayout/ProdOrderShortageExt.rdl';

    dataset
    {
        //-->TOM 1.52 04262022 Added new field
        add("Production Order")
        {
            column(QtyRequestedforJobCap; QtyRequestedforJobCap)
            {

            }

        }
        modify("Production Order")
        {
            trigger OnAfterPreDataItem()
            begin
                if PrintToExcel then
                    MakeExcelInfo();
            end;
        }
        modify("Prod. Order Component")
        {
            trigger OnAfterAfterGetRecord()
            begin
                if PrintToExcel then
                    MakeExcelDataBody();
            end;
        }
        //<--
        add("Prod. Order Line")
        {
            column(ItemNo_ProdOrderLine; "Item No.")
            {

            }
            column(Description_ProdOrderLine; description)
            {

            }
        }

    }

    requestpage
    {
        layout
        {

            /*addfirst(Option,Option)
            {
                // add field from table extension to request page
                field(PrintExcel; PrintExcel) { }
            }
            */

        }
    }
    //-->TOM 1.52

    trigger OnPostReport()
    begin

    end;

    local procedure MakeExcelInfo()
    begin
        /*ExcelBuf.SetUseInfoSheet();
        ExcelBuf.AddInfoColumn(Format(CompanyNameLbl), false, true, false, false, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddInfoColumn(CompanyInformation.Name, false, false, false, false, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.NewRow();
        ExcelBuf.AddInfoColumn(Format(ReportNameLbl), false, true, false, false, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddInfoColumn(Format(AgedAccountsPayableLbl), false, false, false, false, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.NewRow();
        ExcelBuf.AddInfoColumn(Format(ReportNoLbl), false, true, false, false, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddInfoColumn(REPORT::"Aged Accounts Payable NA", false, false, false, false, '', ExcelBuf."Cell Type"::Number);
        ExcelBuf.NewRow();
        ExcelBuf.AddInfoColumn(Format(UserIDLbl), false, true, false, false, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddInfoColumn(UserId(), false, false, false, false, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.NewRow();
        ExcelBuf.AddInfoColumn(Format(DateTimeLbl), false, true, false, false, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddInfoColumn(Today(), false, false, false, false, '', ExcelBuf."Cell Type"::Date);
        ExcelBuf.AddInfoColumn(Time(), false, false, false, false, '', ExcelBuf."Cell Type"::Time);
        ExcelBuf.NewRow();
        ExcelBuf.AddInfoColumn(Format(VendorFiltersLbl), false, true, false, false, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddInfoColumn(FilterString, false, false, false, false, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.NewRow();
        ExcelBuf.AddInfoColumn(Format(Aged_byCaptionLbl), false, true, false, false, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddInfoColumn(DateTitle, false, false, false, false, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.NewRow();
        ExcelBuf.AddInfoColumn(Format(AgedAsOf2Lbl), false, true, false, false, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddInfoColumn(PeriodEndingDate[1], false, false, false, false, '', ExcelBuf."Cell Type"::Date);
        ExcelBuf.NewRow();
        ExcelBuf.AddInfoColumn(Format(AmountsAreLbl), false, true, false, false, '', ExcelBuf."Cell Type"::Text);
        if PrintAmountsInLocal then
            ExcelBuf.AddInfoColumn(Format(AsindicatedinDataLbl), false, false, false, false, '', ExcelBuf."Cell Type"::Text)
        else
            ExcelBuf.AddInfoColumn(Format(InOurFunctionalCurrencyLbl), false, false, false, false, '', ExcelBuf."Cell Type"::Text);
        */
        ExcelBuf.ClearNewRow();
        MakeExcelDataHeader();
    end;

    local procedure MakeExcelDataHeader()
    begin
        ExcelBuf.NewRow();
        ExcelBuf.AddColumn('Production Order No', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Top Level Item No', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Description', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Production Order Line No.', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Item No.', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Remaining Qty (Base)', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Quantity on Hand', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Qty. Requested for Job', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Qty. on Hand after Producion Order', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Scheduled Receipts', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Scheduled Need', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Qty. on Purch. Order', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Qty. on Sales Order', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Needed Qty', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
    end;

    Procedure MakeExcelDataBody()
    begin
        ExcelBuf.NewRow();
        ExcelBuf.AddColumn("Production Order"."No.", false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn("Production Order"."Source No.", false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);

        ExcelBuf.AddColumn("Production Order".Description, false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn("Prod. Order Line"."Line No.", false, '', false, false, false, '', ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn("Prod. Order Component"."Item No.", false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(QtyRequestedforJobCap, false, '', false, false, false, '', ExcelBuf."Cell Type"::Number);
        /*ExcelBuf.AddColumn(, false, '', false, false, false, '#,##0.00', ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn(-AmountDue[1], false, '', false, false, false, '#,##0.00', ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn(-AmountDue[2], false, '', false, false, false, '#,##0.00', ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn(-AmountDue[3], false, '', false, false, false, '#,##0.00', ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn(-AmountDue[4], false, '', false, false, false, '#,##0.00', ExcelBuf."Cell Type"::Number);
        if PrintAmountsInLocal then begin
            if PrintDetail then
                CurrencyCodeToPrint := "Vendor Ledger Entry"."Currency Code"
            else
                CurrencyCodeToPrint := Vendor."Currency Code";
            if CurrencyCodeToPrint = '' then
                CurrencyCodeToPrint := GLSetup."LCY Code";
            ExcelBuf.AddColumn(CurrencyCodeToPrint, false, '', false, false, false, '', ExcelBuf."Cell Type"::Text)
        end;
        */
    end;

    local procedure CreateExcelbook()
    begin
        /* //ExcelBuf.CreateBookAndOpenExcel('', DataLbl, AgedAccountsPayableLbl, CompanyName(), UserId());
         ExcelBuf.CreateNewBook(AgedAccountsPayableLbl);
         ExcelBuf.WriteSheet(DataLbl, CompanyName(), UserId());
         ExcelBuf.CloseBook();
         ExcelBuf.OpenExcel();
 */
    end;

    var
        QtyRequestedforJobCap: Label 'Qty. Requested for Job';
        PrinttoExcel: Boolean;
        ExcelBuf: Record "Excel Buffer" temporary;

    //<--TOM 1.52
}
