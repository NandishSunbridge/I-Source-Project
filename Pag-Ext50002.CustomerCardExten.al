pageextension 50002 "Customer Card Exten" extends "Customer Card"
{
    layout
    {
        addafter("P.A.N. No.")
        {
            field("T.A.N. No."; Rec."T.A.N. No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the T.A.N. No. field.';
            }
        }
    }
}
