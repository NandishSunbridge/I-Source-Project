tableextension 50009 "Purchase Header Extension" extends "Purchase Header"
{
    fields
    {
        field(50000; "P.A.N. No."; Code[10])
        {
            Caption = 'P.A.N. No.';
            DataClassification = ToBeClassified;
        }
        field(50001; "T.A.N. No."; Code[20])
        {
            Caption = 'T.A.N. No.';
            DataClassification = ToBeClassified;
            TableRelation = "TAN Nos.";
        }
    }
}
