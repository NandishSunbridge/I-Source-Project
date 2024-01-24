/// <summary>
/// TableExtension PurchasesPaya. Setup Ext (ID 75114) extends Record PurchasesPayables Setup.
/// </summary>
tableextension 75114 "Purchases & Paya. Setup Ext" extends "Purchases & Payables Setup"
{
    fields
    {
        field(50000; "Payment Request Nos."; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "No. Series";
            Caption = 'Payment Request Nos.';
        }
        field(50001; "Purchase Request Nos."; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "No. Series";
            Caption = 'Purchase Request Nos.';
        }
        field(50004; "PR RFQ No."; Code[20])
        {
            DataClassification = CustomerContent;
            Description = 'TableRelation="No. Series"';
            Caption = 'PR RFQ No.';
            TableRelation = "No. Series";
        }
        field(50006; "Commission GL Code"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "G/L Account";
            Caption = 'Commission GL Code';
        }
        /* field(50008; "Rev Charge For Exp"; Code[20])
         {
             DataClassification = ToBeClassified;
             Caption = 'Rev Charge For Exp';
             TableRelation = "No. Series";
         }*/
    }
}