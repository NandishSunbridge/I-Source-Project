/// <summary>
/// Table Posted Pur Requisition Line (ID 75103).
/// </summary>
table 75103 "Posted Pur Requisition Line"
{
    DrillDownPageID = "Posted Pur Req Line Sub Form";
    LookupPageID = "Posted Pur Req Line Sub Form";
    DataClassification = CustomerContent;
    fields
    {
        field(50001; "Document No."; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Posted Pur Requisition Header"."Document No.";
            Caption = 'Document No.';
        }
        field(50002; "Line No."; Integer)
        {
            AutoIncrement = true;
            DataClassification = CustomerContent;
            Caption = 'Line No.';
        }
        field(50003; Type; Option)
        {
            Caption = 'Type';
            DataClassification = CustomerContent;
            OptionCaption = ' ,G/L Account,Item,,Fixed Asset,Charge (Item)';
            OptionMembers = " ","G/L Account",Item,,"Fixed Asset","Charge (Item)";
        }
        field(50004; "Item No."; Code[30])
        {
            DataClassification = CustomerContent;
            TableRelation = if (Type = const(" ")) "Standard Text"
            else
            if (Type = const("G/L Account")) "G/L Account"
            else
            if (Type = const(Item)) Item
            else
            if (Type = const("Fixed Asset")) "Fixed Asset"
            else
            if (Type = const("Charge (Item)")) "Item Charge";
            Caption = 'Item No.';
        }
        field(50005; Description; Text[80])
        {
            DataClassification = CustomerContent;
            Editable = true;
            Caption = 'Description';
        }
        field(50006; "Unit of Measure Code"; Code[10])
        {
            DataClassification = CustomerContent;
            Editable = true;
            TableRelation = "Unit of Measure";
            Caption = 'Unit of Measure Code';
        }
        field(50007; "Indent Quantity"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Indent Quantity';
        }
        field(50008; "Required Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Required Date';
        }
        field(50009; "Monthly Consumption"; Decimal)
        {
            DataClassification = CustomerContent;
            Editable = false;
            Caption = 'Monthly Consumption';
        }
        field(50010; "Last Quantity"; Decimal)
        {
            DataClassification = CustomerContent;
            Editable = false;
            Caption = 'Last Quantity';
        }
        field(50011; "Last Rate"; Decimal)
        {
            DataClassification = CustomerContent;
            Editable = false;
            Caption = 'Last Rate';
        }
        field(50012; "Suppliers Code"; Code[10])
        {
            Caption = 'Supplier''s Code';
            DataClassification = CustomerContent;
            Editable = true;
            TableRelation = Vendor."No.";
        }
        field(50013; "Suppliers Name"; Text[60])
        {
            Caption = 'Supplier''s Name';
            DataClassification = CustomerContent;
            Editable = true;
        }
        field(50014; "Stock in Hand"; Decimal)
        {
            DataClassification = CustomerContent;
            Editable = false;
            Caption = 'Stock in Hand';
        }
        field(50015; "Document Type"; Option)
        {
            DataClassification = CustomerContent;
            Editable = true;
            OptionCaption = 'Indent';
            OptionMembers = Indent;
            Caption = 'Document Type';
        }
        field(50016; "Shortcut Dimension 1 Code"; Code[10])
        {
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
            DataClassification = CustomerContent;
            Description = 'Global Dimension -1 (Branch)';
            Editable = true;
            TableRelation = "Dimension Value".Code where("Dimension Code" = const('DIM-BRN'));

            trigger OnValidate()
            begin
                //ValidateShortcutDimCode(1,"Shortcut Dimension 1 Code");
            end;
        }
        field(50017; "Shortcut Dimension 2 Code"; Code[10])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            DataClassification = CustomerContent;
            Description = 'Global Dimension -2 (Unit)';
            Editable = true;
            TableRelation = "Dimension Value".Code where("Dimension Code" = const('DIM-UNIT'));

            trigger OnValidate()
            begin
                //ValidateShortcutDimCode(2,"Shortcut Dimension 2 Code");
            end;
        }
        field(50018; "Location Code"; Code[10])
        {
            DataClassification = CustomerContent;
            Editable = true;
            TableRelation = Location.Code where("Use As In-Transit" = filter(false));
            Caption = 'Location Code';
        }
        field(50019; "Last Date Modified"; Date)
        {
            DataClassification = CustomerContent;
            Editable = false;
            Caption = 'Last Date Modified';
        }
        field(50020; "User ID"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "User Setup"."User ID";
            Caption = 'User ID';
        }
        field(50021; "Requisition Type"; Option)
        {
            DataClassification = CustomerContent;
            Editable = false;
            OptionCaption = 'Raw Material,General,Fixed Assets';
            OptionMembers = "Raw Material",General,"Fixed Assets";
            Caption = 'Requisition Type';
        }
        field(50022; "Dept. Code"; Code[10])
        {
            DataClassification = CustomerContent;
            Editable = true;
            TableRelation = "Dimension Value".Code where("Dimension Code" = const('DIM-DEPT'));
            Caption = 'Dept. Code';
        }
        field(50023; "Purchase Quantity"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Purchase Quantity';
            trigger OnValidate()
            begin
                if "Purchase Quantity" <> 0 then begin
                    "Total Amount" := ROUND("Purchase Quantity" * "Purchase Rate", 1.0);
                    "Balance Quantity" := "Indent Quantity" - "Purchase Quantity";
                end;
            end;
        }
        field(50024; "Balance Quantity"; Decimal)
        {
            DataClassification = CustomerContent;
            Editable = false;
            Caption = 'Balance Quantity';
        }
        field(50025; "Last Pur Date"; Date)
        {
            DataClassification = CustomerContent;
            Editable = true;
            Caption = 'Last Pur Date';
        }
        field(50026; "Total Amount"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Total Amount';
        }
        // field(50027; "Purchase Order"; Code[20])
        // {
        //     DataClassification = CustomerContent;
        //     TableRelation = "Purchase Header"."No." where("PR No" = field("Document No."));
        //     Caption = 'Purchase Order';
        // }
        field(50028; "Purchase Order Line"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Purchase Order Line';
        }
        field(50029; "Purchase Rate"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Purchase Rate';
        }
        field(50030; "Safety Lead Time"; DateFormula)
        {
            DataClassification = CustomerContent;
            Caption = 'Safety Lead Time';
        }
        field(50031; "Approved Line"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Approved Line';
        }
        field(50032; "Safety Stock"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Safety Stock';
        }
        field(50033; "Inventory Sufficient"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Inventory Sufficient';
        }
        field(50034; "Requirement Type"; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'Normal,Urgent';
            OptionMembers = Normal,Urgent;
            Caption = 'Requirement Type';
        }
        field(50035; "HSN/SAC"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'HSN/SAC';
        }
        field(50036; GPPG; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'GPPG';
        }
        field(50037; "FA Identification"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'FA Identification';
        }
        field(50038; "Part Description"; Text[80])
        {
            DataClassification = CustomerContent;
            Caption = 'Part Description';
        }
        field(50039; "Release PO"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Release PO';
        }
        field(50040; "Last Purchase Doc"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Last Purchase Doc';
        }
        field(50041; "Purchase Order Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Purchase Order Date';
        }
        field(50080; "Dimension Set ID"; Integer)
        {
            Caption = 'Dimension Set ID';
            DataClassification = CustomerContent;
            Editable = false;
            TableRelation = "Dimension Set Entry";
        }
        field(50081; Q1; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Q1';
        }
        field(50082; Q2; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Q2';
        }
        field(50083; Q3; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Q3';
        }
    }

    keys
    {
        key(Key1; "Document Type", "Document No.", "Line No.")
        {
            Clustered = true;
            SumIndexFields = "Total Amount";
        }
        key(Key2; "Stock in Hand", "Document No.")
        {
        }
    }

    fieldgroups
    {
    }

}
