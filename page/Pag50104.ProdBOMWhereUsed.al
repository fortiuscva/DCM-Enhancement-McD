page 50104 "Prod BOM Where-Used"
{
    //TOM 1.41 03232022 Created new page to show prod bom where used
    Caption = 'Prod. BOM Where-Used';
    DataCaptionExpression = SetCaption;
    PageType = Worksheet;
    SourceTable = "Where-Used Line";
    SourceTableTemporary = true;
    UsageCategory = Tasks;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            group(Options)
            {
                Caption = 'Options';
                field("Item Filter"; ItemVar)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the item no. for which you want to show the where-used lines';
                    TableRelation = Item."No.";
                    trigger OnValidate()
                    begin
                        Item.SetRange("No.", ItemVar);
                        item.FindSet();
                        BuildForm();
                        CurrPage.Update(false);
                    end;

                    /*trigger OnLookup(var Text: Text): Boolean
                    var
                        ItemLoc: Record Item;
                    begin


                        ItemLoc.RESET;
                        IF Page.RUNMODAL(0, ItemLoc) = ACTION::LookupOK THEN
                            ItemVar := ItemLoc."No.";
                        Item.SetRange("No.", ItemVar);
                        item.FindSet();
                        BuildForm();
                    end;
                    */
                }
                field(CalculateDate; CalculateDate)
                {
                    ApplicationArea = Manufacturing;
                    Caption = 'Calculation Date';
                    ToolTip = 'Specifies the date for which you want to show the where-used lines.';

                    trigger OnValidate()
                    begin
                        CalculateDateOnAfterValidate;
                    end;
                }
                field(ShowLevel; ShowLevel)
                {
                    ApplicationArea = Manufacturing;
                    Caption = 'Levels';
                    OptionCaption = 'Single,Multi';
                    ToolTip = 'Specifies the level of detail for the where-used lines.';

                    trigger OnValidate()
                    begin
                        ShowLevelOnAfterValidate;
                    end;
                }
            }
            repeater(Control1)
            {
                Editable = false;
                IndentationColumn = DescriptionIndent;
                IndentationControls = Description;
                ShowCaption = false;
                field("Item No."; rec."Item No.")
                {
                    ApplicationArea = Manufacturing;
                    ToolTip = 'Specifies the number of the item that the base item or production BOM is assigned to.';
                }
                field("Version Code"; rec."Version Code")
                {
                    ApplicationArea = Manufacturing;
                    ToolTip = 'Specifies the version code of the production BOM that the item or production BOM component is assigned to.';
                }
                field(Description; rec.Description)
                {
                    ApplicationArea = Manufacturing;
                    ToolTip = 'Specifies the description of the item to which the item or production BOM component is assigned.';
                }
                field("Quantity Needed"; rec."Quantity Needed")
                {
                    ApplicationArea = Manufacturing;
                    ToolTip = 'Specifies the quantity of the item or the production BOM component that is needed for the assigned item.';
                }
            }
        }
        area(factboxes)
        {
            systempart(Control1900383207; Links)
            {
                ApplicationArea = RecordLinks;
                Visible = false;
            }
            systempart(Control1905767507; Notes)
            {
                ApplicationArea = Notes;
                Visible = false;
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Prod BOM Version")
            {
                ApplicationArea = all;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = page "Prod. BOM Version List";
                RunPageLink = "Production BOM No." = field("Item No.");

            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        DescriptionIndent := 0;
        DescriptionOnFormat;
    end;

    trigger OnFindRecord(Which: Text): Boolean
    begin
        exit(WhereUsedMgt.FindRecord(Which, Rec));
    end;

    trigger OnNextRecord(Steps: Integer): Integer
    begin
        exit(WhereUsedMgt.NextRecord(Steps, Rec));
    end;

    trigger OnOpenPage()
    begin
        //BuildForm;
        CalculateDate := today;
    end;

    var
        Item: Record Item;
        ProdBOM: Record "Production BOM Header";
        WhereUsedMgt: Codeunit "Where-Used Management";
        CalculateDate: Date;
        [InDataSet]
        DescriptionIndent: Integer;
        ItemVar: Code[20];

    protected var
        ShowLevel: Option Single,Multi;

    procedure SetProdBOM(NewProdBOM: Record "Production BOM Header"; NewCalcDate: Date)
    begin
        ProdBOM := NewProdBOM;
        CalculateDate := NewCalcDate;
    end;

    procedure SetItem(NewItem: Record Item; NewCalcDate: Date)
    begin
        Item := NewItem;
        CalculateDate := NewCalcDate;
    end;

    local procedure BuildForm()
    begin
        if ProdBOM."No." <> '' then
            WhereUsedMgt.WhereUsedFromProdBOM(ProdBOM, CalculateDate, ShowLevel = ShowLevel::Multi)
        else
            WhereUsedMgt.WhereUsedFromItem(Item, CalculateDate, ShowLevel = ShowLevel::Multi);
    end;

    procedure SetCaption(): Text
    begin
        if ProdBOM."No." <> '' then
            exit(ProdBOM."No." + ' ' + ProdBOM.Description);

        exit(Item."No." + ' ' + Item.Description);
    end;

    local procedure CalculateDateOnAfterValidate()
    begin
        BuildForm;
        CurrPage.Update(false);
    end;

    local procedure ShowLevelOnAfterValidate()
    begin
        BuildForm;
        CurrPage.Update(false);
    end;

    local procedure DescriptionOnFormat()
    begin
        DescriptionIndent := rec."Level Code" - 1;
    end;
}

