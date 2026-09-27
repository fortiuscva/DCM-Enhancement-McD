tableextension 50114 "TOMPurchaseHeader" extends "Purchase Header"
{
    //TOM 1.36 03202022 MK Created extension to add new field Vendor Status
    fields
    {
        field(50100; "Vendor Status"; Option)
        {
            Caption = 'Vendor Status';
            DataClassification = ToBeClassified;
            OptionMembers = " ",Approved,Rejected,"Waiting on Vendor","Waiting on Customer";
        }
        field(50101; "Quote Expiration Date"; Date)
        { }
    }
    trigger Oninsert()
    var
        myInt: Integer;
    begin
        IF "Document Type" = "Document Type"::Order then
        "Vendor Order No." := GetVendorOrderNo("No.");
    end;
    local procedure GetVendorOrderNo(str: Text): Text
    var
        IntStr: Text;
        TextStr: Text;
        J: Integer;
        K: Text;
    begin
        IntStr := '';
        TextStr := '';
        for J := 1 to StrLen(str) do begin
          K := CopyStr(str,J,1);
          case K of
           '0'..'9':
              IntStr := IntStr + K;
             '-':
              IntStr := IntStr + K;
           else
             TextStr := TextStr + K;
          end;
        end;

        IF COPYSTR(IntStr,1,1) = '-' THEN
            IntStr := DELSTR(IntStr,1,1);
        exit(IntStr);
    end;
}
