pageextension 50005 "Vendor Bank Acc Card Exten" extends "Vendor Bank Account Card"
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
