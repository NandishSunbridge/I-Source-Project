pageextension 50001 "Vendor Card Extension" extends "Vendor Card"
{
    layout
    {
        addafter(Blocked)
        {
            field("Blocking Reason"; Rec."Blocking Reason")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Vendor Blocking Reason.';
                Enabled = (Rec.Blocked <> Rec.Blocked::" ");
                ShowMandatory = (Rec.Blocked <> Rec.Blocked::" ");
            }
        }
        addafter("Registration Number")
        {
            field("MSME Code"; Rec."MSME Code")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the MSME Code field.';
            }
        }
        addbefore("Last Date Modified")
        {
            field("Vendor Creation Date"; Rec."Vendor Creation Date")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Vendor Creation Date field.';
            }
        }
        addafter("P.A.N. No.")
        {
            field("T.A.N No."; Rec."T.A.N No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the T.A.N No. field.';
            }
            field("CIN NO."; Rec."CIN NO.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the CIN NO. field.';
            }
        }

    }
}
