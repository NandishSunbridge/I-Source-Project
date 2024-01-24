tableextension 50012 "Purchase Line Ext" extends "Purchase Line"
{
    fields
    {
        field(50000; "Service Duration"; Code[20])
        {
            Caption = 'Service Duration';
            DataClassification = ToBeClassified;
        }
    }
}
