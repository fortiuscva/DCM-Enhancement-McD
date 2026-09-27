tableextension 50110 "TOMItemReference" extends "Item Reference"
{
    //TOM 1.16 12232021 Added table relation to lookup manufacturer page
    fields
    {
        modify("Reference Type No.")
        {

            TableRelation = IF ("Reference Type" = CONST("Manufacturer Code")) Manufacturer.Code;

            trigger OnAfterValidate()
            var
                CustomerRecLcl: Record Customer;
                VendorRecLcl: Record Vendor;
            begin
                if "Reference Type" = "Reference Type"::Customer then begin
                    if CustomerRecLcl.Get("Reference No.") then
                        "Reference Type Name" := CustomerRecLcl.Name
                    else
                        "Reference Type Name" := '';
                end else
                    if "Reference Type" = "Reference Type"::Vendor then begin
                        if VendorRecLcl.Get("Reference No.") then
                            "Reference Type Name" := VendorRecLcl.Name
                        else
                            "Reference Type Name" := '';
                    end;

            end;
        }
        field(50001; "Manufacturer Code"; Code[10])

        {
            TableRelation = Manufacturer.Code;
            trigger OnValidate()
            var
                Manuf: Record Manufacturer;
            begin
                IF Manuf.get("Manufacturer Code") then
                    "Manufacturer Name" := Manuf.Name
                else
                    "Manufacturer Name" := '';


            end;
        }
        field(50002; "Manufacturer Name"; Text[50])
        {

        }
        field(50003; "Manufacturer Item No."; Text[50])
        {

        }
        field(50010; "Reference Type Name"; Text[100])
        {
            Caption = 'Reference Type Name';
            Editable = false;
            TableRelation = if ("Reference Type" = const(Customer)) Customer.Name
            else
            if ("Reference Type" = const(Vendor)) Vendor.Name;
        }
    }
}
