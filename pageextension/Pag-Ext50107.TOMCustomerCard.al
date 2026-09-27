pageextension 50107 "TOMCustomerCard" extends "Customer Card"
{
    /*
    TOM 1.9 12032021 Added new fields  "Customer Parent","Customer Parent Name"
    */
    layout
    {
        addafter("Salesperson Code")
        {
            field("Customer Parent"; rec."Customer Parent")
            {
                ApplicationArea = All;
                trigger OnValidate()
                begin
                    CurrPage.SaveRecord();
                    CurrPage.Update(false);
                end;
            }
            field("Customer Parent Name"; rec."Customer Parent Name")
            {
                ApplicationArea = All;

            }
        }
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
