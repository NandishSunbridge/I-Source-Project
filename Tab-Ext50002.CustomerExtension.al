tableextension 50002 "Customer Extension" extends Customer
{
    fields
    {
        field(50000; "IFSC Code"; Code[20])
        {
            Caption = 'IFSC Code';
            DataClassification = ToBeClassified;
        }
        field(50001; "T.A.N. No."; Code[20])
        {
            Caption = 'T.A.N. No.';
            DataClassification = ToBeClassified;
        }
    }
}
