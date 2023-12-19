pageextension 50006 "General Journal Exten" extends "General Journal"
{
    layout
    {
        addbefore("T.A.N. No.")
        {
            field("P.A.N. No."; Rec."P.A.N. No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the P.A.N. No. field.';
            }
        }
    }
}
