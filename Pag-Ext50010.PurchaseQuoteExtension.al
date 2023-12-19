pageextension 50010 "Purchase Quote Extension" extends "Purchase Quote"
{
    layout
    {
        addafter("Invoice Type")
        {
            field("P.A.N. No."; Rec."P.A.N. No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the P.A.N. No. field.';
            }
            field("T.A.N. No."; Rec."T.A.N. No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the T.A.N. No. field.';
            }
        }
    }
}
