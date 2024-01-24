/// <summary>
/// Page Posted Pur Req Line Sub Form (ID 75105).
/// </summary>
page 75105 "Posted Pur Req Line Sub Form"
{
    Editable = false;
    PageType = ListPart;
    SourceTable = "Posted Pur Requisition Line";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Document No. field.';
                }
                field("Line No."; Rec."Line No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Line No. field.';
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Type field.';
                }
                field("Item No."; Rec."Item No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Item No. field.';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Description field.';
                }
                /* field("Part Description"; Rec."Part Description")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Part Description field.';
                }
                field("Approved Line"; Rec."Approved Line")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Approved Line field.';
                }
                field("Release PO"; Rec."Release PO")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Release PO field.';
                }
                field("HSN/SAC"; Rec."HSN/SAC")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the HSN/SAC field.';
                } */
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Unit of Measure Code field.';
                }
                field("Indent Quantity"; Rec."Indent Quantity")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Indent Quantity field.';
                }
                field("Required Date"; Rec."Required Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Required Date field.';
                }
                /* field("Monthly Consumption"; Rec."Monthly Consumption")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Monthly Consumption field.';
                }
                field("Last Quantity"; Rec."Last Quantity")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Last Quantity field.';
                }
                field("Last Rate"; Rec."Last Rate")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Last Rate field.';
                }
                field("Suppliers Code"; Rec."Suppliers Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Supplier''s Code field.';
                }
                field("Suppliers Name"; Rec."Suppliers Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Supplier''s Name field.';
                }
                field("Stock in Hand"; Rec."Stock in Hand")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Stock in Hand field.';
                }
                field("Document Type"; Rec."Document Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Document Type field.';
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
                } */
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Location Code field.';
                }
                field("Last Date Modified"; Rec."Last Date Modified")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Last Date Modified field.';
                }
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the User ID field.';
                }
                field("Requisition Type"; Rec."Requisition Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Requisition Type field.';
                }
                // field("Dept. Code"; Rec."Dept. Code")
                // {
                //     ApplicationArea = All;
                //     ToolTip = 'Specifies the value of the Dept. Code field.';
                // }
                /* field("Purchase Quantity"; Rec."Purchase Quantity")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Purchase Quantity field.';
                }
                field("Balance Quantity"; Rec."Balance Quantity")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Balance Quantity field.';
                }
                field("Last Pur Date"; Rec."Last Pur Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Last Pur Date field.';
                }
                field("Purchase Rate"; Rec."Purchase Rate")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Purchase Rate field.';
                } */
                // field("Purchase Order"; Rec."Purchase Order")
                // {
                //     ApplicationArea = All;
                //     ToolTip = 'Specifies the value of the Purchase Order field.';
                // }
                /* field("Purchase Order Line"; Rec."Purchase Order Line")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Purchase Order Line field.';
                }
                field("Total Amount"; Rec."Total Amount")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Total Amount field.';
                } */
            }
        }
    }

    actions
    {
    }
}

