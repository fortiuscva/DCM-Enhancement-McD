pageextension 50131 "Pag-50130.TOMRegWhsPickList" extends "Registered Whse. Picks"
{
    //TOM 1.54 04232022 Added Registering Date field
    layout
    {
        addafter("No. Series")
        {
            field("Registering Date"; rec."Registering Date")
            {
                ApplicationArea = All;
            }
        }
    }
}
