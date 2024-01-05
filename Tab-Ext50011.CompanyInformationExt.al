tableextension 50011 "Company Information Ext" extends "Company Information"
{
    fields
    {
        field(50000; "CIN NO."; Code[21])
        {
            Caption = 'CIN NO.';
            DataClassification = ToBeClassified;
        }
    }
}
