report 50100 "TOMTASJobSpend"
{
    /*
    Requested and developed for TAS
    */
    ApplicationArea = All;
    Caption = 'TAS Job Spend';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './reportlayout/TOMTASJobSpend.RDL';

    dataset
    {

        dataitem(JobTask; "Job Task")
        {
            RequestFilterFields = "Job No.";
            column(JobNo; "Job No.")
            {
            }
            column(JobTaskNo; "Job Task No.")
            {
            }
            column(Description; Description)
            {

            }
            column(ScheduleTotalCost; "Schedule (Total Cost)")
            {


            }
            column(Commited; "Outstanding Orders" + "Usage (Total Cost)" + "Amt. Rcd. Not Invoiced")
            {

            }
            column(OverUnder; "Schedule (Total Cost)" - "Outstanding Orders" - "Usage (Total Cost)" - "Amt. Rcd. Not Invoiced")
            {


            }
            column(OutstandingOrders; "Outstanding Orders")
            {
            }

            column(AmtRcdNotInvoiced; "Amt. Rcd. Not Invoiced")
            {
            }
            column(UsageTotalCost; "Usage (Total Cost)")
            {

            }

            trigger OnPreDataItem()

            begin
                SetAutoCalcFields("Schedule (Total Cost)", "Usage (Total Cost)", "Amt. Rcd. Not Invoiced", "Outstanding Orders");
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(processing)
            {
            }
        }
    }
}
