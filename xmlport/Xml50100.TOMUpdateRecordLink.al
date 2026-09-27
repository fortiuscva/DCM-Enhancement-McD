xmlport 50100 "TOMUpdateRecordLink"
{
    /*
    TOM 1.5 Created new xmlport for Updated Record Link in Item
    */

    Caption = 'Update Record Link';
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
                textelement(ItemNo)
                {

                }
                textelement(LinkUrl)
                {

                }
                trigger OnBeforeInsertRecord()
                var
                    item: Record Item;
                    ID: Integer;
                begin
                    item.GET(ItemNo);
                    ID := item.ADDLINK(LinkUrl, copystr(LinkUrl, 1, 250));
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
