report 50102 "TOMBlanketPOCompleteAnalysis"
{
    /*
    TOM 1.11 Created new report for Blanket PO % Complete Analysis
    */
    ApplicationArea = All;
    Caption = 'Blanket PO % Complete Analysis';
    UsageCategory = ReportsAndAnalysis;
    RDLCLayout = './reportlayout/TOMBlanketPOCompleteAnalysis.RDL';
    dataset
    {

        dataitem(PurchaseLine; "Purchase Line")
        {
            DataItemTableView = where("document type" = const("Blanket Order"));
            column(DocumentNo; "Document No.")
            {
            }
            column(No; "No.")
            {
            }
            column(Description; Description)
            {
            }
            column(Quantity; Quantity)
            {
            }
            column(OutstandingQuantity; "Outstanding Quantity")
            {
            }
            column(Promised_Receipt_Date; DueDate)
            {

            }
            column(PurchaserCode; PurchaserCode)
            {

            }
            column(VendNo; VendNo)
            {

            }
            column(OrderDate; OrderDate)
            {

            }
            column(DateComp; DateComp)
            {

            }
            column(DueDate; DueDate)
            {


            }
            trigger OnAfterGetRecord()
            begin
                clear(VendNo);
                clear(PurchaserCode);
                clear(OrderDate);
                clear(DateComp);
                clear(DueDate);
                if PurchHeader.get("Document Type", "Document No.") then begin
                    VendNo := PurchHeader."Buy-from Vendor No.";
                    PurchaserCode := PurchHeader."Purchaser Code";
                    orderdate := purchHeader."order date";
                    DueDate := PurchHeader."Due Date";
                end;
                //if (OrderDate <> 0D) and ("Promised Receipt Date" <> 0D) then
                if ((OrderDate - DueDate) <> 0) then
                    //DateComp := (1 - ((Today - DueDate) / (OrderDate - DueDate))) * 100;
                    DateComp := (1 - abs(((today - DueDate) / (OrderDate - DueDate)))) * 100;
                if DueDate <= Today then
                    DateComp := 100;
                //DateComp := ((Today - "Promised Receipt Date") / (OrderDate - "Promised Receipt Date")) * 100;
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
    var
        PurchHeader: Record "Purchase Header";
        VendNo: Code[20];
        PurchaserCode: Code[20];
        OrderDate: Date;
        DateComp: Decimal;
        DueDate: date;
}
