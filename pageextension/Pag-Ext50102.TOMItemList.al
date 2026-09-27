pageextension 50102 "TOMItemList" extends "Item List"
{
    /*
    TOM 1.4 10312021 Added field Description 2
    TOM 1.5 Added "Update Record Link" to Item List
    TOM 1.22 12272021 Added new field of type Date "Date Created"
    TOM 1.23 01102022 Expose the Vendor Name field to the Item List page (this field is already exposed on the Item Card).
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
        addafter("Vendor No.")
        {
            field("Date Created"; rec."Date Created")
            {
                Editable = false;
                ApplicationArea = All;

            }
        }
        addafter(InventoryField)
        {
            field("Qty. on ALB"; Rec."Qty. on ALB")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the total quantity of the item that is currently in inventory at all locations.';
            }
            field("Vendor Name"; rec."Vendor Name")
            {
                ApplicationArea = All;
            }
        }
        addfirst(factboxes)
        {
            part(ItemSupplyFactbox; TOMItemSupplyFactbox)
            {
                ApplicationArea = All;
                SubPageLink = "No." = field("No.");
            }
        }
        addafter(ItemSupplyFactbox)
        {
            part(ItemDemandFactbox; TOMItemDemandFactbox)
            {
                ApplicationArea = All;
                SubPageLink = "No." = field("No.");
            }
            part(BinContent; "Bin Content FactBox")
            {
                ApplicationArea = All;
                SubPageLink = "Item No." = field("No.");
            }
        }
    }
    actions
    {
        addfirst(processing)
        {
            action(UpdateLink)
            {
                Caption = 'Update Record Link';
                ApplicationArea = All;
                Image = Links;
                trigger OnAction()
                begin
                    XMLport.Run(50100);
                end;
            }
        }

    }

    trigger OnAfterGetRecord()
    begin
        Rec.CalcFields("Qty. on ALB");
    end;
}
