pageextension 50109 "TOMItemReferenceEntries" extends "Item Reference Entries"
{
    //TOM 1.16 12232021 ItemNo field added
    layout
    {
        modify("Reference Type No.")
        {
            trigger OnAfterValidate()
            begin
                UpdatedReferenceTypeName();
            end;
        }
        addafter("Reference No.")
        {
            field("Reference Type Name"; rec."Reference Type Name")
            {
                ApplicationArea = all;
            }
            field("Manufacturer Code"; Rec."Manufacturer Code")
            {
                ApplicationArea = All;
            }
            field("Manufacturer Name"; Rec."Manufacturer Name")
            {
                ApplicationArea = All;
            }
            field("Manufacturer Item No."; Rec."Manufacturer Item No.")
            {
                ApplicationArea = All;
            }
        }
        addfirst(Control1)
        {
            field("Item No."; Rec."Item No.")
            {
                ApplicationArea = All;
            }

        }

    }
    trigger OnAfterGetRecord()
    begin
        UpdatedReferenceTypeName();
    end;

    procedure UpdatedReferenceTypeName()
    var
        CustomerRecLcl: Record Customer;
        VendorRecLcl: Record Vendor;
    begin
        if Rec."Reference Type" = Rec."Reference Type"::Customer then begin
            if CustomerRecLcl.Get(Rec."Reference Type No.") then
                Rec."Reference Type Name" := CustomerRecLcl.Name
            else
                Rec."Reference Type Name" := '';
        end else
            if Rec."Reference Type" = Rec."Reference Type"::Vendor then begin
                if VendorRecLcl.Get(Rec."Reference Type No.") then
                    Rec."Reference Type Name" := VendorRecLcl.Name
                else
                    Rec."Reference Type Name" := '';
            end;
    end;
}
