pageextension 50145 TOMLAXPostedPackage extends "LAX Posted Package"
{
    layout
    {
        addafter("Shipping Cost")
        {
            field(TOMCalculationInsuredValue; Rec."Calculation Insured Value")
            {
                ApplicationArea = All;
                Caption = 'Calculation Insured Value';
            }
        }
    }
}
