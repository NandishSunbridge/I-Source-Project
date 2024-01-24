tableextension 50010 "Sales Line Extension" extends "Sales Line"
{
    fields
    {
        field(50000; "License Keys"; Text[100])
        {
            Caption = 'License Keys';
            DataClassification = ToBeClassified;
        }
        field(50001; "Domain ID"; Text[50])
        {
            Caption = 'Domain ID';
            DataClassification = ToBeClassified;
        }
        field(50002; "Tenant ID"; Text[50])
        {
            Caption = 'Tenant ID';
            DataClassification = ToBeClassified;
        }
    }
}
