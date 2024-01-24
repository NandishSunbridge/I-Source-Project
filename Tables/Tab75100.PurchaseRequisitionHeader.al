/// <summary>
/// Table Purchase Requisition Header (ID 75100).
/// </summary>
table 75100 "Purchase Requisition Header"
{
    Caption = 'Purchase Requisition Header';
    DataClassification = CustomerContent;
    LookupPageId = "Purchase Requisition Header";
    DrillDownPageId = "Purchase Requisition Header";
    fields
    {
        field(50001; "Document No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Document No.';
            trigger OnValidate()
            begin
                if "Document No." <> xRec."Document No." then begin
                    PurchasesPayablesSetup.Get();
                    NoSeriesManagement.TestManual(PurchasesPayablesSetup."Purchase Request Nos.");
                    "No. Series" := '';
                end;
            end;
        }
        field(50002; "Document Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Document Date';
        }
        field(50003; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
            DataClassification = CustomerContent;
            Description = 'Global Dimension -1 (Branch)';
            TableRelation = "Dimension Value".Code where("Dimension Code" = const('DIM-BRN'));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(1, "Shortcut Dimension 1 Code");
            end;
        }
        field(50004; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            DataClassification = CustomerContent;
            Description = 'Global Dimension -2 (Unit)';
            TableRelation = "Dimension Value".Code where("Dimension Code" = const('DIM-UNIT'));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(2, "Shortcut Dimension 2 Code");
            end;
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
        field(50010; "No. Series"; Code[20])
        {
            DataClassification = CustomerContent;
            Editable = true;
            TableRelation = "No. Series";
            Caption = 'No. Series';
        }
        field(50011; "Last Date Modified"; Date)
        {
            DataClassification = CustomerContent;
            Editable = false;
            Caption = 'Last Date Modified';
        }
        field(50012; "User ID"; Code[50])
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
            trigger OnValidate()
            begin
                if "Dept. Code" <> '' then
                    if DimensionValue.Get('DIM-DEPT', "Dept. Code") then
                        "Dept Name" := DimensionValue.Name;
            end;
        }
        field(50015; Selected; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Selected';
        }
        field(50016; "Dept Name"; Text[50])
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
        field(50020; "Approver ID"; Code[50])
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

            trigger OnValidate()
            var
                IncomingDocument: Record "Incoming Document";
            begin
                if "Incoming Document Entry No." = xRec."Incoming Document Entry No." then
                    exit;
                if "Incoming Document Entry No." = 0 then
                    IncomingDocument.RemoveReferenceToWorkingDocument(xRec."Incoming Document Entry No.")
                else
                    IncomingDocument.SetIndentDoc(Rec);
            end;
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

            trigger OnLookup()
            begin
                ShowDocDim();
            end;
        }
        field(50085; "Total Amount"; Decimal)
        {
            CalcFormula = sum("Purchase Requisition Line"."Total Amount" where("Document No." = field("Document No.")));
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
        field(50107; "Purchase Order"; Code[20])
        {
            DataClassification = CustomerContent;
            Editable = false;
            TableRelation = "Purchase Header"."No.";
            Caption = 'Purchase Order';
        }
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
        DeletePRLine("Document No.");
    end;

    trigger OnInsert()
    begin
        if "Document No." = '' then begin
            PurchasesPayablesSetup.Get();
            PurchasesPayablesSetup.TestField("Purchase Request Nos.");
            NoSeriesManagement.InitSeries(PurchasesPayablesSetup."Purchase Request Nos.", xRec."No. Series", 0D, "Document No.", "No. Series");
        end;
        "Document Type" := "document type"::Indent;
        "Document Date" := WorkDate();
        "User ID" := copystr(UserId, 1, 50);
        TestField(Authorized, false);
        TestField("Sent for Authorization", false);
    end;

    trigger OnModify()
    begin
        "Last Date Modified" := Today;
        "Modified By" := copystr(UserId, 1, 50);
    end;

    var
        DimensionValue: Record "Dimension Value";
        PurchaseRequisitionHeader: Record "Purchase Requisition Header";
        PurchasesPayablesSetup: Record "Purchases & Payables Setup";
        UserSetup: Record "User Setup";
        DimensionManagement: Codeunit DimensionManagement;
        NoSeriesManagement: Codeunit NoSeriesManagement;
        IsMailSent: Boolean;
        IsPRLineExists: Boolean;
        DocSentForApprovalTxt: label 'Document No. %1 Successfully Sent for Approval..!', Comment = '%1 Document No. ';
        SendForApprovalTxt: label 'Do you want to Send for Approval?';
        Text003_gTxt: label 'Do you want to Approve.?';
        Text006_gTxt: label 'Do you want to open this document.?';
        Text007_gTxt: label 'You are not authorized to approve this document.';



    procedure AssistEdit(): Boolean

    begin
        PurchaseRequisitionHeader.Copy(Rec);
        PurchasesPayablesSetup.Get();
        PurchasesPayablesSetup.TestField("Purchase Request Nos.");
        if NoSeriesManagement.SelectSeries(PurchasesPayablesSetup."Purchase Request Nos.", xRec."No. Series", PurchaseRequisitionHeader."No. Series") then begin
            NoSeriesManagement.SetSeries(PurchaseRequisitionHeader."Document No.");
            Rec := PurchaseRequisitionHeader;
            exit(true);
        end;
    end;



    procedure DeletePRLine(DocumentNo: Code[20])
    var
        PRQLine: Record "Purchase Requisition Line";
    begin
        PRQLine.Reset();
        PRQLine.SetCurrentkey(PRQLine."Document Type", PRQLine."Document No.");
        PRQLine.SetRange(PRQLine."Document Type", PRQLine."document type"::Indent);
        PRQLine.SetRange(PRQLine."Document No.", DocumentNo);
        if PRQLine.Find('-') then
            repeat
                PRQLine.Delete(true);
            until PRQLine.Next() = 0;
    end;



    procedure ShowDocDim()

    var
        OldDimSetID: Integer;
    begin
        OldDimSetID := "Dimension Set ID";
        "Dimension Set ID" :=
          DimensionManagement.EditDimensionSet(
#pragma warning disable AA0217
            "Dimension Set ID", StrSubstNo('%1 %2', "Document Type", "Document No."),
#pragma warning restore AA0217
            "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code");
        if OldDimSetID <> "Dimension Set ID" then begin
            Modify();
            if PRLinesExist("Document No.") then
                UpdateAllLineDim("Dimension Set ID", OldDimSetID);
        end;
    end;



    procedure PRLinesExist(InDocNo: Code[20]): Boolean

    var
        PurchaseRequisitionLine: Record "Purchase Requisition Line";
        TempCount: Integer;
    begin
        TempCount := 0;  //set Record Counter
        if InDocNo <> '' then begin
            PurchaseRequisitionLine.Reset();
            PurchaseRequisitionLine.SetRange("Document Type", PurchaseRequisitionLine."document type"::Indent);
            PurchaseRequisitionLine.SetRange("Document No.", InDocNo);
            PurchaseRequisitionLine.SetFilter(PurchaseRequisitionLine."Indent Quantity", '<>%1', 0);
            TempCount := PurchaseRequisitionLine.Count;
        end;
        //-------
        if TempCount = 0 then
            exit(false)  // No Indent Line
        else
            exit(true);
    end;

    local procedure UpdateAllLineDim(NewParentDimSetID: Integer; OldParentDimSetID: Integer)
    var

        PurchaseRequisitionLine: Record "Purchase Requisition Line";
        NewDimSetID: Integer;
    begin
        // Update all lines with changed dimensions.

        if NewParentDimSetID = OldParentDimSetID then
            exit;
        //
        PurchaseRequisitionLine.Reset();
        PurchaseRequisitionLine.SetRange("Document Type", "Document Type");
        PurchaseRequisitionLine.SetRange("Document No.", "Document No.");
        PurchaseRequisitionLine.LockTable();
        if PurchaseRequisitionLine.Find('-') then
            repeat
                NewDimSetID := DimensionManagement.GetDeltaDimSetID(PurchaseRequisitionLine."Dimension Set ID", NewParentDimSetID, OldParentDimSetID);
                if PurchaseRequisitionLine."Dimension Set ID" <> NewDimSetID then begin
                    PurchaseRequisitionLine."Dimension Set ID" := NewDimSetID;
                    DimensionManagement.UpdateGlobalDimFromDimSetID(
                      PurchaseRequisitionLine."Dimension Set ID", PurchaseRequisitionLine."Shortcut Dimension 1 Code", PurchaseRequisitionLine."Shortcut Dimension 2 Code");
                    PurchaseRequisitionLine.Modify();
                end;
            until PurchaseRequisitionLine.Next() = 0;
    end;



    procedure ValidateShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])

    var
        OldDimSetID: Integer;
    begin
        OldDimSetID := "Dimension Set ID";
        DimensionManagement.ValidateShortcutDimValues(FieldNumber, ShortcutDimCode, "Dimension Set ID");
        if "Document No." <> '' then
            Modify();
        //
        if OldDimSetID <> "Dimension Set ID" then begin
            Modify();
            if PRLinesExist("Document No.") then
                UpdateAllLineDim("Dimension Set ID", OldDimSetID);
        end;
    end;



    procedure Release()

    begin
        if Confirm(Text006_gTxt, false) then begin
            UserSetup.Get(UserId);
            if Status <> Status::Open then begin
                "Sent for Authorization" := false;
                Status := Status::Open;
                Modify();
                Message('Document no. %1 has successfully Open', "Document No.");
            end;
        end;
    end;



    procedure Reopen()

    begin
        if Confirm(Text006_gTxt, false) then begin
            UserSetup.Get(UserId);
            if Status in [Status::Released, Status::"Pending Approval"] then begin
                "Sent for Authorization" := false;
                Status := Status::Open;
                "Sent for Authorization" := false;
                "Approved Date Time" := CreateDatetime(0D, 0T);
                Modify();
                Message('Document no. %1 has successfully Open', "Document No.");
            end;
        end;
    end;



    procedure Approve(InDocNo: Code[20])

    var
        PurchaseRequisitionLine: Record "Purchase Requisition Line";
    begin
        if Confirm(Text003_gTxt, false) then
            if "Approver ID" <> UserId then
                Error(Text007_gTxt)
            else begin
                Authorized := true;
                "Approved Date Time" := CurrentDatetime;
                Status := Status::"Pending Approval";
                Modify();
            end;


        PurchaseRequisitionLine.Reset();
        PurchaseRequisitionLine.SetRange("Document No.", "Document No.");
        if PurchaseRequisitionLine.FindFirst() then
            repeat

            until PurchaseRequisitionLine.Next() = 0;

        if Status <> Status::"Pending Approval" then begin
            Status := Status::"Pending Approval";
            Message('Document No. %1 has successfully Approve and Released', "Document No.");
        end;
    end;



    procedure SendForApproval(InDocNo: Code[20])

    var
        PurchaseRequisitionLine: Record "Purchase Requisition Line";


        Email: Codeunit Email;
        EmailMessage: Codeunit "Email Message";
        Window: Dialog;
        LoopCounter: Integer;
