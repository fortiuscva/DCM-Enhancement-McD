pageextension 50114 "TOMSalesOrder" extends "Sales Order"
{
    //TOM 1.49 042422 PS Added new button to print international Invoice
    //TOM 1.56 042922 PS Added new button to print international packing slip
    layout
    {
        /*
        TOM 1.28 Add a flag to alert if a customer PO number has already been used (duplicated)
        */
        modify("External Document No.")
        {
            trigger OnAfterValidate()
            begin
                CheckDuplicatePONumber
            end;
        }
        addfirst(factboxes)
        {
            part(BinContent; "Bin Content FactBox")
            {
                ApplicationArea = All;
                Provider = SalesLines;
                SubPageLink = "Item No." = field("No.");
            }
            part(ItemSupplyFactbox; TOMItemSupplyFactbox)
            {
                ApplicationArea = All;
                Provider = SalesLines;
                SubPageLink = "No." = field("No.");
            }
            part(ItemDemandFactbox; TOMItemDemandFactbox)
            {
                ApplicationArea = All;
                Provider = SalesLines;
                SubPageLink = "No." = field("No.");
            }
        }
        addafter("Work Description")
        {
            group("Pick Notes")
            {
                Caption = 'Pick Notes';
                field("TOM Pick Notes"; Rec."TOM Pick Notes")
                {
                    Caption = 'Pick Notes';
                    ApplicationArea = All;
                    MultiLine = true;
                    ShowCaption = false;
                    ToolTip = 'Specifies the value of the Pick Notes field.';
                }
            }
        }
    }
    /*
       TOM 1.28 Add a flag to alert if a customer PO number has already been used (duplicated)
    */
    //-->TOM 1.49
    actions
    {
        addfirst(reporting)
        {
            action("International Invoice")
            {
                Caption = 'International Invoice';
                ApplicationArea = All;
                Image = PrintReport;
                Promoted = true;
                PromotedCategory = "Report";
                ToolTip = 'View the International Invoice for orders to be filled.';

                trigger OnAction()
                var
                    SalesHeader: Record "Sales Header";
                begin
                    SalesHeader.Reset();
                    SalesHeader.SetRange("No.", Rec."No.");
                    SalesHeader.SetRange("Sell-to Customer No.", Rec."Sell-to Customer No.");

                    REPORT.RunModal(REPORT::"Tomahawk Intl Invoice", true, false, SalesHeader);
                end;
            }

            action("International Invoice-BV")
            {
                Caption = 'International Invoice-BV';
                ApplicationArea = All;
                Image = PrintReport;
                Promoted = true;
                PromotedCategory = "Report";
                ToolTip = 'View the International Invoice-BV for orders to be filled.';

                trigger OnAction()
                var
                    SalesHeader: Record "Sales Header";
                begin
                    SalesHeader.Reset();
                    SalesHeader.SetRange("No.", Rec."No.");
                    SalesHeader.SetRange("Sell-to Customer No.", Rec."Sell-to Customer No.");

                    REPORT.RunModal(REPORT::"Tomahawk Intl Invoice-BV", true, false, SalesHeader);
                end;
            }
            //-->TOM 1.56
            action("International Packing Slip")
            {
                Caption = 'International Packing Slip';
                ApplicationArea = All;
                Image = PrintReport;
                Promoted = true;
                PromotedCategory = "Report";
                ToolTip = 'View the International Invoice for orders to be filled.';

                trigger OnAction()
                var
                    SalesHeader: Record "Sales Header";
                begin
                    SalesHeader.Reset();
                    SalesHeader.SetRange("No.", Rec."No.");
                    SalesHeader.SetRange("Sell-to Customer No.", Rec."Sell-to Customer No.");

                    REPORT.RunModal(REPORT::TOMIntlPackingSlip, true, false, SalesHeader);
                end;
            }
            action("International Packing Slip-BV")
            {
                Caption = 'International Packing Slip-BV';
                ApplicationArea = All;
                Image = PrintReport;
                Promoted = true;
                PromotedCategory = "Report";
                ToolTip = 'View the International Invoice for orders to be filled.';

                trigger OnAction()
                var
                    SalesHeader: Record "Sales Header";
                begin
                    SalesHeader.Reset();
                    SalesHeader.SetRange("No.", Rec."No.");
                    SalesHeader.SetRange("Sell-to Customer No.", Rec."Sell-to Customer No.");

                    REPORT.RunModal(REPORT::TOMIntlPackingSlipBV, true, false, SalesHeader);
                end;
            }

            action("PreviewPostedInvoice")
            {
                Caption = 'Preview Posted Invoice ';
                ApplicationArea = All;
                Image = PrintReport;
                Promoted = true;
                PromotedCategory = "Report";

                trigger OnAction()
                var
                    SalesHeader: Record "Sales Header";
                begin
                    SalesHeader.Reset();
                    SalesHeader.SetRange("No.", Rec."No.");
                    SalesHeader.SetRange("Sell-to Customer No.", Rec."Sell-to Customer No.");

                    REPORT.RunModal(REPORT::TOMPreviewPostedInvoice, true, false, SalesHeader);
                end;
            }

            //<--TOM 1.56
        }
        addafter("Report Picking List by Order")
        {
            action("Proforma Invoice")
            {
                Caption = 'Proforma Invoice';
                ApplicationArea = All;
                Image = PrintReport;
                Promoted = true;
                PromotedCategory = "Report";

                trigger OnAction()
                var
                    SalesHeader: Record "Sales Header";
                begin
                    SalesHeader.Reset();
                    SalesHeader.SetRange("No.", Rec."No.");
                    SalesHeader.SetRange("Sell-to Customer No.", Rec."Sell-to Customer No.");
                    REPORT.RunModal(REPORT::"TOM Proforma Invoice", true, false, SalesHeader);
                end;
            }

        }


    }
    //<--TOM 1.49
    local procedure CheckDuplicatePONumber()
    var
        sh: Record "Sales Header";
        dupOrders: TextBuilder;
        SalesShptHeadRecLcl: Record "Sales Shipment Header";
        SalesInvHeadRecLcl: Record "Sales Invoice Header";
    begin
        if Rec."External Document No." = '' then exit;
        sh.SetRange("Document Type", sh."Document Type"::Order);
        sh.SetFilter("No.", '<>%1', Rec."No.");
        sh.SetRange("External Document No.", Rec."External Document No.");
        if sh.FindSet() then begin
            dupOrders.Clear();
            repeat
                if dupOrders.ToText() = '' then
                    dupOrders.Append(sh."No.")
                else
                    dupOrders.Append(StrSubstNo('\%1', sh."No."));
            until sh.Next() = 0;
        end;
        if dupOrders.ToText() <> '' then
            Message(StrSubstNo('The Customer PO No.: %1 is duplicated in sales orders :\%2', Rec."External Document No.", dupOrders.ToText()));

        SalesShptHeadRecLcl.Reset();
        SalesShptHeadRecLcl.SetRange("External Document No.", Rec."External Document No.");
        if SalesShptHeadRecLcl.FindSet() then begin
            dupOrders.Clear();
            repeat
                if dupOrders.ToText() = '' then
                    dupOrders.Append(SalesShptHeadRecLcl."No.")
                else
                    dupOrders.Append(StrSubstNo('\%1', SalesShptHeadRecLcl."No."));
            until SalesShptHeadRecLcl.Next() = 0;
        end;
        if dupOrders.ToText() <> '' then
            Message(StrSubstNo('The Customer PO No.: %1 is duplicated on Posted Sales Shipment(s) :\%2', Rec."External Document No.", dupOrders.ToText()));

        SalesInvHeadRecLcl.Reset();
        SalesInvHeadRecLcl.SetRange("External Document No.", Rec."External Document No.");
        if SalesInvHeadRecLcl.FindSet() then begin
            dupOrders.Clear();
            repeat
                if dupOrders.ToText() = '' then
                    dupOrders.Append(SalesInvHeadRecLcl."No.")
                else
                    dupOrders.Append(StrSubstNo('\%1', SalesInvHeadRecLcl."No."));
            until SalesInvHeadRecLcl.Next() = 0;
        end;
        if dupOrders.ToText() <> '' then
            Message(StrSubstNo('The Customer PO No.: %1 is duplicated on Posted Sales Invoice(s) :\%2', Rec."External Document No.", dupOrders.ToText()));

    end;
}
