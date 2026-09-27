pageextension 50124 "TOMBlanPurchOrder" extends "Blanket Purchase Order"
{
    layout
    {
        //TOM 1.37 03202022 MK Created extension to add new field Vendor Status
        addlast(General)
        {
            field("Vendor Status"; Rec."Vendor Status")
            {
                ApplicationArea = all;
            }
        }
    }
}