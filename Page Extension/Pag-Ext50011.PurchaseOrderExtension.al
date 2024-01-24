pageextension 50011 "Purchase Order Extension" extends "Purchase Order"
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
    actions
    {
        addlast(Category_Category10)
        {
            actionref("PurchaseOrderReport"; "Purchase Order Report")
            {
            }
        }
        addafter("&Print")
        {
            action("Purchase Order Report")
            {
                ApplicationArea = all;
                Caption = 'Purchase Order Report';
                Ellipsis = true;
                Image = Report;
                ToolTip = 'Prepare to print the document. The report request window for the document opens where you can specify what to include on the print-out.';
                trigger OnAction()
                var
                    PurchaseorderReport: Report 50000;
                begin
                    PurchaseHeaderRec.Reset();
                    PurchaseHeaderRec.SetRange("No.", Rec."No.");
                    if PurchaseHeaderRec.FindFirst() then begin
                        Report.Run(50000, true, true, PurchaseHeaderRec);
                        // Report.RunModal(50000, true, false, PurchaseHeaderRec);
                    end;
                end;
            }
        }
    }
    var
        PurchaseHeaderRec: Record "Purchase Header";
}
