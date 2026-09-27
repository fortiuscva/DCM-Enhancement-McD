pageextension 50130 "Pag-50130.TOMRegWhsPutAwayList" extends "Registered Whse. Put-aways"
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
