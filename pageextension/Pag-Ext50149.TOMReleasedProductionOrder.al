pageextension 50149 "TOMReleased Production Order" extends "Released Production Order"
{
    layout
    {
        addfirst(factboxes)
        {
            part(ItemSupplyFactbox; TOMItemSupplyFactbox)
            {
                ApplicationArea = All;
                SubPageLink = "No." = field("Item No.");
                Provider = ProdOrderLines;
            }
            part(ItemDemandFactbox; TOMItemDemandFactbox)
            {
                ApplicationArea = All;
                SubPageLink = "No." = field("Item No.");
                Provider = ProdOrderLines;
            }
            part(BinContent; "Bin Content FactBox")
            {
                ApplicationArea = All;
                SubPageLink = "Item No." = field("Source No.");
            }
        }
        addlast(General)
        {
            field("THK Sub-Contractor PO Lines"; Rec."THK Sub-Contractor PO Lines")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Sub-Contractor PO Lines field.';

                trigger OnDrillDown()
                var
                    PurchaseLine: Record "Purchase Line";
                begin
                    PurchaseLine.SetRange("Prod. Order No.", Rec."No.");
                    Page.RunModal(Page::TOMPurchaseLineSubPage, PurchaseLine);
                end;
            }
            field("THK Transfer Order Lines"; Rec."THK Transfer Order Lines")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Transfer Order Lines field.';
                editable = false;
            }
        }
    }
    actions
    {
        modify("Job Card")
        {
            trigger OnBeforeAction()
            begin
                SetDefaultReportLayoutSelection(true);
                Commit();
            end;
        }
        addafter("Job Card")
        {
            action("PLYM Job Card")
            {
                ApplicationArea = All;
                Caption = 'PLYM Job Card';
                Ellipsis = true;
                Image = Report;
                ToolTip = 'View a list of the work in progress of a production order. Product BOM and Routing information is shown depending on the operation.';
                trigger OnAction()
                var
                    ProductionOrder: Record "Production Order";
                begin
                    SetDefaultReportLayoutSelection(false);
                    Commit;
                    ProductionOrder.SetRange(ProductionOrder."No.", Rec."No.");
                    if ProductionOrder.FindFirst() then
                        Report.RunModal(Report::"SFI Production Order", true, false, ProductionOrder);
                end;
            }
        }
        addafter("Job Card_Promoted")
        {
            actionref("PLYM Job Card_Promoted"; "PLYM Job Card")
            {
            }
        }
    }
    procedure SetDefaultReportLayoutSelection(IsHandled: Boolean)
    var
        ReportLayoutSelection: Record "Report Layout Selection";
        SelectedReportLayoutList: Record "Report Layout List";
    begin
        SelectedReportLayoutList.Reset();
        SelectedReportLayoutList.SetRange("Report ID", Report::"SFI Production Order");
        if IsHandled then
            SelectedReportLayoutList.SetRange(Name, 'TOMSFIProductionOrder')
        else
            SelectedReportLayoutList.SetRange(Name, 'TOMSFIPLYMProductionOrder');
        if SelectedReportLayoutList.FindFirst() then;

        // Add to TenantReportLayoutSelection table with an Empty Guid. 
        AddLayoutSelection(SelectedReportLayoutList, EmptyGuid);
        // Add to the report layout selection table        
        if ReportLayoutSelection.get(SelectedReportLayoutList."Report ID", CompanyName) then begin
            ReportLayoutSelection.Type := GetReportLayoutSelectionCorrespondingEnum(SelectedReportLayoutList);
            ReportLayoutSelection.Modify(true);
        end else begin
            ReportLayoutSelection."Report ID" := SelectedReportLayoutList."Report ID";
            ReportLayoutSelection."Company Name" := CompanyName;
            ReportLayoutSelection."Custom Report Layout Code" := '';
            ReportLayoutSelection.Type := GetReportLayoutSelectionCorrespondingEnum(SelectedReportLayoutList);
            ReportLayoutSelection.Insert(true);
        end;
    end;

    local procedure AddLayoutSelection(SelectedReportLayoutList: Record "Report Layout List"; UserId: Guid): Boolean
    begin
        TenantReportLayoutSelection.Init();
        TenantReportLayoutSelection."App ID" := SelectedReportLayoutList."Application ID";
        TenantReportLayoutSelection."Company Name" := CompanyName;
        TenantReportLayoutSelection."Layout Name" := SelectedReportLayoutList."Name";
        TenantReportLayoutSelection."Report ID" := SelectedReportLayoutList."Report ID";
        TenantReportLayoutSelection."User ID" := UserId;
        if not TenantReportLayoutSelection.Insert(true) then
            TenantReportLayoutSelection.Modify(true);
    end;

    local procedure GetReportLayoutSelectionCorrespondingEnum(SelectedReportLayoutList: Record "Report Layout List"): Integer
    begin
        case SelectedReportLayoutList."Layout Format" of
            SelectedReportLayoutList."Layout Format"::RDLC:
                exit(0);
            SelectedReportLayoutList."Layout Format"::Word:
                exit(1);
            SelectedReportLayoutList."Layout Format"::Excel:
                exit(3);
            SelectedReportLayoutList."Layout Format"::Custom:
                exit(4);
        end
    end;

    var
        TenantReportLayoutSelection: Record "Tenant Report Layout Selection";
        EmptyGuid: Guid;
}