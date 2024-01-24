tableextension 50004 "Cust Bank Acc Extension" extends "Customer Bank Account"
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
