pageextension 50018 "Posted Sales Invoice Exten" extends "Posted Sales Invoice"
{
    actions
    {
        addlast(Category_Category6)
        {
            actionref("CustomerInvoiceReport"; "Customer Invoice Report")
            {
            }
        }
        addafter(Print)
        {
            action("Customer Invoice Report")
            {
                ApplicationArea = all;
                Caption = 'Customer Invoice Report';
                Ellipsis = true;
                Image = Report;
                ToolTip = 'Prepare to print the document. The report request window for the document opens where you can specify what to include on the print-out.';
                trigger OnAction()
                var
                    CustomerInvoiceReport: Report 50001;
                begin
                    // SalesHeaderRec.Reset();
                    // SalesHeaderRec.SetRange("No.", Rec."No.");
                    // if SalesHeaderRec.FindFirst() then begin
                    Report.Run(50001, true, true, Rec);
                    // end;
                end;
            }
        }
    }
}
