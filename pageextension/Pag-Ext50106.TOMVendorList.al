pageextension 50106 "TOMVendorList" extends "Vendor List"
{   /*
    TOM 1.5 Added "Update Record Link action"
    TOM 1.22 12272021 Added new field of type Date "Date Created"
    */
    layout
    {
        addafter("Payments (LCY)")
        {
            field("Date Created"; rec."Date Created")
            {
                Editable = false;
                ApplicationArea = All;

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
                    XMLport.Run(50102);
                end;
            }
        }
    }
}
