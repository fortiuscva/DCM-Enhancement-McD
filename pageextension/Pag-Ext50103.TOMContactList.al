pageextension 50103 "TOMContactList" extends "Contact List"
{
    /*
    TOM 1.6 11122021 Adding new field "Organizational Level Code" in contact List page
    TOM 1.7 11042021 Added new field "Customer/Vendor No."
    */
    layout
    {
        addafter(Minor)
        {
            field("Organizational Level Code"; rec."Organizational Level Code")
            {
                ApplicationArea = All;
            }
        }


        addafter("Business Relation")
        {
            field("Vendor Name"; rec."Customer/Vendor No.")
            {
                ApplicationArea = All;
            }
        }

    }
}
