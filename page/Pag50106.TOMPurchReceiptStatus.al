page 50106 "TOMPurchReceiptStatus"
{
    ApplicationArea = All;
    Editable = false;
    Caption = 'Purchase Receipt Status';
    PageType = List;
    SourceTable = "Purch. Rcpt. Line";
    UsageCategory = Lists;
    SourceTableView = SORTING("Document No.", "Line No.")
                      ORDER(Ascending)
                      WHERE(Type = FILTER(Item | "G/L Account" | Resource),
                            Quantity = FILTER(<> 0));
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = All;
                }
                field("Order No."; Rec."Order No.")
                {
                    ApplicationArea = All;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                }
                field("Buy-from Vendor No."; Rec."Buy-from Vendor No.")
                {
                    ApplicationArea = All;
                }
                field(VendName; VendName)
                {
                    Caption = 'Buy-from Vendor Name';
                    ApplicationArea = All;
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Unit of Measure"; Rec."Unit of Measure")
                {
                    ApplicationArea = All;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                }
                field("Bin Code"; Rec."Bin Code")
                {
                    ApplicationArea = All;
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                }
                field("Direct Unit Cost"; Rec."Direct Unit Cost")
                {
                    ApplicationArea = All;
                }

            }

        }
        area(FactBoxes)
        {

            part(ItemSupplyFactbox; TOMItemSupplyFactbox)
            {
                ApplicationArea = All;
                SubPageLink = "No." = field("No.");
            }
            part(ItemDemandFactbox; TOMItemDemandFactbox)
            {
                ApplicationArea = All;
                SubPageLink = "No." = field("No.");
            }
        }


    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        if Vend.Get(Rec."Buy-from Vendor No.") then
            VendName := Vend.Name
        else
            VendName := ''
    end;

    var
        VendName: Text;
        Vend: Record Vendor;
}
