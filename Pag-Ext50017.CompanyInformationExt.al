pageextension 50017 "Company Information Ext" extends "Company Information"
{
    layout
    {
        addafter("Industrial Classification")
        {
            field("CIN NO."; Rec."CIN NO.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the CIN NO. field.';
            }
        }
    }
}
