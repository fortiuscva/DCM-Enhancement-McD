reportextension 50112 "TOMPhysInventoryList" extends "Phys. Inventory List"
{
    dataset
    {
        add("Item Journal Line")
        {
            column(SelfNo; Item."Shelf No.")
            { }
        }
        modify("Item Journal Line")
        {
            trigger OnBeforeAfterGetRecord()
            begin
                IF Item.GET("Item Journal Line"."Item No.") THEN;
            end;
        }
    }
    var
        Item: Record item;
}
