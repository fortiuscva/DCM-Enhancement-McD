page 50105 "TOMPurchaseLineSubPage"
{
    //TOM1.42 03242022 New Page Created
    ApplicationArea = All;
    Caption = 'Sub-Contractor PO Lines';
    PageType = List;
    SourceTable = "Purchase Line";
    UsageCategory = Lists;
    Editable = false;
    //CardPageId = "Purchase Order";
    SourceTableView = sorting("Document Type", "Document No.", "Line No.") order(ascending)
 where("Prod. Order No." = filter(<> ''));

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Document No."; Rec."Document No.")
                {
                    ToolTip = 'Specifies the document number.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Document Type"; Rec."Document Type")
                {
                    ToolTip = 'Specifies the type of document that you are about to create.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Sent to Contractor"; Rec."Sent to Contractor")
                {
                    ToolTip = 'Specifies the value of the Sent to Contractor field.';
                    ApplicationArea = All;
                    Editable = true;
                }
                field("Order Date"; Rec."Order Date")
                {
                    ToolTip = 'Specifies the date when the order was created.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Prod. Order No."; Rec."Prod. Order No.")
                {
                    ToolTip = 'Specifies the number of the related production order.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Buy-from Vendor No."; Rec."Buy-from Vendor No.")
                {
                    ToolTip = 'Specifies the name of the vendor who delivered the items.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field(VendorName; VendorName)
                {
                    ToolTip = 'Specifies the name of the vendor who delivered the items.';
                    ApplicationArea = All;
                    Caption = 'Vendor Name';
                    Editable = false;
                }
                field("Work Center No."; Rec."Work Center No.")
                {
                    ToolTip = 'Specifies the work center number of the journal line.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Type"; Rec."Type")
                {
                    ToolTip = 'Specifies the line type.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the number of the involved entry or record, according to the specified number series.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies a description of the blanket purchase order.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Unit of Measure"; Rec."Unit of Measure")
                {
                    ToolTip = 'Specifies the name of the item or resource''s unit of measure, such as piece or hour.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Quantity; Rec.Quantity)
                {
                    ToolTip = 'Specifies the quantity of the purchase order line.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Direct Unit Cost"; Rec."Direct Unit Cost")
                {
                    ToolTip = 'Specifies the cost of one unit of the selected item or resource.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Amount Including VAT"; Rec."Amount Including VAT")
                {
                    ToolTip = 'Specifies the sum of the amounts in the Amount Including VAT fields on the associated purchase lines.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Outstanding Quantity"; Rec."Outstanding Quantity")
                {
                    ToolTip = 'Specifies how many units on the order line have not yet been received.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Qty. to Receive"; Rec."Qty. to Receive")
                {
                    ToolTip = 'Specifies the quantity of items that remains to be received.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Qty. to Invoice"; Rec."Qty. to Invoice")
                {
                    ToolTip = 'Specifies the quantity that remains to be invoiced. It is calculated as Quantity - Qty. Invoiced.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Quantity Received"; Rec."Quantity Received")
                {
                    ToolTip = 'Specifies how many units of the item on the line have been posted as received.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Quantity Invoiced"; Rec."Quantity Invoiced")
                {
                    ToolTip = 'Specifies how many units of the item on the line have been posted as invoiced.';
                    ApplicationArea = All;
                    Editable = false;
                }
            }
        }
    }
    actions
    {
        area(navigation)
        {
            group("&Line")
            {
                Caption = '&Line';
                Image = Line;
                action("Show Document")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Show Document';
                    Image = View;
                    ShortCutKey = 'Shift+F7';
                    ToolTip = 'Open the document that the selected line exists on.';

                    trigger OnAction()
                    var
                        PageManagement: Codeunit "Page Management";
                        PurchHeader: Record "Purchase Header";
                    begin
                        PurchHeader.Get(Rec."Document Type", Rec."Document No.");
                        PageManagement.PageRun(PurchHeader);
                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    var
        VendorLoc: Record Vendor;
    begin
        VendorName := '';
        if VendorLoc.get(rec."Buy-from Vendor No.") then
            VendorName := VendorLoc.name;
    end;

    var
        VendorName: Text[50];

}
