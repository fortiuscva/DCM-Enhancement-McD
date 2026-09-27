pageextension 50100 "TOMItemCard" extends "Item Card"
{
    /*
    TOM 1.2 10292021 Added field on item card to display remaining blanket order (Blanket order qty - PO qty - posted invoice qty) 
    TOM 1.3 10292021 Added lookup to display all blanket orders on click of new field
    TOM 1.4 10302021 Added field "Description 2" 
    TOM 1.15 12112021 Added new fields "Vendor Name","Blanket PO Item"
    TOM 1.17 12152021 Added a boolean "Blanket PO Item" field to Item number
    TOM 1.44 04062022 Added new field "Drawing No."
    TOM 1.43 04102022 Added new base fields "Reserved Qty. On Inventory","Reserved Qty. On Purch Order","Reserved Qty. On Sales Order","Reserved Qty. On Prod Order"
    TOM1.60 05062022 Added Cost Roll-up fields
    */

    layout
    {
        addafter("Last Date Modified")
        {
            field(SystemModifiedBy; Rec.SystemModifiedBy)
            {
                ApplicationArea = All;
            }
            field(SystemCreatedBy; Rec.SystemCreatedBy)
            {
                ApplicationArea = All;
            }
        }
        addfirst(factboxes)
        {
            part(BinContent; "Bin Content FactBox")
            {
                ApplicationArea = All;
                SubPageLink = "Item No." = field("No.");
            }
        }
        addafter("Qty. on Purch. Order")
        {
            /*
            field(QtyRemBlankPO; QtyRemBlankPOInt)
            {
                Editable = false;
                Caption = 'Qty. Rem. On Blanket PO';
                ApplicationArea = All;
                trigger OnAssistEdit()
                var
                    PurchLine: Record "Purchase Line";
                    PurchBlankOrderLine: Page "TOMPurchBlanketOrderLines";
                begin
                    PurchLine.reset;
                    PurchLine.SetRange("Document Type", PurchLine."Document Type"::"Blanket Order");
                    PurchLine.SetRange("No.", rec."No.");
                    PurchLine.SetRange(Type, PurchLine.type::Item);
                    if PurchLine.FindSet() then;
                    PurchBlankOrderLine.SetTableView(PurchLine);
                    PurchBlankOrderLine.SetRecord(PurchLine);
                    PurchBlankOrderLine.RunModal();
                    //if PurchBlankOrderLine.RunModal() = Action::Yes then
                    // exit(true);
                end;
            }
            */ //Old Blanket Rem Qty code using variable

            field("Quantity Rem On Blanket PO"; rec."Quantity Rem. On Blanket PO")
            {
                Editable = false;
                DecimalPlaces = 0;
                ApplicationArea = All;
                trigger OnAssistEdit()
                var
                    PurchLine: Record "Purchase Line";
                    PurchBlankOrderLine: Page "TOMPurchBlanketOrderLines";
                begin
                    PurchLine.reset;
                    PurchLine.SetRange("Document Type", PurchLine."Document Type"::"Blanket Order");
                    PurchLine.SetRange("No.", rec."No.");
                    PurchLine.SetRange(Type, PurchLine.type::Item);
                    if PurchLine.FindSet() then;
                    PurchBlankOrderLine.SetTableView(PurchLine);
                    PurchBlankOrderLine.SetRecord(PurchLine);
                    PurchBlankOrderLine.RunModal();
                end;

            }
        }
        addafter("Vendor No.")
        {
            field("Vendor Name"; rec."Vendor Name")
            {
                ApplicationArea = All;
            }
        }
        addafter("Over-Receipt Code")
        {
            field("Blanket PO Item"; rec."Blanket PO Item")
            {
                ApplicationArea = All;
            }
        }
        addlast(Item)
        {
            field("Date Created"; rec."Date Created")
            {
                Editable = false;
                ApplicationArea = All;

            }
        }
        addafter("Date Created")
        {
            field("Drawing No."; rec."Drawing No.")
            {
                ApplicationArea = All;
            }
        }
        addafter("Blanket PO Item")
        {
            group("Reserved To")
            {
                field("Reserved Qty. on Inventory"; rec."Reserved Qty. on Inventory")
                {
                    ApplicationArea = All;
                }
                field("Reserved Qty. on Purch. Orders"; rec."Reserved Qty. on Purch. Orders")
                {
                    ApplicationArea = All;
                }
                field("Reserved Qty. on Sales Orders"; rec."Reserved Qty. on Sales Orders")
                {
                    ApplicationArea = All;
                }
                field("Reserved Qty. on Prod. Order"; rec."Reserved Qty. on Prod. Order")
                {
                    ApplicationArea = All;
                }
            }
        }
        //>>TOM 1.60
        addlast(content)
        {
            group("Cost Roll-Up")
            {
                field("Single-Level Material Cost"; rec."Single-Level Material Cost")
                {
                    ApplicationArea = All;
                }
                field("Single-Level Capacity Cost"; rec."Single-Level Capacity Cost")
                {
                    ApplicationArea = All;
                }
                field("Single-Level Subcontrd. Cost"; rec."Single-Level Subcontrd. Cost")
                {
                    ApplicationArea = All;
                }
                field("Single-Level Cap. Ovhd Cost"; rec."Single-Level Cap. Ovhd Cost")
                {
                    ApplicationArea = All;
                }
                field("Single-Level Mfg. Ovhd Cost"; rec."Single-Level Mfg. Ovhd Cost")
                {
                    ApplicationArea = All;
                }
                field("Rolled-up Material Cost"; rec."Rolled-up Material Cost")
                {
                    ApplicationArea = All;
                }
                field("Rolled-up Capacity Cost"; rec."Rolled-up Capacity Cost")
                {
                    ApplicationArea = All;
                }
                field("Rolled-up Subcontracted Cost"; rec."Rolled-up Subcontracted Cost")
                {
                    ApplicationArea = All;
                }
                field("Rolled-up Mfg. Ovhd Cost"; rec."Rolled-up Mfg. Ovhd Cost")
                {
                    ApplicationArea = All;
                }
                field("Rolled-up Cap. Overhead Cost"; rec."Rolled-up Cap. Overhead Cost")
                {
                    ApplicationArea = All;
                }
            }
        }
        modify("Qty. in Transit")
        {
            Visible = true;
        }
        moveafter("Qty. on Sales Order"; "Qty. in Transit")
    }
    actions
    {
        movelast(BillOfMaterials; Production)
        addafter("Where-Used")
        {
            action("TOMStdCostChangeLog")
            {
                ApplicationArea = All;
                RunObject = Page "TOMStdCostChangeLog";
                RunPageLink = "Item No." = field("No.");
                Image = ChangeLog;
                Caption = 'Std. Cost Change Log';
            }
        }
    }
    trigger OnOpenPage()
    var
        myInt: Integer;
    begin
        // CurrPage.editable :=false;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    var
        myInt: Integer;
    begin
        //CurrPage.editable :=true;
    end;


    //<<TOM1.60
    /*
    trigger OnOpenPage()

    begin
        Clear(BlanketQty);
        Clear(PostInvQty);
        Clear(POQty);
        PurchLineBlanket.Reset();
        PurchLineBlanket.SetRange("Document Type", PurchHdr."Document Type"::"Blanket Order");
        PurchLineBlanket.SetRange(Type, PurchLineBlanket.Type::Item);
        PurchLineBlanket.SetRange("No.", rec."No.");
        if PurchLineBlanket.FindSet() then
            repeat
                BlanketQty += PurchLineBlanket.Quantity;
                PurchLine.reset;
                PurchLine.SetRange("Document Type", PurchLine."Document Type"::Order);
                PurchLine.SetRange("Blanket Order No.", PurchLineBlanket."Document No.");
                PurchLine.SetRange("Blanket Order Line No.", PurchLineBlanket."Line No.");
                PurchLine.SetRange("No.", PurchLineBlanket."No.");
                if PurchLine.FindSet() then
                    repeat
                        POQty += PurchLine.Quantity;
                    until PurchLine.Next() = 0;
                PurchInvLine.Reset();
                PurchInvLine.SetRange("Blanket Order No.", PurchLineBlanket."Document No.");
                PurchInvLine.SetRange("Blanket Order Line No.", PurchLineBlanket."Line No.");
                PurchInvLine.SetRange("No.", PurchLineBlanket."No.");
                if PurchInvLine.FindSet() then
                    repeat
                        PurchLine1.Reset();
                        PurchLine1.SetRange("Document No.", PurchInvLine."Order No.");
                        PurchLine1.SetRange("Line No.", PurchInvLine."Order Line No.");
                        PurchLine1.SetRange("No.", PurchInvLine."No.");
                        if not PurchLine1.FindFirst() then
                            PostInvQty += PurchInvLine.Quantity;
                    until PurchInvLine.Next() = 0;
            until PurchLineBlanket.Next = 0;
        QtyRemBlankPO := BlanketQty - POQty - PostInvQty;
        QtyRemBlankPOInt := Round(QtyRemBlankPO, 1)
    end;
    *///Old Blanket Rem Qty code using variable
    var
        PurchHdr: Record "Purchase Header";
        PurchLine: Record "Purchase Line";
        PurchLine1: Record "Purchase Line";
        PurchLineBlanket: Record "Purchase Line";
        PurchInvLine: Record "Purch. Inv. Line";
        POQty: Decimal;
        BlanketQty: Decimal;
        PostInvQty: Decimal;
        QtyRemBlankPO: Decimal;
        QtyRemBlankPOInt: Integer;
}
