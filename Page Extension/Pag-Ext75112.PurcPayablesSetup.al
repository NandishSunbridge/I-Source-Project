/// <summary>
/// PageExtension Purc. Payables Setup Ext (ID 75112) extends Record Purchases Payables Setup.
/// </summary>
pageextension 75112 "Purc. & Payables Setup Ext" extends "Purchases & Payables Setup"
{
    layout
    {
        // moveafter("Default Qty. to Receive"; "RCM Exempt Start Date (Unreg)")

        addafter("Credit Memo Nos.")
        {
            field("Payment Request Nos."; Rec."Payment Request Nos.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Payment Request Nos. field.';
            }
            field("Purchase Request Nos."; Rec."Purchase Request Nos.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Purchase Request Nos. field.';
            }
            // field("Requisition No."; Rec."Requisition No.")
            // {
            //     ApplicationArea = All;
            //     ToolTip = 'Specifies the value of the Requisition No. field.';
            // }
            field("PR RFQ No."; Rec."PR RFQ No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Requisition No. field.';
            }
            field("Commission GL Code"; Rec."Commission GL Code")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Commission GL Code field.';
            }
            /*   field("Rev Charge For Exp"; Rec."Rev Charge For Exp")
               {
                   ApplicationArea = All;
                   ToolTip = 'Specifies the value of the Rev Charge For Exp field.';
               }*/
        }
    }
}

