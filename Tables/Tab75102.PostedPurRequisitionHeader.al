/// <summary>
/// Table Posted Pur Requisition Header (ID 75102).
/// </summary>
table 75102 "Posted Pur Requisition Header"
{
    Caption = 'Posted Pur Requisition Header';
    DataCaptionFields = "Document Type", "Document No.";
    LookupPageID = "Posted Pur Req Header List";
    DataClassification = CustomerContent;
    fields
    {
        field(50001; "Document No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Document No.';
        }
        field(50002; "Document Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Document Date';
        }
        field(50003; "Shortcut Dimension 1 Code"; Code[10])
        {
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
            DataClassification = CustomerContent;
            Description = 'Global Dimension -1 (Branch)';
            TableRelation = "Dimension Value".Code where("Dimension Code" = const('DIM-BRN'));

        }
        field(50004; "Shortcut Dimension 2 Code"; Code[10])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            DataClassification = CustomerContent;
            Description = 'Global Dimension -2 (Unit)';
            TableRelation = "Dimension Value".Code where("Dimension Code" = const('DIM-UNIT'));

        }
        field(50005; "Location Code"; Code[10])
        {
            DataClassification = CustomerContent;
            TableRelation = Location.Code where("Use As In-Transit" = filter(false));
            Caption = 'Location Code';
        }
        field(50006; Authorized; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Authorized';
        }
        field(50007; "Sent for Authorization"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Sent for Authorization';
        }
        field(50008; Declined; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Declined';
        }
        field(50009; "Document Type"; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'Indent';
            OptionMembers = Indent;
            Caption = 'Document Type';
        }
        field(50010; "No. Series"; Code[10])
        {
            DataClassification = CustomerContent;
            Editable = false;
            TableRelation = "No. Series";
            Caption = 'No. Series';
        }
        field(50011; "Last Date Modified"; Date)
        {
            DataClassification = CustomerContent;
            Editable = false;
            Caption = 'Last Date Modified';
        }
        field(50012; "User ID"; Code[30])
        {
            DataClassification = CustomerContent;
            TableRelation = "User Setup"."User ID";
            Caption = 'User ID';
        }
        field(50013; "Requisition Type"; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'Raw Material,General,Fixed Assets,Maintenance';
            OptionMembers = "Raw Material",General,"Fixed Assets",Maintenance;
            Caption = 'Requisition Type';
        }
        field(50014; "Dept. Code"; Code[10])
        {
            DataClassification = CustomerContent;
            TableRelation = "Dimension Value".Code where("Dimension Code" = const('DIM-DEPT'));
            Caption = 'Dept. Code';
        }
        field(50015; Selected; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Selected';
        }
        field(50016; "Dept Name"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Dept Name';
        }
        field(50017; "Requirement Type"; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'Normal,Urgent';
            OptionMembers = Normal,Urgent;
            Caption = 'Requirement Type';
        }
        field(50018; Status; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'Open,Pending Approval,Released,Rejected,Delegated';
            OptionMembers = Open,"Pending Approval",Released,Rejected,Delegated;
            Caption = 'Status';
        }
        field(50019; "Modified By"; Code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Modified By';
        }
        field(50020; "Approver ID"; Code[30])
        {
            DataClassification = CustomerContent;
            TableRelation = "User Setup"."User ID";
            Caption = 'Approver ID';
        }
        field(50021; "Job Queue Status"; Option)
        {
            Caption = 'Job Queue Status';
            DataClassification = CustomerContent;
            Editable = false;
            OptionCaption = ' ,Scheduled for Posting,Error,Posting';
            OptionMembers = " ","Scheduled for Posting",Error,Posting;

            trigger OnLookup()
            var
                JobQueueEntry: Record "Job Queue Entry";
            begin
                if "Job Queue Status" = "job queue status"::" " then
                    exit;
                JobQueueEntry.ShowStatusMsg("Job Queue Entry ID");
            end;
        }
        field(50022; "Job Queue Entry ID"; Guid)
        {
            Caption = 'Job Queue Entry ID';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(50023; "Incoming Document Entry No."; Integer)
        {
            Caption = 'Incoming Document Entry No.';
            DataClassification = CustomerContent;
            TableRelation = "Incoming Document";
        }
        field(50042; "RFQ Sent"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'RFQ Sent';
        }
        field(50043; "RFQ Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'RFQ Date';
        }
        field(50080; "Dimension Set ID"; Integer)
        {
            Caption = 'Dimension Set ID';
            DataClassification = CustomerContent;
            Editable = false;
            TableRelation = "Dimension Set Entry";
        }
        field(50085; "Total Amount"; Decimal)
        {
            CalcFormula = sum("Posted Pur Requisition Line"."Total Amount" where("Document No." = field("Document No.")));
            FieldClass = FlowField;
            Caption = 'Total Amount';
        }
        field(50100; "Creation Date Time"; DateTime)
        {
            DataClassification = CustomerContent;
            Caption = 'Creation Date Time';
        }
        field(50101; "Posting Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Posting Date';
        }
        field(50102; "Approved Date Time"; DateTime)
        {
            DataClassification = CustomerContent;
            Caption = 'Approved Date Time';
        }
        field(50103; "Fixed Assets Code"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Fixed Asset"."No.";
            Caption = 'Fixed Assets Code';
        }
        field(50104; "FA Identification No"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'FA Identification No';
        }
        field(50105; Justification; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Justification';
        }
        field(50106; Comments; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Comments';
        }
        // field(50107; "Purchase Order"; Code[20])
        // {
        //     DataClassification = CustomerContent;
        //     TableRelation = "Purchase Header"."No." where("PR No" = field("Document No."));
        //     Caption = 'Purchase Order';
        // }
        field(60002; Posted; Boolean)
        {
            DataClassification = CustomerContent;
            Editable = false;
            Caption = 'Posted';
        }
        field(60003; "Manual Close"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Manual Close';
        }
        field(60004; "Sent By"; Code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Sent By';
        }
        field(60005; "Email Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Email Date';
        }
        field(60006; "Email Sent"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Email Sent';
        }
        field(60007; "Single Source"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Single Source';
        }
    }

    keys
    {
        key(Key1; "Document Type", "Document No.")
        {
            Clustered = true;
        }
        key(Key2; "Document Date")
        {
        }
        key(Key3; "Location Code")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        //TESTFIELD(Authorized,FALSE);
    end;

    trigger OnRename()
    begin
        "Last Date Modified" := Today;
        "Modified By" := copystr(UserId, 1, 50);
    end;
}

