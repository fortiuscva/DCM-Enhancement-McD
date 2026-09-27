pageextension 50108 "TOMContactCard" extends "Contact Card"
{
    /*
    TOM 1.7 12032021 Added new field in Contact table and contact list page "Customer/Vendor No."
    */
    layout
    {
        addafter("Contact Business Relation")
        {
            field("Vendor Name"; rec."Customer/Vendor No.")
            {
                ApplicationArea = All;
            }
        }
    }
}
