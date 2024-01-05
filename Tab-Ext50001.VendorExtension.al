tableextension 50001 "Vendor Extension" extends Vendor
{
    fields
    {
        field(50000; "Blocking Reason"; Text[100])
        {
            Caption = 'Blocking Reason';
            DataClassification = ToBeClassified;
        }
        field(50001; "Vendor Creation Date"; Date)
        {
            Caption = 'Vendor Creation Date';
            DataClassification = ToBeClassified;
        }
        field(50002; "MSME Code"; Code[20])
        {
            Caption = 'MSME Code';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                if "MSME Code" <> '' then begin
                    MSME := true;
                end else begin
                    MSME := false;
                end;
            end;
        }
        field(50003; "T.A.N No."; Code[20])
        {
            Caption = 'T.A.N No.';
            DataClassification = ToBeClassified;
        }
        field(50004; MSME; Boolean)
        {
            Caption = 'MSME';
            DataClassification = ToBeClassified;
        }
        field(50005; "CIN NO."; Code[21])
        {
            Caption = 'CIN NO.';
            DataClassification = ToBeClassified;
        }
    }
}
