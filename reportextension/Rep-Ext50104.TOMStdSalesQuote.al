reportextension 50104 "TOMStdSalesQuote" extends "Standard Sales - Quote"
{
    //TOM 1.40 Modified report layout to add currency and comments
    dataset
    {
        modify(Header)
        {
            // modify the new, added field
            trigger OnBeforeAfterGetRecord()
            var
                SalesHeaderCommentRec: Record "Sales Comment Line";

            begin
                //Header Comments
                SalesHeaderCommentRec.reset;
                SalesHeaderCommentRec.SetRange("Document Type", SalesHeaderCommentRec."Document Type"::Quote);
                SalesHeaderCommentRec.SetRange("no.", Header."No.");
                SalesHeaderCommentRec.SetRange("Document Line No.", 0);
                if SalesHeaderCommentRec.FindFirst() then
                    repeat
                        HeaderCommentTxt := copystr(HeaderCommentTxt + SalesHeaderCommentRec.Comment, 1, 1024);

                    until SalesHeaderCommentRec.next = 0;
                //Message(HeaderCommentTxt);
                TotalAmtIncVatDecVar := 0;
                CompanyInfoRec.get;
                if CountryRec.get(CompanyInfoRec."Country/Region Code") then;

            end;
        }
        add(Header)
        {
            // add existing field from base table to dataset
            column(Sell_to_Contact; Header."Sell-to Contact") { }
            // add field from table extending Customer
            column(HeaderCommentTxt; HeaderCommentTxt) { }
            column(CountryRecName; CountryRec.Name) { }
        }
        modify(Line)
        {
            trigger OnAfterAfterGetRecord()
            begin
                GenLdgSetup.get;
                //UnitPriceVar := Format(Line."Unit Price") + ' ' + GenLdgSetup."Local Currency Symbol";
                //LineAmount_LineVar := format("Line Amount") + ' ' + GenLdgSetup."Local Currency Symbol";
                UnitPriceVar := GenLdgSetup."Local Currency Symbol" + Format(Line."Unit Price");
                LineAmount_LineVar := GenLdgSetup."Local Currency Symbol" + format("Line Amount");
                TotalAmtIncVatDecVar += Line."Amount Including VAT";
            end;
        }
        add(Line)
        {
            column(UnitPriceVar; UnitPriceVar) { }
            column(LineAmount_LineVar; LineAmount_LineVar) { }
        }
        modify(ReportTotalsLine)
        {
            trigger OnAfterAfterGetRecord()
            begin
                GenLdgSetup.get;
                AmountTotalLineVar := GenLdgSetup."Local Currency Symbol" + Format(ReportTotalsLine.Amount);
            end;
        }
        add(ReportTotalsLine)
        {
            column(AmountTotalLineVar; AmountTotalLineVar) { }
        }

        modify(Totals)
        {
            trigger OnAfterAfterGetRecord()
            begin
                GenLdgSetup.get;
                TotalAmtIncVatVar := GenLdgSetup."Local Currency Symbol" + Format(TotalAmtIncVatDecVar);
            end;
        }
        add(Totals)
        {
            column(TotalAmtIncVatVar; TotalAmtIncVatVar) { }
        }
    }
    var
        HeaderCommentTxt: Text[1024];
        UnitPriceVar: Text[20];
        GenLdgSetup: Record "General Ledger Setup";
        LineAmount_LineVar: Text[20];
        AmountTotalLineVar: text[20];
        TotalAmtIncVatVar: text[20];
        TotalAmtIncVatDecVar: Decimal;
        CompanyInfoRec: Record "Company Information";
        CountryRec: Record "Country/Region";


}
