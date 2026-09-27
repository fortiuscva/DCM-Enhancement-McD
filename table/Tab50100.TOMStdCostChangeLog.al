table 50100 "TOMStdCostChangeLog"
{
    Caption = 'Std. Cost Change Log';
    DataClassification = ToBeClassified;
    
    fields
    {
         field(1;"Entry No.";Integer)
        {
            NotBlank = true;
        }
        field(2;"Item No.";Code[20])
        {
            NotBlank = true;
            TableRelation = Item;
        }
        field(3;"Action Date";Date)
        {
        }
        field(4;"Calculation Date";Date)
        {
        }
        field(6;"User ID";Code[50])
        {
        }
        field(7;"Entry Type";Option)
        {
            Description = 'Std Cost Calc,Current Cost Calc,Std Cost Field Change';
            OptionMembers = "Std Cost Calc","Current Cost Calc","Std Cost Field Change","Mass Update";
        }
        field(8;"Calculation Method";Option)
        {
            Description = ' ,Single Level,Rolled-up Cost';
            OptionMembers = " ","Single Level","Rolled-up Cost";
        }
        field(9;"Previous Std. Cost";Decimal)
        {
        }
        field(10;"Calcd or Entered Std. Cost";Decimal)
        {
        }
        field(11;"Item Card Lot Size";Decimal)
        {
        }
        field(12;"Current Cost Calc Lot Size";Decimal)
        {
        }
        field(13;"Calculated Current Cost";Decimal)
        {
        }
        field(20;"Time of Day";Time)
        {
        }
        field(30;"Last UnitCost Calc BOM No.";Code[20])
        {
            Editable = false;
            TableRelation = "Production BOM Header";
        }
        field(31;"Last UnitCost Calc BOM Rev.";Code[20])
        {
            Editable = false;
        }
        field(32;"Last UnitCost Calc Router No.";Code[20])
        {
            Editable = false;
            TableRelation = "Routing Header";
        }
        field(33;"Last UnitCost Calc Router Rev.";Code[20])
        {
            Editable = false;
        }
        field(40;"Last CurrCost Calc BOM No.";Code[20])
        {
            Editable = false;
            TableRelation = "Production BOM Header";
        }
        field(41;"Last CurrCost Calc BOM Rev.";Code[20])
        {
            Editable = false;
        }
        field(42;"Last CurrCost Calc Router No.";Code[20])
        {
            Editable = false;
            TableRelation = "Routing Header";
        }
        field(43;"Last CurrCost Calc Router Rev.";Code[20])
        {
            Editable = false;
        }
        field(50;"Indirect Cost %";Decimal)
        {
        }
        field(51;"Scrap %";Decimal)
        {
        }
        field(52;"Overhead Rate";Decimal)
        {
        }
        field(53;"Cost Factor";Decimal)
        {
        }
    }
    keys
    {
       key(Key1;"Entry No.")
        {
        }
        key(Key2;"Item No.","Action Date")
        {
        }
    }
}
