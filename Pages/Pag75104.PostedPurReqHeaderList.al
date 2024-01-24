/// <summary>
/// Page Posted Pur Req Header List (ID 75104).
/// </summary>
page 75104 "Posted Pur Req Header List"
{
    ApplicationArea = All;
    CardPageID = "Posted Pur Req Header";
    Editable = false;
    PageType = List;
    SourceTable = "Posted Pur Requisition Header";
    SourceTableView = sorting("Document Type", "Document No.");
    UsageCategory = History;

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
                field("Document Date"; Rec."Document Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Document Date field.';
                }
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
    }
}

