pageextension 50143 TOMCompanyInformation extends "Company Information"
{
    layout
    {
        addafter("LAX - COD - Field Group")
        {
            group("Remit-To")
            {
                field("Remit-To Name"; Rec."Remit-To Name")
                {
                    ApplicationArea = All;

                }
                field("Remit-To Address"; Rec."Remit-To Address")
                {
                    ApplicationArea = All;
                }
                field("Remit-To Address 2"; Rec."Remit-To Address 2")
                {
                    ApplicationArea = All;
                }
                field("Remit-To City"; Rec."Remit-To City")
                {
                    ApplicationArea = All;
                }
                field("Remit-To County"; Rec."Remit-To County")
                {
                    ApplicationArea = All;
                }
                field("Remit-To Post Code"; Rec."Remit-To Post Code")
                {
                    ApplicationArea = All;
                }
                field("Remit-To Country/Region Code"; Rec."Remit-To Country/Region Code")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
