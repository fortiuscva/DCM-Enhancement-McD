pageextension 50101 "TOMItemReplenishmentFactBox" extends "Item Replenishment FactBox"
{
    /*
   TOM 1.2 10292021 Added field on Item Replenishment FactBox to display remaining blanket order (Blanket order qty - PO qty - posted invoice qty) 
   TOM 1.3 10202021 Added lookup to display all blanket orders on click of new field
   */
    layout
    {
        addafter("Vendor Item No.")
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
        *///Old Blanket Rem Qty code using variable
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
    }
    /*
    trigger OnAfterGetRecord()

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
        QtyRemBlankPOInt := Round(QtyRemBlankPO, 1);
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
