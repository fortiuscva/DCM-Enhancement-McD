pageextension 50111 "TOMVendorCard" extends "Vendor Card"
{
    layout
    {
        addlast(General)
        {
            field("Date Created"; rec."Date Created")
            {
                Editable = false;
                ApplicationArea = All;

            }
        }
    }
}
