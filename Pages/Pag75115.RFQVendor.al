page 75115 "RFQ Vendor"
{
    AutoSplitKey = true;
    Caption = 'RFQ Vendor';
    PageType = ListPart;
    //DelayedInsert = true; //AA25052023 //Discussion
    SourceTable = "RFQ Vendor";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Line No."; Rec."Line No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Line No field.';
                    Editable = false;
                }
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Document No field.';
                    Editable = false;
                }
                field("Vendor No."; Rec."Vendor No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Vendor No. field.';
                }
                field("Vendor Name"; Rec."Vendor Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Vendor Name field.';
                }
                field("Vendor GST No."; Rec."Vendor GST No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Vendor GST No. field.';
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Remarks field.';
                }
            }
        }
    }
}
