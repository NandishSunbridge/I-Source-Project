page 75114 "PR RFQ List"
{
    ApplicationArea = All;
    Caption = 'PR RFQ List';
    CardPageID = "PR RFQ Header";
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "PR RFQ Header";
    UsageCategory = Documents;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Document Type"; Rec."Document Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Document Type field.';
                }
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Document No. field.';
                }
                field("PR No."; Rec."PR No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the PR No. field.';
                }
                field("Document Date"; Rec."Document Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Document Date field.';
                }
                // field("Single Source"; Rec."Single Source")
                // {
                //     ApplicationArea = All;
                //     ToolTip = 'Specifies the value of the Single Source field.';
                // }
                field("Requisition Type"; Rec."Requisition Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Requisition Type field.';
                }
                field("Requirement Type"; Rec."Requirement Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Requirement Type field.';
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Location Code field.';
                }
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the User ID field.';
                }
                // field("Dept Name"; Rec."Dept Name")
                // {
                //     ApplicationArea = All;
                //     ToolTip = 'Specifies the value of the Dept Name field.';
                // }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Status field.';
                }
                field("Sent for Authorization"; Rec."Sent for Authorization")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Sent for Authorization field.';
                }
                field(Authorized; Rec.Authorized)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Authorized field.';
                }
                // field(Declined; Rec.Declined)
                // {
                //     ApplicationArea = All;
                //     ToolTip = 'Specifies the value of the Declined field.';
                // }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Create From Excel")
            {
                ApplicationArea = All;
                Caption = 'Create From Excel';
                Image = Excel;
                Promoted = true;
                PromotedCategory = Process;
                ToolTip = 'Executes the Create From Excel action.';
                trigger OnAction()
                begin
                    Message('I am here....');
                    exit;
                end;
            }
        }
    }
}