#pragma warning disable AA0470
        Text0001Lbl: label 'Item No.                  ###################1###################';
#pragma warning restore AA0470

        Body: Text;
        // SMTP: Codeunit "SMTP Mail";

        Subject: Text;
        SenderAddress: Text[100];
        SenderName: Text[100];
        Recipient: Text[200];
    begin
        UserSetup.Get(UserId);
        IsPRLineExists := PRLinesExist(InDocNo);
        //
        if not IsPRLineExists then begin
            Message('Indent No %1 has No Lines....', "Document No.");
            exit;
        end;
        //--------------------------------------------------------
        if Confirm(SendForApprovalTxt, false) then begin
            UserSetup.TestField("Approver ID");
            Status := Status::"Pending Approval";
            "Sent for Authorization" := true;
            "Sent By" := CopyStr(UserId, 1, MaxStrLen("Sent By")); // SSD-01-02-23
            "Email Date" := Today;
            Message(DocSentForApprovalTxt, "Document No.");
            Modify();
        end;
        exit;
        //------------Get Sender Email Id------------------

#pragma warning disable AA0136
        UserSetup.SetRange(UserSetup."User ID", UserId);
#pragma warning restore AA0136
        if UserSetup.Find('-') then begin
            SenderAddress := UserSetup."E-Mail";
            SenderName := "User ID";
        end;
        //------------Get Approver Email-Id-------------------
        UserSetup.Reset();
        UserSetup.SetRange(UserSetup."User ID", "Approver ID");
        if UserSetup.Find('-') then
            Recipient := UserSetup."E-Mail";

        //-----------------------------------------------------
        LoopCounter := 0;

        Window.Open('Creating Email....\' + Text0001Lbl);
        Subject := '';
        Body := '';

        Subject := 'Indent for Approval ' + "Document No." + ' Requested By: ' + UserId;

        EmailMessage.Create(Recipient, Subject, '', true);
        // SMTP.CreateMessage(SenderName, SenderAddress, Recipient, Subject, '', true);

        EmailMessage.AppendToBody('Dear Sir, ');
        EmailMessage.AppendToBody('<br>');
        EmailMessage.AppendToBody('Please Approve Indent No. ' + "Document No.");
        EmailMessage.AppendToBody('<br><br>');
        EmailMessage.AppendToBody('Branch-' + "Shortcut Dimension 1 Code");
        EmailMessage.AppendToBody('<br>');
        EmailMessage.AppendToBody('<br>');
        EmailMessage.AppendToBody('<Table border="1">');
        EmailMessage.AppendToBody('<tr>');
        EmailMessage.AppendToBody('<th>Item Code</th>');
        EmailMessage.AppendToBody('<th>Item Description</th>');
        EmailMessage.AppendToBody('<th>Requested Quantity</th>');
        EmailMessage.AppendToBody('<th>Requested Date</th>');
        EmailMessage.AppendToBody('<th>Available Stock</th>');
        EmailMessage.AppendToBody('<th>Remarks</th>');
        EmailMessage.AppendToBody('</tr>');
        //
        LoopCounter += 1;
        PurchaseRequisitionLine.SetRange("Document No.", "Document No.");
        if PurchaseRequisitionLine.FindSet() then
            repeat
                if LoopCounter = 1 then begin
                    EmailMessage.AppendToBody('<tr>');
                    EmailMessage.AppendToBody('<td>' + PurchaseRequisitionLine."Document No." + '</td>');
                    EmailMessage.AppendToBody('<td>' + PurchaseRequisitionLine.Description + '</td>');
                    EmailMessage.AppendToBody('<td>' + Format(PurchaseRequisitionLine."Indent Quantity") + '</td>');
                    EmailMessage.AppendToBody('<td>' + Format("Posting Date") + '</td>');
                    EmailMessage.AppendToBody('<td>' + Format(PurchaseRequisitionLine."Stock in Hand") + '</td>');
                    EmailMessage.AppendToBody('<td>' + '</td>');
                    EmailMessage.AppendToBody('</tr>');
                end;
            until PurchaseRequisitionLine.Next() = 0;


        EmailMessage.AppendToBody('</table>');
        EmailMessage.AppendToBody('<br><br>');
        EmailMessage.AppendToBody('<br><br>');
        EmailMessage.AppendToBody('Thanks');
        EmailMessage.AppendToBody('<br>');
        EmailMessage.AppendToBody(SenderName);
        //SMTP.AddBCC(UserSetup."E-Mail");
        Sleep(50);

        Email.Send(EmailMessage, Enum::"Email Scenario"::Default);
        "Email Sent" := true;
        Modify();
        Message('E-Mail Sent Successfully');
    end;



    procedure MannuallySendForApproval(var PRHeader: Record "Purchase Requisition Header")

    var


    begin
        IsPRLineExists := PRHeader.PRLinesExist("Document No.");
        //
        if not IsPRLineExists then begin
            Message('There is NO Item in this Document No %1', "Document No.");
            exit;
        end else
            if PRHeader.Get(PRHeader."document type"::Indent, "Document No.") then begin
                PRHeader.CalcFields("Total Amount");  //
                if PRHeader.Status = PRHeader.Status::Open then begin
                    CreateRecordInApprovalEntry(PRHeader);
                    IsMailSent := CreateAndSendMail(PRHeader);
                    PRHeader.Status := PRHeader.Status::"Pending Approval";  //First Approval Status
                    PRHeader."Sent for Authorization" := true;
                    if IsMailSent then begin
                        PRHeader."Email Sent" := true;
                        PRHeader."Email Date" := WorkDate();
                        PRHeader."Sent By" := 'System';
                    end;
                    PRHeader.Modify();
                    Message('Document %1 sent successfully for Approval', PRHeader."Document No.");
                end;
            end;

    end;



    procedure MannuallySendForCancel(var IndentHeader: Record "Purchase Requisition Header")

    var
        ApprovalEntry: Record "Approval Entry";

    begin
        IsPRLineExists := PurchaseRequisitionHeader.PRLinesExist("Document No.");
        //
        if not IsPRLineExists then begin
            Message('There is Item Record in this Document No %1', "Document No.");
            exit;
        end else begin
            if PurchaseRequisitionHeader.Get(PurchaseRequisitionHeader."document type"::Indent, "Document No.") then begin
                PurchaseRequisitionHeader.CalcFields("Total Amount");  //
                ApprovalEntry.Reset();
                ApprovalEntry.SetRange("Document No.", "Document No.");
                if ApprovalEntry.FindFirst() then begin
                    ApprovalEntry.Status := ApprovalEntry.Status::Canceled;
                    ApprovalEntry.Modify();
                end;
            end;
            PurchaseRequisitionHeader."Sent for Authorization" := false;
            PurchaseRequisitionHeader.Status := PurchaseRequisitionHeader.Status::Rejected;
            PurchaseRequisitionHeader.Modify();
            Message('Document %1 Cancelled Successfully', PurchaseRequisitionHeader."Document No.");
        end;
    end;



    procedure CreateRecordInApprovalEntry(var PRHeader: Record "Purchase Requisition Header")
    var
        ApprovalEntry: Record "Approval Entry";
        LastEntryNo: Integer;
    begin
        if PRHeader."Document No." <> '' then begin
            ApprovalEntry.Reset();
            if ApprovalEntry.FindLast() then
                LastEntryNo := ApprovalEntry."Entry No." // Save Last Entry No
            else
                LastEntryNo := 0;

            //---------------------------------------------------------------
            ApprovalEntry.Init();
            ApprovalEntry."Entry No." := LastEntryNo + 1;
            ApprovalEntry."Document Type" := ApprovalEntry."document type"::Indent;
            ApprovalEntry."Document No." := PRHeader."Document No.";
            ApprovalEntry."Table ID" := Database::"Purchase Requisition Header";
            ApprovalEntry."Sequence No." := 1;  //
            ApprovalEntry."Approval Code" := 'SCCI-INDENT';
            //ApprovalEntry.Justification := PRHeader.Justification; //SSD-02-02-23
            ApprovalEntry."Sender ID" := PRHeader."User ID";
            ApprovalEntry."Approver ID" := PRHeader."Approver ID"; // First Approval ID
            ApprovalEntry.Status := ApprovalEntry.Status::Open;  //
            ApprovalEntry."Date-Time Sent for Approval" := CreateDatetime(Today, Time);
            ApprovalEntry."Last Date-Time Modified" := CreateDatetime(Today, Time);
            ApprovalEntry."Last Modified By User ID" := CopyStr(UserId, 1, MaxStrLen(ApprovalEntry."Last Modified By User ID")); //SSD-01-02-23
            ApprovalEntry."Approval Type" := ApprovalEntry."approval type"::Approver;
            ApprovalEntry."Limit Type" := ApprovalEntry."limit type"::"Approval Limits";
            ApprovalEntry.Amount := PRHeader."Total Amount";
            ApprovalEntry."Amount (LCY)" := PRHeader."Total Amount";
            //ApprovalEntry."Amount to Vendor" := PRHeader."Total Amount"; //SSD-02-02-23
            ApprovalEntry."Record ID to Approve" := ApprovalEntry.RecordId;
            ApprovalEntry."Approval Code" := ApprovalEntry."Approval Code";
            ApprovalEntry.Insert(true);
        end;
    end;



    procedure CreateAndSendMail(var PRQHeader: Record "Purchase Requisition Header"): Boolean

    var
        PurchaseRequisitionLine: Record "Purchase Requisition Line";
        Vendor: Record Vendor;
        Email: Codeunit Email;
        // SMTPMail: Codeunit "SMTP Mail";
        EmailMsz: Codeunit "Email Message";
        MailSent: Boolean;

    begin
        MailSent := false;
        if PRQHeader."Document No." <> '' then begin
            //SMTPMail.CreateMessage(SenderName,SenderAddress,Recipients,Subject,Body,HtmlFormatted);
            EmailMsz.Create('purchase@scci.co.in', 'Purchase Requisition', '', true);
            // SMTPMail.CreateMessage('Navision-ERP', 'aksharma@scci.co.in', 'purchase@scci.co.in', 'Purchase Requisition', '', true);
            //SMTPMail.AddCC('aksharma@scci.co.in');  // CC
            EmailMsz.AppendToBody('Dear Sir/Madam,');
            EmailMsz.AppendToBody('<br><br>');
            EmailMsz.AppendToBody('Please note that user ' + CopyStr(PRQHeader."User ID", 13, 20) + ' has sent PR No.-' + PRQHeader."Document No." + ' for approval');
            EmailMsz.AppendToBody('<br><br>');
            EmailMsz.AppendToBody('This for your information and necessary action.');
            EmailMsz.AppendToBody('<br><br>');
            EmailMsz.AppendToBody('<br><br>');
            EmailMsz.AppendToBody('Navision-ERP');
            EmailMsz.AppendToBody('<br><br>');
            EmailMsz.AppendToBody('<HR>');
            EmailMsz.AppendToBody('System generated mail. Do not reply..');
            //SMTPMail.AddAttachment(FileName,FileName);
            Email.Send(EmailMsz, Enum::"Email Scenario"::Default);
            MailSent := true;
        end;
        exit(MailSent);
    end;
}

