pageextension 50105 "TOMCustomerList" extends "Customer List"
{
    /*
    TOM 1.9 12032021 Added new fields in customer table "Customer Parent","Customer Parent Name"
    TOM 1.5 Added new action "Update Record Link" 
    TOM 1.22 12272021 Added new field of type Date "Date Created"
    */
    layout
    {
        addafter(Name)
        {
            field("Customer Parent"; rec."Customer Parent")
            {
                ApplicationArea = All;
            }
            field("Customer Parent Name"; rec."Customer Parent Name")
            {
                ApplicationArea = All;
            }
        }
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
                    XMLport.Run(50101);
                end;
            }
        }
    }
}
