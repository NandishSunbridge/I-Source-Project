tableextension 50007 "General Journal Line Ext" extends "Gen. Journal Line"
{
    fields
    {
        field(50000; "P.A.N. No."; Code[10])
        {
            Caption = 'P.A.N. No.';
            DataClassification = ToBeClassified;
        }
        field(50001; "Party T.A.N. No."; Code[20])
        {
            Caption = 'Party T.A.N. No.';
            DataClassification = ToBeClassified;
        }
        modify("Account No.")
        {
            trigger OnAfterValidate()
            begin
                case "Account Type" of
                    "Account Type"::Customer:
                        GetCustomerPanTan();
                    "Account Type"::Vendor:
                        GetVendorPanTan();
                end;
            end;
        }
    }
    local procedure GetCustomerPanTan()
    begin
        CustomerRec.Reset();
        CustomerRec.SetRange("No.", Rec."Account No.");
        if CustomerRec.FindFirst() then begin
            "P.A.N. No." := CustomerRec."P.A.N. No.";
            "Party T.A.N. No." := CustomerRec."T.A.N. No.";
        end;
    end;

    local procedure GetVendorPanTan()
    begin
        VendorRec.Reset();
        VendorRec.SetRange("No.", Rec."Account No.");
        if VendorRec.FindFirst() then begin
            "P.A.N. No." := VendorRec."P.A.N. No.";
            "Party T.A.N. No." := VendorRec."T.A.N No.";
        end;
    end;

    var
        VendorRec: Record vendor;
        CustomerRec: Record Customer;
}
