xmlport 50101 "TOMUpdateCustRecordLink"
{
    /*
    TOM 1.5 Created new xmlport for Updated Record Link in Customer
    */

    Caption = 'Update Customer Record Link';
    Direction = Import;
    FieldDelimiter = '"';
    FieldSeparator = ',';
    Format = VariableText;
    FormatEvaluate = Legacy;
    TextEncoding = WINDOWS;


    schema
    {
        textelement(Root)
        {
            tableelement(Integer; Integer)
            {
                AutoSave = false;
                textelement(CustoNo)
                {

                }
                textelement(LinkUrl)
                {

                }
                trigger OnBeforeInsertRecord()
                var
                    Cust: Record Customer;
                    ID: Integer;
                begin
                    Cust.GET(CustoNo);
                    ID := Cust.ADDLINK(LinkUrl, copystr(LinkUrl, 1, 250));
                end;
            }

        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(processing)
            {
            }
        }
    }
}
