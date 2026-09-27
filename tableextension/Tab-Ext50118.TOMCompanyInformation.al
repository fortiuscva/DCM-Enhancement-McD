tableextension 50118 "TOMCompanyInformation" extends "Company Information"
{
    fields
    {

        field(50101; "Remit-To Name"; Text[100])
        {

            DataClassification = ToBeClassified;
        }

        field(50102; "Remit-To Address"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50103; "Remit-To Address 2"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50104; "Remit-To City"; Text[30])
        {
            TableRelation = IF ("Country/Region Code" = CONST('')) "Post Code".City
            ELSE
            IF ("Country/Region Code" = FILTER(<> '')) "Post Code".City WHERE("Country/Region Code" = FIELD("Country/Region Code"));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnLookup()
            begin
                PostCode.LookupPostCode("Remit-To City", "Remit-To Post Code", "Remit-To County", "Remit-To Country/Region Code");
            end;

            trigger OnValidate()
            begin
                PostCode.ValidateCity("Remit-To City", "Remit-To Post Code", "Remit-To County", "Remit-To Country/Region Code", (CurrFieldNo <> 0) and GuiAllowed);
            end;
        }
        field(50105; "Remit-To County"; Text[30])
        {
            Caption = 'Remit-To State';
        }
        field(50106; "Remit-To Post Code"; Code[20])
        {
            Caption = 'Remit-To Zip Code';
            TableRelation = IF ("Remit-To Country/Region Code" = CONST('')) "Post Code".Code
            ELSE
            IF ("Remit-To Country/Region Code" = FILTER(<> '')) "Post Code".Code WHERE("Country/Region Code" = FIELD("Remit-To Country/Region Code"));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnLookup()
            begin
                PostCode.LookupPostCode("Remit-To City", "Remit-to Post Code", "Remit-to County", "Remit-to Country/Region Code");
            end;

            trigger OnValidate()
            var
            //O365SalesInitialSetup: Record "O365 Sales Initial Setup";
            //CountryRegionCode: Code[10];
            begin
                /* if O365SalesInitialSetup.Get and O365SalesInitialSetup."Is initialized" then begin
                    CountryRegionCode := "Remit-to Country/Region Code";
                    PostCode.ValidatePostCode("Remit-To City", "Remit-To Post Code", "Remit-To County", CountryRegionCode, (CurrFieldNo <> 0) and GuiAllowed);
                    exit;
                end; */

                PostCode.ValidatePostCode("Remit-To City", "Remit-To Post Code", "Remit-To County", "Remit-To Country/Region Code", (CurrFieldNo <> 0) and GuiAllowed);
            end;
        }

        field(50107; "Remit-To Country/Region Code"; Code[10])
        {
            Caption = 'Remit-To Country/Region Code';
            TableRelation = "Country/Region";

            trigger OnValidate()
            begin
                PostCode.CheckClearPostCodeCityCounty("Remit-To City", "Remit-To Post Code", "Remit-To County", "Remit-To Country/Region Code", xRec."Remit-To Country/Region Code");
            end;
        }

    }
    var
        PostCode: Record "Post Code";
}
