pageextension 50004 "Cust Bank Account Card Exten" extends "Customer Bank Account Card"
{
    layout
    {
        addafter("SWIFT Code")
        {
            field("IFSC Code"; Rec."IFSC Code")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the IFSC Code field.';
            }
        }
    }
}
