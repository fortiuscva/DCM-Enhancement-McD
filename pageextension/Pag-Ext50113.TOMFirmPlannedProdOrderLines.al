pageextension 50113 "TOMFirmPlannedProdOrderLines" extends "Firm Planned Prod. Order Lines"
{
    layout
    {
        addafter("Item No.")
        {
            /*
                TOM 1.51 Expose Line # field for both Firmed Planned & Released Production Order
            */
            field("Planning Level Code"; Rec."Planning Level Code")
            {
                ApplicationArea = All;
            }

        }
        addafter("Planning Level Code")
        {
            /*
                TOM 1.27 Expose Line # field for both Firmed Planned & Released Production Order
            */
            field(LineNo; Rec."Line No.")
            {
                ApplicationArea = All;
            }

        }
    }
    actions
    {
        addafter("Order &Tracking")
        {
            /*
            TOM 1.26 Line level - Production Order Refresh - Firmed Planned & Released Production Order
            */
            action(RefreshProductionOrder)
            {
                ApplicationArea = All;
                Ellipsis = true;
                CaptionML = ENU = 'Re&fresh Production Order Line', ESM = 'Ac&tualizar orden producci¢n', FRC = 'Ac&tualiser Bon de production',
                                ENC = 'Re&fresh Production Order';
                Promoted = true;
                Image = Refresh;
                PromotedCategory = Process;
                trigger OnAction()
                var
                    rpt: Report TOMRefereshProductionLine;
                    rpl: Record "Prod. Order Line";
                begin
                    rpl.Copy(Rec, false);
                    rpl.SetRecFilter();
                    REPORT.RunModal(Report::TOMRefereshProductionLine, true, false, rpl);
                end;
            }
            /*
            TOM 1.26 Line level - Production Order Refresh - Firmed Planned & Released Production Order
            */
        }
    }
}
