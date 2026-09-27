xmlport 50102 "TOMUpdateVendRecordLink"
{
    /*
    TOM 1.5 Created new xmlport for Updated Record Link in Vendor
    */
    Caption = 'Update Vendor Record Link';
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
                textelement(VendNo)
                {

                }
                textelement(LinkUrl)
                {

                }
                trigger OnBeforeInsertRecord()
                var
                    Vend: Record Vendor;
                    ID: Integer;
                begin
                    Vend.GET(VendNo);
                    ID := Vend.ADDLINK(LinkUrl, copystr(LinkUrl, 1, 250));
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
