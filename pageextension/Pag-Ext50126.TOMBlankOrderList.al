pageextension 50126 "TOMBlankOrderList" extends "Blanket Purchase Orders"
{

    layout
    {
        //TOM 1.37 03202022 MK Created extension to add new field Vendor Status
        addafter("Assigned User ID")
        {
            field("Vendor Status"; Rec."Vendor Status")
            {
                ApplicationArea = all;
            }
        }
    }
}

