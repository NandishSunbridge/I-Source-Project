/// <summary>
/// Page Purchase Requisition Sub Form (ID 75101).
/// </summary>
page 75101 "Purchase Requisition Sub Form"
{
    AutoSplitKey = true;
    Caption = 'Purchase Requisition Sub Form';
    DelayedInsert = true;
    PageType = ListPart;
    SourceTable = "Purchase Requisition Line";

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                field("Line No."; Rec."Line No.")
                {
                    ApplicationArea = All;
                    Editable = FPLineNo;
                    ToolTip = 'Specifies the value of the Line No. field.';
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                    Editable = FPType;
                    ToolTip = 'Specifies the value of the Type field.';
                }
                field("Item No."; Rec."Item No.")
                {
                    ApplicationArea = All;
                    Editable = FPItemNo;
                    ShowMandatory = FieldsMandatory;
                    Style = Strong;
                    StyleExpr = true;
                    ToolTip = 'Specifies the value of the Item No. field.';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    Editable = FPHsn;
                    ToolTip = 'Specifies the value of the Description field.';
                }
                /* field("Part Description"; Rec."Part Description")
                {
                    ApplicationArea = All;
                    Editable = FPPartDesc;
                    ToolTip = 'Specifies the value of the Part Description field.';
                }
                field("Approved Line"; Rec."Approved Line")
                {
                    ApplicationArea = All;
                    //Editable = FPApprovedLine; Check Sunil
                    ToolTip = 'Specifies the value of the Approved Line field.';
                }
                field("Release PO"; Rec."Release PO")
                {
                    ApplicationArea = All;
                    Editable = FPReleasePO;
                    ToolTip = 'Specifies the value of the Release PO field.';
                } */
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                    ApplicationArea = All;
                    Editable = FPUOM;
                    ShowMandatory = FieldsMandatory;
                    Style = Strong;
                    StyleExpr = true;
                    ToolTip = 'Specifies the value of the Unit of Measure Code field.';
                }
                /* field("HSN/SAC"; Rec."HSN/SAC")
                {
                    ApplicationArea = All;
                    Editable = FPHsn;
                    ShowMandatory = FieldsMandatory;
                    Style = Strong;
                    StyleExpr = true;
                    ToolTip = 'Specifies the value of the HSN/SAC field.';
                }
                field(GPPG; Rec.GPPG)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the GPPG field.';
                }
                field("FA Identification"; Rec."FA Identification")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the FA Identification field.';
                }
                field("Monthly Consumption"; Rec."Monthly Consumption")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Monthly Consumption field.';
                }
                field("Safety Stock"; Rec."Safety Stock")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Safety Stock field.';
                }
                field("Safety Lead Time"; Rec."Safety Lead Time")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Safety Lead Time field.';
                }
                field("Stock in Hand"; Rec."Stock in Hand")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Stock in Hand field.';
                }
                field("Stock Sufficient Days"; Rec."Stock Sufficient Days")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Stock Sufficient Days field.';
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
                field("Last Purchase Doc"; Rec."Last Purchase Doc")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Last Purchase Doc field.';
                }*/
                field("Required Date"; Rec."Required Date")
                {
                    ApplicationArea = All;
                    Editable = FPRequiredDate;
                    ShowMandatory = FieldsMandatory;
                    Style = Strong;
                    StyleExpr = true;
                    ToolTip = 'Specifies the value of the Required Date field.';
                }
                field("Indent Quantity"; Rec."Indent Quantity")
                {
                    ApplicationArea = All;
                    Editable = FPIndentQty;
                    ShowMandatory = FieldsMandatory;
                    Style = Strong;
                    StyleExpr = true;
                    ToolTip = 'Specifies the value of the Indent Quantity field.';
                }
                /* field("Balance Quantity"; Rec."Balance Quantity")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Balance Quantity field.';
                }
                field("Purchase Quantity"; Rec."Purchase Quantity")
                {
                    ApplicationArea = All;
                    Editable = true;
                    ShowMandatory = FieldsMandatory;
                    Style = Strong;
                    StyleExpr = true;
                    ToolTip = 'Specifies the value of the Purchase Quantity field.';
                }
                field("Purchase Rate"; Rec."Purchase Rate")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Purchase Rate field.';
                }
                field("Total Amount"; Rec."Total Amount")
                {
                    ApplicationArea = All;
                    Editable = FPTotalAmt;
                    ToolTip = 'Specifies the value of the Total Amount field.';
                }
                field(Q1; Rec.Q1)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Q1 field.';
                }
                field(Q2; Rec.Q2)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Q2 field.';
                }
                field(Q3; Rec.Q3)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Q3 field.';
                }
                field("Suppliers Code"; Rec."Suppliers Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Suppliers Code field.';
                }
                field("Suppliers Name"; Rec."Suppliers Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Supplier''s Name field.';
                } */
                // field("Dept. Code"; Rec."Dept. Code")
                // {
                //     ApplicationArea = All;
                //     Editable = false;
                //     ToolTip = 'Specifies the value of the Dept. Code field.';
                // }
                /* field("Purchase Order"; Rec."Purchase Order")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Purchase Order field.';
                }
                field("Purchase Order Line"; Rec."Purchase Order Line")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Purchase Order Line field.';
                }
                field("Purchase Order Date"; Rec."Purchase Order Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Purchase Order Date field.';
                } */
            }
        }
    }

    actions
    {
        area(processing)
        {
            group("&Line")
            {
                Caption = '&Line';
                Image = "Action";

            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        PRQHeader.Get(Rec."Document Type", Rec."Document No.");
        if PRQHeader.Status = PRQHeader.Status::Released then
            FieldsDisable();

    end;

    trigger OnOpenPage()
    begin
        FieldsMandatory := true;
        FieldsEnable();
    end;

    var
        PRQHeader: Record "Purchase Requisition Header";
        FieldsMandatory: Boolean;
        FPItemNo: Boolean;
        //FPDesc: Boolean;
        FPPartDesc: Boolean;
        FPApprovedLine: Boolean;
        FPReleasePO: Boolean;
        FPUOM: Boolean;
        FPHsn: Boolean;
        FPRequiredDate: Boolean;
        FPIndentQty: Boolean;
        FPTotalAmt: Boolean;
        FPLineNo: Boolean;
        FPType: Boolean;


    procedure FieldsEnable()
    begin
        FPLineNo := false;
        FPType := true;
        FPApprovedLine := true;
        //FPDesc := true;
        FPHsn := true;
        FPIndentQty := true;
        FPItemNo := true;
        FPPartDesc := true;
        FPReleasePO := true;
        FPRequiredDate := true;
        FPTotalAmt := true;
        FPUOM := true;
    end;


    procedure FieldsDisable()
    begin
        FPLineNo := false;
        FPType := false;
        FPApprovedLine := false;
        //FPDesc := false;
        FPHsn := false;
        FPIndentQty := false;
        FPItemNo := false;
        FPPartDesc := false;
        FPReleasePO := true;
        FPRequiredDate := true;
        FPTotalAmt := false;
        FPUOM := false;
    end;
}

