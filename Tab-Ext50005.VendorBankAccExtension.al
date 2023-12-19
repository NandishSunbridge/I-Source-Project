tableextension 50005 "Vendor Bank Acc Extension" extends "Vendor Bank Account"
{
    fields
    {
        field(50000; "IFSC Code"; Code[20])
        {
            Caption = 'IFSC Code';
            DataClassification = ToBeClassified;
        }
    }
}
