reportextension 50110 "TOMPurchaseOrder" extends "Standard Purchase - Order"
{
    // Added Description 2 field to description
    //DefaultLayout = RDLC;
    RDLCLayout = './reportlayout/TOMPurchaseOrder.rdl';
    dataset
    {
        modify("Purchase Header")
        {
            trigger OnAfterAfterGetRecord()
            begin
                CompInfo.Get;
                RemitToAddr[1] := CompInfo."Remit-To Name";
                RemitToAddr[2] := CompInfo."Remit-To Address";
                RemitToAddr[3] := CompInfo."Remit-To Address 2";
                RemitToAddr[4] := CompInfo."Remit-To City" + ' ' + CompInfo."Remit-To County" + ' ' + CompInfo."Remit-To Post Code";
                RemitToAddr[5] := CompInfo."Remit-To Country/Region Code";
                CompressArray(RemitToAddr);
            end;
        }
        add("Purchase Line")
        {
            column(Description2; "Purchase Line"."Description 2")
            {

            }

        }
        add("Purchase Header")
        {
            column(RemitToAddr1; RemitToAddr[1])
            { }
            column(RemitToAddr2; RemitToAddr[2])
            { }
            column(RemitToAddr3; RemitToAddr[3])
            { }
            column(RemitToAddr4; RemitToAddr[4])
            { }
            column(RemitToAddr5; RemitToAddr[5])
            { }
            column(RemitToAddr6; RemitToAddr[6])
            { }
            column(RemitToAddr7; RemitToAddr[7])
            { }
        }


    }
    var
        CompInfo: Record "Company Information";
        RemitToAddr: array[8] of Text[100];
}