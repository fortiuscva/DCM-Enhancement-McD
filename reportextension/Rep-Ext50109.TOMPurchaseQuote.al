reportextension 50109 "TOMPurchaseQuote" extends "Purchase Quote NA"
{
    //TOM 1.46 Added Description 2 field to description
    dataset
    {
        add("Purchase Line")
        {
            column(Description2; "Purchase Line"."Description 2")
            {

            }

        }
    }
}