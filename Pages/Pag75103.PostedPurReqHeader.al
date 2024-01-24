/// <summary>
/// Page Posted Pur Req Header (ID 75103).
/// </summary>
page 75103 "Posted Pur Req Header"
{
    Editable = false;
    PageType = Card;
    SourceTable = "Posted Pur Requisition Header";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Document No. field.';
                }
                field("Document Date"; Rec."Document Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Document Date field.';
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Shortcut Dimension 1 Code field.';
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Shortcut Dimension 2 Code field.';
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Location Code field.';
                }
                field("Requisition Type"; Rec."Requisition Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Requisition Type field.';
                }
                /* field("Dept. Code"; Rec."Dept. Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Dept. Code field.';
                }
                field("Dept Name"; Rec."Dept Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Dept Name field.';
                } */
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Posting Date field.';
                }
                field("Fixed Assets Code"; Rec."Fixed Assets Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Fixed Assets Code field.';
                }
                field("FA Identification No"; Rec."FA Identification No")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the FA Identification No field.';
                }
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the User ID field.';
                }
                field("Approver ID"; Rec."Approver ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Approver ID field.';
                }
                field("Approved Date Time"; Rec."Approved Date Time")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Approved Date Time field.';
                }
                field(Justification; Rec.Justification)
                {
                    ApplicationArea = All;
                    MultiLine = true;
                    ToolTip = 'Specifies the value of the Justification field.';
                }
                field("Sent for Authorization"; Rec."Sent for Authorization")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Sent for Authorization field.';
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Status field.';
                }
                field(Comments; Rec.Comments)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Comments field.';
                }
                // field("Total Amount"; Rec."Total Amount")
                // {
                //     ApplicationArea = All;
                //     Editable = true;
                //     ToolTip = 'Specifies the value of the Total Amount field.';
                // }
                // field("Purchase Order"; Rec."Purchase Order")
                // {
                //     ApplicationArea = All;
                //     ToolTip = 'Specifies the value of the Purchase Order field.';
                // }
            }
            part("Posted Pur Requisition Line"; "Posted Pur Req Line Sub Form")
            {
                Caption = 'Posted Pur Requisition Line';
                Editable = false;
                SubPageLink = "Document No." = field("Document No.");
                SubPageView = sorting("Document Type", "Document No.", "Line No.");
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        area(creation)
        {
            action("Posted Pur. Requisition")
            {
                ApplicationArea = All;
                Caption = 'Posted Pur. Requisition';
                Image = Print;
                Promoted = true;
                PromotedCategory = "Report";
                ToolTip = 'Executes the Posted Pur. Requisition action.';
                // trigger OnAction()
                // begin
                //     PRQHeader := Rec;
                //     PRQHeader.SetRecfilter();
                //     Report.RunModal(Report::"Posted Purchase Requisition", true, false, PRQHeader);
                // end;
            }
        }
    }

    var
        PRQHeader: Record "Posted Pur Requisition Header";
}

