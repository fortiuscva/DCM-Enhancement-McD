codeunit 50122 "TOMUpdate Net Available"
{

    trigger OnRun()
    var
        ItemLclRec: Record item;
        NetDemand: Decimal;
        NetSupply: Decimal;
    begin
        ItemLclRec.Reset();
        //ItemLclRec.SETRANGE(Blocked, FALSE);
        IF ItemLclRec.FINDSET THEN BEGIN
            REPEAT
                CLEAR(NetDemand);
                CLEAR(NetSupply);
                ItemLclRec.CALCFIELDS(ItemLclRec.Inventory, ItemLclRec."Purch. Req. Receipt (Qty.)", ItemLclRec."Qty. on Purch. Order",
                ItemLclRec."Qty. on Prod. Order", ItemLclRec."Qty. in Transit", ItemLclRec."Qty. on Assembly Order",
                ItemLclRec."Qty. on Sales Order", ItemLclRec."Qty. on Service Order", ItemLclRec."Qty. on Component Lines",
                ItemLclRec."Qty. on Job Order", ItemLclRec."Qty. on Asm. Component");

                NetSupply := ItemLclRec.Inventory + ItemLclRec."Purch. Req. Receipt (Qty.)" + ItemLclRec."Qty. on Purch. Order" +
                            ItemLclRec."Qty. on Prod. Order" + ItemLclRec."Qty. in Transit" + ItemLclRec."Qty. on Assembly Order";

                NetDemand := ItemLclRec."Qty. on Sales Order" + ItemLclRec."Qty. on Service Order" + ItemLclRec."Qty. on Component Lines" +
                            ItemLclRec."Qty. on Job Order" + ItemLclRec."Qty. on Asm. Component";

                ItemLclRec."Net Available" := NetSupply - NetDemand;
                ItemLclRec.MODIFY;
            UNTIL ItemLclRec.NEXT = 0;
        END;
    end;
}
