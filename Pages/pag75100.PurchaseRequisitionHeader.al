/// <summary>
/// Page Purchase Requisition Header (ID 75100).
/// </summary>
page 75100 "Purchase Requisition Header"
{
    Caption = 'Purchase Requisition Header';
    Editable = true;
    PageType = Card;
    SourceTable = "Purchase Requisition Header";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Document No. field.';
                    trigger OnAssistEdit()
                    begin
                        if Rec.AssistEdit() then
                            CurrPage.Update();
                    end;
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
                    trigger OnValidate()
                    begin
                        if Rec."Requisition Type" = Rec."requisition type"::"Fixed Assets" then
                            CtrlEditable := true
                        else begin
                            Rec."Fixed Assets Code" := '';
                            Rec."FA Identification No" := '';
                            CtrlEditable := false;
                        end;
                    end;
                }
                field("Single Source"; Rec."Single Source")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Single Source field.';
                }
                field("Requirement Type"; Rec."Requirement Type")
                {
                    ApplicationArea = All;
                    Style = Unfavorable;
                    StyleExpr = true;
                    ToolTip = 'Specifies the value of the Requirement Type field.';
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = All;
                    ShowMandatory = FieldsMandatory;
                    Style = Strong;
                    StyleExpr = true;
                    ToolTip = 'Specifies the value of the Shortcut Dimension 1 Code field.';
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = All;
                    ShowMandatory = FieldsMandatory;
                    Style = Strong;
                    StyleExpr = true;
                    ToolTip = 'Specifies the value of the Shortcut Dimension 2 Code field.';
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                    ShowMandatory = FieldsMandatory;
                    Style = Strong;
                    StyleExpr = true;
                    ToolTip = 'Specifies the value of the Location Code field.';
                }
                /* field("Dept. Code"; Rec."Dept. Code")
                {
                    ApplicationArea = All;
                    ShowMandatory = FieldsMandatory;
                    Style = Strong;
                    StyleExpr = true;
                    ToolTip = 'Specifies the value of the Dept. Code field.';
                }
                field("Dept Name"; Rec."Dept Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Dept Name field.';
                } */
                field("Fixed Assets Code"; Rec."Fixed Assets Code")
                {
                    ApplicationArea = All;
                    Editable = CtrlEditable;
                    ToolTip = 'Specifies the value of the Fixed Assets Code field.';
                }
                field("FA Identification No"; Rec."FA Identification No")
                {
                    ApplicationArea = All;
                    Editable = CtrlEditable;
                    ToolTip = 'Specifies the value of the FA Identification No field.';
                }
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = All;
                    Caption = 'Indented By';
                    ToolTip = 'Specifies the value of the Indented By field.';
                }
                field("Approver ID"; Rec."Approver ID")
                {
                    ApplicationArea = All;
                    ShowMandatory = FieldsMandatory;
                    Style = Strong;
                    StyleExpr = true;
                    ToolTip = 'Specifies the value of the Approver ID field.';
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Status field.';
                }
                field("Sent for Authorization"; Rec."Sent for Authorization")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Sent for Authorization field.';
                }
                field("Approved Date Time"; Rec."Approved Date Time")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Approved Date Time field.';
                }
                field(Justification; Rec.Justification)
                {
                    ApplicationArea = All;
                    MultiLine = true;
                    ShowMandatory = FieldsMandatory;
                    Style = Strong;
                    StyleExpr = true;
                    ToolTip = 'Specifies the value of the Justification field.';
                }
                field(Comments; Rec.Comments)
                {
                    ApplicationArea = All;
                    MultiLine = true;
                    ToolTip = 'Specifies the value of the Comments field.';
                }
                field("RFQ Sent"; Rec."RFQ Sent")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the RFQ Sent field.';
                }
                field("RFQ Date"; Rec."RFQ Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the RFQ Date field.';
                }
                // field("Total Amount"; Rec."Total Amount")
                // {
                //     ApplicationArea = All;
                //     Editable = false;
                //     ToolTip = 'Specifies the value of the Total Amount field.';
                // }
            }
            part("Purchase Requisition Lines"; "Purchase Requisition Sub Form")
            {
                SubPageLink = "Document No." = field("Document No.");
                SubPageView = sorting("Document No.", "Line No.");
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        area(processing)
        {
            group("Function ")
            {
                // group(Approval)
                // {
                //     Caption = 'Approval';
                //     action(Approve)
                //     {
                //         ApplicationArea = All;
                //         Caption = 'Approve';
                //         Image = Approve;
                //         Promoted = true;
                //         PromotedCategory = Category4;
                //         PromotedIsBig = true;
                //         PromotedOnly = true;
                //         ToolTip = 'Approve the requested changes.';
                //         Visible = OpenApprovalEntriesExistCurrUser;

                //         trigger OnAction()
                //         var
                //             ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                //         begin
                //             ApprovalsMgmt.ApproveRecordApprovalRequest(Rec.RecordId);

                //         end;
                //     }
                //     action(Reject)
                //     {
                //         ApplicationArea = All;
                //         Caption = 'Reject';
                //         Image = Reject;
                //         Promoted = true;
                //         PromotedCategory = Category4;
                //         PromotedIsBig = true;
                //         PromotedOnly = true;
                //         ToolTip = 'Reject the approval request.';
                //         Visible = OpenApprovalEntriesExistCurrUser;

                //         trigger OnAction()
                //         var
                //             ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                //         begin
                //             ApprovalsMgmt.RejectRecordApprovalRequest(Rec.RecordId);

                //         end;
                //     }
                //     action(Delegate)
                //     {
                //         ApplicationArea = All;
                //         Caption = 'Delegate';
                //         Image = Delegate;
                //         Promoted = true;
                //         PromotedCategory = Category4;
                //         PromotedOnly = true;
                //         ToolTip = 'Delegate the approval to a substitute approver.';
                //         Visible = OpenApprovalEntriesExistCurrUser;

                //         trigger OnAction()
                //         var
                //             ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                //         begin
                //             ApprovalsMgmt.DelegateRecordApprovalRequest(Rec.RecordId);
                //         end;
                //     }
                //     action(Comment)
                //     {
                //         ApplicationArea = All;
                //         Caption = 'Comments';
                //         Image = ViewComments;
                //         Promoted = true;
                //         PromotedCategory = Category4;
                //         PromotedOnly = true;
                //         ToolTip = 'View or add comments for the record.';
                //         Visible = OpenApprovalEntriesExistCurrUser;

                //         trigger OnAction()
                //         var
                //             ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                //         begin
                //             ApprovalsMgmt.GetApprovalComment(Rec);
                //         end;
                //     }
                // }
                // //
                // group("Request Approval")
                // {
                //     Caption = 'Request Approval';
                //     Image = SendApprovalRequest;
                //     action(SendApprovalRequest)
                //     {
                //         ApplicationArea = Basic, Suite;
                //         Caption = 'Send A&pproval Request';
                //         Enabled = not OpenApprovalEntriesExist;
                //         Image = SendApprovalRequest;
                //         Promoted = true;
                //         PromotedCategory = Category5;
                //         PromotedIsBig = true;
                //         ToolTip = 'Request approval to change the record.';

                //         trigger OnAction()
                //         var

                //             WorkflowEvent: Codeunit WFCode;
                //         begin
                //             if WorkflowEvent.CheckPurchaseRequisitionApprovalsWorkflowEnabled(Rec) then
                //                 WorkflowEvent.OnSendPurchaseRequisitionForApproval(Rec);



                //         end;
                //     }
                //     action(CancelApprovalRequest)
                //     {
                //         ApplicationArea = Basic, Suite;
                //         Caption = 'Cancel Approval Re&quest';
                //         Enabled = OpenApprovalEntriesExist;
                //         Image = CancelApprovalRequest;
                //         Promoted = true;
                //         PromotedCategory = Category5;
                //         ToolTip = 'Cancel the approval request.';

                //         trigger OnAction()
                //         var

                //             WorkflowEvent: Codeunit WorkflowEventSuscribe;
                //         begin
                //             WorkflowEvent.OnCancelPurchaseRequisitionApprovalRequest(Rec);

                //         end;
                //     }
                //     action(ApprovalEntries)
                //     {
                //         AccessByPermission = TableData "Approval Entry" = RM;
                //         ApplicationArea = Basic, Suite;
                //         Caption = 'Approvals';
                //         Image = Approvals;
                //         Promoted = true;
                //         PromotedCategory = Category5;
                //         ToolTip = 'View a list of the records that are waiting to be approved. For example, you can see who requested the record to be approved, when it was sent, and when it is due to be approved.';

                //         trigger OnAction()
                //         begin
                //             ApprovalsMgmt.OpenApprovalEntriesPage(Rec.RecordId);
                //         end;
                //     }

                // }

                //SSD_shab
                group(Approval)
                {
                    Caption = 'Approval';

                    action(Approve)
                    {
                        ApplicationArea = All;
                        Caption = 'Approve';
                        Image = Approve;
                        Promoted = true;
                        PromotedCategory = Category4;

                        PromotedIsBig = true;
                        PromotedOnly = true;
                        ToolTip = 'Approve the requested changes.';
                        Visible = OpenApprovalEntriesExistCurrUser;

                        trigger OnAction()
                        var
                            ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                        begin
                            ApprovalsMgmt.ApproveRecordApprovalRequest(Rec.RecordId);
                        end;
                    }
                    action(Reject)
                    {
                        ApplicationArea = All;
                        Caption = 'Reject';
                        Image = Reject;
                        Promoted = true;
                        PromotedCategory = Category4;
                        PromotedIsBig = true;
                        PromotedOnly = true;
                        ToolTip = 'Reject the approval request.';
                        Visible = OpenApprovalEntriesExistCurrUser;

                        trigger OnAction()
                        var
                            ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                        begin
                            ApprovalsMgmt.RejectRecordApprovalRequest(Rec.RecordId);
                        end;
                    }
                    action(Delegate)
                    {
                        ApplicationArea = All;
                        Caption = 'Delegate';
                        Image = Delegate;
                        Promoted = true;
                        PromotedCategory = Category4;
                        PromotedOnly = true;
                        ToolTip = 'Delegate the approval to a substitute approver.';
                        Visible = OpenApprovalEntriesExistCurrUser;

                        trigger OnAction()
                        var
                            ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                        begin
                            ApprovalsMgmt.DelegateRecordApprovalRequest(Rec.RecordId);
                        end;
                    }
                    action(Comment)
                    {
                        ApplicationArea = All;
                        Caption = 'Comments';
                        Image = ViewComments;
                        Promoted = true;
                        PromotedCategory = Category4;
                        PromotedOnly = true;
                        ToolTip = 'View or add comments for the record.';
                        Visible = OpenApprovalEntriesExistCurrUser;

                        trigger OnAction()
                        var
                            ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                        begin
                            ApprovalsMgmt.GetApprovalComment(Rec);
                        end;
                    }
                }
                group("Request Approval")
                {
                    Caption = 'Request Approval';
                    Image = SendApprovalRequest;
                    action(SendApprovalRequest)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Send A&pproval Request';
                        //Enabled = NOT OpenApprovalEntriesExist AND CanRequestApprovalForFlow;
                        //Enabled = NOT OpenApprovalEntriesExist;
                        Image = SendApprovalRequest;
                        Promoted = true;
                        //PromotedCategory = Category5;
                        PromotedIsBig = true;
                        //  ToolTip = 'Request approval to change the record.';

                        trigger OnAction()
                        var

                            WorkflowEvent: Codeunit WorkflowEventSuscribe;
                        begin
                            // if not (Rec.IndentLineExist) then
                            //     Error('Indent Line does not exist for indent no %1', Rec."No.");
                            // CheckIndent;

                            if WorkflowEvent.CheckPurchaseRequisitionApprovalsWorkflowEnabled(Rec) then begin
                                WorkflowEvent.OnSendPurchaseRequisitionForApproval(Rec);
                                //if WorkflowEvent.CheckWorkflowEnabled then
                                //WorkflowEvent.OnSendIndentDocumentforApproval(Rec);
                                // Clear(SSDEmailManagement);
                                // SSDEmailManagement.IndentSendForApproval(Rec);
                                // end;
                            end;
                        end;
                    }
                    action(CancelApprovalRequest)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Cancel Approval Re&quest';
                        //Enabled = CanCancelApprovalForRecord OR CanCancelApprovalForFlow;
                        //Enabled = OpenApprovalEntriesExist;
                        Image = CancelApprovalRequest;
                        Promoted = true;
                        //PromotedCategory = Category5;
                        ToolTip = 'Cancel the approval request.';

                        trigger OnAction()
                        var

                            WorkflowEvent: Codeunit WorkflowEventSuscribe;
                        begin
                            WorkflowEvent.OnCancelPurchaseRequisitionApprovalRequest(Rec);

                        end;
                    }
                    action(ApprovalEntries)
                    {
                        AccessByPermission = TableData "Approval Entry" = R;
                        ApplicationArea = Basic, Suite;
                        Caption = 'Approvals';
                        Image = Approvals;
                        Promoted = true;
                        //PromotedCategory = Category5;
                        ToolTip = 'View a list of the records that are waiting to be approved. For example, you can see who requested the record to be approved, when it was sent, and when it is due to be approved.';

                        trigger OnAction()
                        begin
                            ApprovalsMgmt.OpenApprovalEntriesPage(Rec.RecordId);
                        end;
                    }
                }
                //shab

                action(Reopen)
                {
                    ApplicationArea = All;
                    Image = ReOpen;
                    Promoted = true;
                    PromotedIsBig = true;
                    Visible = true;
                    ToolTip = 'Executes the Reopen action.';
                    trigger OnAction()
                    begin
                        //UserSetup.GET(USERID);
                        Rec.Reopen();
                    end;
                }
            }
            group(Posting)
            {
                action("Print Indent")
                {
                    ApplicationArea = All;
                    Caption = 'Print &Indent';
                    Image = Print;
                    Promoted = true;
                    PromotedCategory = "Report";
                    ToolTip = 'Executes the Print &Indent action.';
                    trigger OnAction()
                    begin
                        PRQHeader := Rec;
                        PRQHeader.SetRecfilter();
                        Report.RunModal(Report::"Purchase Requisition", true, false, PRQHeader);
                    end;
                }
                action(Dimensions)
                {
                    ApplicationArea = All;
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    ShortCutKey = 'Shift+Ctrl+D';
                    ToolTip = 'Executes the Dimensions action.';
                    trigger OnAction()
                    begin
                        Rec.ShowDocDim();
                        CurrPage.SaveRecord();
                    end;
                }

                // action("Send Approval Request")
                // {
                //     ApplicationArea = All;
                //     Caption = 'Send Approval Request';
                //     Enabled = CtrlSAP;
                //     Image = SendApprovalRequest;
                //     Promoted = true;
                //     PromotedCategory = Category9;
                //     ToolTip = 'Executes the Send Approval Request action.';
                //     trigger OnAction()
                //     var
                //     // ApprovalEntry: Record "Approval Entry";
                //     // IndentHeader: Record "Purchase Requisition Header";
                //     // ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                //     // RecRef: RecordRef;
                //     // LastEntryNo: Integer;
                //     begin
                //         IsOkayForApproval := CheckFieldsBeforeSendingForApproval(Rec);
                //         if not IsOkayForApproval then
                //             exit;

                //         //--------------------------------------------------------------------
                //         if Rec."Document No." <> '' then
                //             if Rec.Status in [Rec.Status::Open, Rec.Status::Rejected] then
                //                 Rec.MannuallySendForApproval(Rec)
                //             else begin
                //                 Message('Indent No. %1 Either Approved or Pending..', Rec."Document No.");
                //                 exit;
                //             end;

                //     end;
                // }
                // action(CancelApprovalRequest)
                // {
                //     ApplicationArea = All;
                //     Caption = 'Cancel Approval Re&quest';
                //     Enabled = CtrlCAP;
                //     Image = Cancel;
                //     Promoted = true;
                //     PromotedCategory = Category9;
                //     ToolTip = 'Executes the Cancel Approval Re&quest action.';
                //     trigger OnAction()
                //     var
                //     //ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                //     begin
                //         Rec.MannuallySendForCancel(Rec);  // Cancel Process
                //     end;
                // }
            }
            group(Transfer)
            {
                action("Create Purchase Order")
                {
                    ApplicationArea = All;
                    Caption = 'Create Purchase Order';
                    Image = CreateDocument;
                    Promoted = true;
                    PromotedCategory = Process;
                    ToolTip = 'Executes the Create Purchase Order action.';
                    trigger OnAction()
                    var
                        // PPRQHeader: Record "Posted Pur Requisition Header";
                        // PPRQLine: Record "Posted Pur Requisition Line";
                        PRQline: Record "Purchase Requisition Line";
                    begin

                        IsOkayForPurchaseOrder := CheckFieldsBeforeSendingForApproval(Rec);  // Check Data

                        //----------------------------------------------------------
                        if Rec.Status = Rec.Status::Released then begin
                            PRQHeader := Rec;
                            PRQHeader.SetRecfilter();
                            //-----------Check Release PO-------------------------------
                            PRQline.Reset();
                            PRQline.SetRange("Document No.", PRQHeader."Document No.");
                            PRQline.SetFilter("Purchase Order", '=%1', '');
                            PRQline.SetFilter("Suppliers Code", '<>%1', '');
                            PRQline.SetRange("Release PO", true); // Items for Release
                            if (PRQline.Count) = 0 then begin
                                Message('There is No Items for Releasing PO.....');
                                exit;
                            end else begin
                                POcreated := CreatePurchaseOrder(PRQHeader);
                                if POcreated then begin
                                    Message('Purchase Order Created Successfully.....');
                                    //---------Transfer PR to Posted PR----------------------
                                    PRQline.Reset();
                                    PRQline.SetRange("Document No.", PRQHeader."Document No.");
                                    PRQline.SetRange("Release PO", false); // Items for Release
                                    if (PRQline.Count) = 0 then
                                        TransferDataToPostedTables(PRQHeader);

                                end;
                            end;
                        end else begin
                            Message('Purchase Order Can Only Be Created After Approval....');
                            exit;
                        end;
                    end;
                }
                action("Send RFQ")
                {
                    ApplicationArea = All;
                    Caption = 'Send RFQ';
                    Ellipsis = true;
                    Image = SendMail;
                    Promoted = true;
                    PromotedCategory = Process;
                    ToolTip = 'Executes the Send RFQ action.';
                    trigger OnAction()
                    begin
                        Message('Ready for Sending Mail..');
                        exit;
                    end;
                }

                action("Copy PR to RFQ")
                {
                    ApplicationArea = All;
                    Caption = 'Copy PR to RFQ';
                    Image = Copy;
                    Promoted = true;
                    PromotedCategory = Process;
                    trigger OnAction()

                    var
                        Ok: Boolean;
                        PRH: Record "Purchase Requisition Header";
                        PRL: Record "Purchase Requisition Line";
                        PRRFQH: Record "PR RFQ Header";
                        PRRFQL: Record "PR RFQ Line";
                        NoSeriesMgt: Codeunit NoSeriesManagement;
                        PRRFQNo: Code[20];
                        PurchaseandPaySetupRec: Record "Purchases & Payables Setup";
                        Cnt: Integer;

                    begin
                        Ok := Confirm('Are you sure want to copy', true, false);
                        if not ok then begin
                            exit;
                        end;
                        if Rec.Status <> Rec.Status::Released then begin
                            Error('Purchase Requisition Status not Released..');
                        end;
                        PRRFQH.TransferFields(Rec);
                        PurchaseandPaySetupRec.Get();
                        PurchaseandPaySetupRec.TestField("PR RFQ No.");
                        PRRFQNo := NoSeriesMgt.GetNextNo(PurchaseandPaySetupRec."PR RFQ No.", 0D, true);
                        PRRFQH."Document No." := PRRFQNo;
                        PRRFQH."PR No." := Rec."Document No.";
                        if (PRRFQH.Insert(true) = true) then begin
                            PRL.Reset();
                            PRL.SetRange("Document No.", Rec."Document No.");
                            PRL.SetRange("Document Type", Rec."Document Type");
                            Cnt := 0;
                            if PRL.FindFirst() then begin
                                repeat
                                    PRRFQL.TransferFields(PRL);
                                    PRRFQL."Document No." := PRRFQNo;
                                    PRRFQL.Insert(true);
                                    Cnt += 1;
                                until PRL.Next() = 0;
                            end;
                        end;
                        Message('RFQ Created with total line No. %1', Cnt);
                        exit;
                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        SetControlAppearance();
        // OpenApprovalEntriesExistCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(Rec.RecordId);
        // OpenApprovalEntriesExist := ApprovalsMgmt.HasApprovalEntries(Rec.RecordId);
        // CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(Rec.RecordId());
        // WorkflowWebhookMgt.GetCanRequestAndCanCancel(Rec.RecordId(), CanRequestApprovalForFlow, CanCancelApprovalForFlow);
    end;

    trigger OnOpenPage()
    begin
        SetControlAppearance();
        CtrlEditable := false;  //Opening Time
        FieldsMandatory := true;
    end;

    var
        //ApprovalEntry: Record "Approval Entry";
        WorkflowWebhookMgt: Codeunit "Workflow Webhook Management";
        OpenApprovalEntriesExistCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        CanCancelApprovalForRecord: Boolean;
        CanRequestApprovalForFlow: Boolean;
        CanCancelApprovalForFlow: Boolean;
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        PRQHeader: Record "Purchase Requisition Header";
        TempPRQLine: Record "Purchase Requisition Line" temporary;
        //User: Record User;
        //UserSetup: Record "User Setup";
        CtrlCAP: Boolean;
        CtrlEditable: Boolean;
        CtrlSAP: Boolean;
        FieldsMandatory: Boolean;
        //HasIncomingDocument: Boolean;
        IsOkayForApproval: Boolean;
        IsOkayForPurchaseOrder: Boolean;
        // IsPRQLineExists: Boolean;
        // [InDataSet]
        // JobQueueVisible: Boolean;
        // OpenApprovalEntriesExist: Boolean;
        // OpenApprovalEntriesExistForCurrUser: Boolean;
        POcreated: Boolean;

    local procedure SetExtDocNoMandatoryCondition()
    var
        PurchasesPayablesSetup: Record "Purchases & Payables Setup";
    begin
        PurchasesPayablesSetup.Get();
    end;

    trigger OnAfterGetCurrRecord()
    begin
        // OpenApprovalEntriesExistCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(Rec.RecordId);
        // OpenApprovalEntriesExist := ApprovalsMgmt.HasApprovalEntries(Rec.RecordId);
        OpenApprovalEntriesExistCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(Rec.RecordId);
        OpenApprovalEntriesExist := ApprovalsMgmt.HasApprovalEntries(Rec.RecordId);
        // CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(Rec.RecordId());
        // WorkflowWebhookMgt.GetCanRequestAndCanCancel(Rec.RecordId(), CanRequestApprovalForFlow, CanCancelApprovalForFlow);
    end;

    procedure SetControlAppearance()
    begin
        SetExtDocNoMandatoryCondition();
        if Rec.Status in [Rec.Status::Open, Rec.Status::Released] then begin
            CtrlSAP := true;
            CtrlCAP := false;
        end else begin
            CtrlSAP := false;
            CtrlCAP := true;
            ;
        end;
    end;


#pragma warning disable AA0072
    procedure CreatePurchaseOrder(var PRQHeader: Record "Purchase Requisition Header"): Boolean
#pragma warning restore AA0072
    var
        POHeader: Record "Purchase Header";
        POLine: Record "Purchase Line";
        PRQLine: Record "Purchase Requisition Line";
        PurchaseSetup: Record "Purchases & Payables Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        NewOrderNo: Code[20];
        POSeries: Code[20];
    begin
        PurchaseSetup.Get();
        POSeries := PurchaseSetup."Order Nos.";  // Take Main purchase series - BHD
        //------------------------------------------------------------------
        PRQLine.Reset();
        PRQLine.SetRange("Document No.", PRQHeader."Document No.");
        PRQLine.SetFilter("Purchase Order", '=%1', '');
        PRQLine.SetFilter("Suppliers Code", '<>%1', '');
        PRQLine.SetRange("Release PO", true);
        if (PRQLine.Count) = 0 then begin
            Message('No Items for PO...');
            exit;
        end;
        //------------------------------------------------------------------
        MakeTempPRQLine(PRQHeader);              // For knowing how many vendors
        //-------------------------------------------------------------
        if PRQHeader."Location Code" = 'LC-BHD' then
            POSeries := CopyStr(POSeries, 1, 7) + 'BHD';

        if PRQHeader."Location Code" = 'LC-GGN' then
            POSeries := CopyStr(POSeries, 1, 7) + 'GGN';

        //--------------Start Creating PO------------------------------------------------------
        TempPRQLine.Reset();
        TempPRQLine.SetFilter("Suppliers Code", '<>%1', '');
        if TempPRQLine.FindSet() then begin
            repeat
                //------------------------------------------------------------
                NewOrderNo := NoSeriesMgt.GetNextNo(POSeries, WorkDate(), true);
                //----------------------------------------------------------
                POHeader."Document Type" := POHeader."document type"::Order;
                if not POHeader.Get(Rec."Document Type", NewOrderNo) then begin
                    POHeader.Init();
                    POHeader."Document Type" := POHeader."document type"::Order;
                    POHeader."No." := NewOrderNo;
                    POHeader."Posting Date" := WorkDate();
                    POHeader.Validate("Buy-from Vendor No.", TempPRQLine."Suppliers Code");
                    POHeader."Vendor Order No." := NewOrderNo;
                    POHeader."Document Date" := WorkDate();
                    POHeader."Order Date" := WorkDate();
                    POHeader.Validate("Location Code", PRQHeader."Location Code");
                    //POHeader.Validate(Structure, 'PUR-GST-00'); amit check
                    POHeader."Shortcut Dimension 1 Code" := PRQHeader."Shortcut Dimension 1 Code";
                    POHeader."Shortcut Dimension 2 Code" := PRQHeader."Shortcut Dimension 2 Code";
                    // POHeader.Justification := PRQHeader.Justification;
                    // POHeader."PR No" := PRQHeader."Document No.";
                    // POHeader."PR Status" := POHeader."pr status"::Complete;
                    // POHeader."Prepared By" := UserId;
                    // POHeader."Checked By" := UserId;
                    // POHeader."Approval Authority" := PRQHeader."Approver ID";
                    POHeader.Insert();
                    //-----------------------------------------------------------------------------
                    PRQLine.SetRange("Document No.", TempPRQLine."Document No.");
                    PRQLine.SetRange("Suppliers Code", TempPRQLine."Suppliers Code");
                    PRQLine.SetFilter("Purchase Order", '=%1', '');
                    PRQLine.SetRange("Approved Line", true);  // Only Approved Lines
                    PRQLine.SetRange("Release PO", true); //Selected Items
                    if PRQLine.FindSet() then
                        repeat
                            POLine.Init();
                            POLine."Document Type" := POLine."document type"::Order;
                            POLine."Document No." := NewOrderNo;
                            POLine."Line No." := PRQLine."Line No.";
                            POLine.Type := PRQLine.Type;
                            POLine.Validate("No.", PRQLine."Item No.");
                            POLine.Description := PRQLine.Description;
                            POLine."Description 2" := PRQLine."Part Description";
                            POLine.Validate("Location Code", PRQHeader."Location Code");
                            POLine.Validate("Unit of Measure Code", PRQLine."Unit of Measure Code");
                            POLine.Validate(Quantity, PRQLine."Purchase Quantity");
                            POLine.Validate("Direct Unit Cost", PRQLine."Purchase Rate");
                            POLine.Validate("Shortcut Dimension 1 Code", PRQHeader."Shortcut Dimension 1 Code");
                            POLine.Validate("Shortcut Dimension 2 Code", PRQHeader."Shortcut Dimension 2 Code");
                            //    POLine."Posting Date" := WorkDate();
                            POLine.Insert();
                            //--------------------------------------------------------------
                            PRQLine."Purchase Order" := NewOrderNo;
                            PRQLine."Purchase Order Line" := POLine."Line No.";
                            //    PRQLine."Purchase Order Date" := POLine."Posting Date";
                            PRQLine.Modify();
                        //--------------------------------------------------------------
                        until PRQLine.Next() = 0;

                end;
            until TempPRQLine.Next() = 0;
            exit(true);   // PO Created.....
        end;
    end;


    procedure MakeTempPRQLine(var PRQHeader: Record "Purchase Requisition Header")
    var
        PRQLine: Record "Purchase Requisition Line";
        LineNo: Integer;
    begin
        TempPRQLine.DeleteAll();
        LineNo := 1000;
        //--------------------------
        PRQLine.Reset();
        PRQLine.SetRange("Document No.", PRQHeader."Document No.");
        PRQLine.SetRange("Approved Line", true);
        PRQLine.SetRange("Release PO", true);
        if PRQLine.FindSet() then
            repeat
                TempPRQLine.Reset();
                TempPRQLine.SetRange("Document No.", PRQLine."Document No.");
                TempPRQLine.SetRange("Suppliers Code", PRQLine."Suppliers Code");
                if TempPRQLine.FindFirst() then begin
                    //no
                end else begin
                    TempPRQLine.Init();
                    TempPRQLine."Document Type" := PRQLine."Document Type";
                    TempPRQLine."Document No." := PRQLine."Document No.";
                    TempPRQLine."Line No." := LineNo;
                    TempPRQLine."Suppliers Code" := PRQLine."Suppliers Code";
                    TempPRQLine.Insert();
                    LineNo += 1000;
                end;
            until PRQLine.Next() = 0;
    end;


    procedure TransferDataToPostedTables(var PRQHeader: Record "Purchase Requisition Header")
    var
        PPRQHeader: Record "Posted Pur Requisition Header";
        PPRQLine: Record "Posted Pur Requisition Line";
        PRQLine: Record "Purchase Requisition Line";
        CurrDocumentNo: Code[20];
    begin
        CurrDocumentNo := PRQHeader."Document No."; // Save Document No
        if not PPRQHeader.Get(PRQHeader."Document Type", PRQHeader."Document No.") then begin
            PPRQHeader.Init();
            PPRQHeader.TransferFields(PRQHeader);
            PPRQHeader.Insert();
            //--------------------------------------------------
            PRQLine.SetRange("Document No.", PRQHeader."Document No.");
            if PRQLine.FindSet() then
                repeat
                    PPRQHeader.Init();
                    PPRQLine.TransferFields(PRQLine);
                    PPRQLine.Insert();
                until PRQLine.Next() = 0;

        end;
        //--------------------------------------
        PRQHeader.Reset();
        PRQHeader.SetRange("Document No.", CurrDocumentNo);
        PRQHeader.DeleteAll();
        //------------------
        PRQLine.Reset();
        PRQLine.SetRange("Document No.", CurrDocumentNo);
        PRQLine.DeleteAll();
        //--------------------------------------
    end;

    local procedure CheckFieldsBeforeSendingForApproval(var Rec: Record "Purchase Requisition Header"): Boolean
    var
        PRQH: Record "Purchase Requisition Header";
        PRQL: Record "Purchase Requisition Line";
        ErrCnt: Integer;
    begin
        ErrCnt := 0;  // Initilize
        if Rec."Document No." <> '' then begin
            PRQH.Reset();
            PRQH.SetRange("Document No.", Rec."Document No.");
            if PRQH.FindFirst() then begin
                /*
                if PRQH."Dept. Code" = '' then begin
                    Message('Dept Code...Cannot be blank...');
                    ErrCnt := ErrCnt + 1;
                end;
                if PRQH."Approver ID" = '' then begin
                    Message('Approver Id...Cannot be blank...');
                    ErrCnt := ErrCnt + 1;
                end;
                if PRQH."Location Code" = '' then begin
                    Message('Location Code...Cannot be blank...');
                    ErrCnt := ErrCnt + 1;
                end;
                if PRQH."Shortcut Dimension 1 Code" = '' then begin
                    Message('Branch Code...Cannot be blank...');
                    ErrCnt := ErrCnt + 1;
                end;
                if PRQH."Shortcut Dimension 2 Code" = '' then begin
                    Message('Unit Code...Cannot be blank...');
                    ErrCnt := ErrCnt + 1;
                end;
                */
            end;
            //-----------------Check Lines--------------------------------
            PRQL.Reset();
            PRQL.SetRange("Document No.", PRQH."Document No.");
            if PRQL.FindSet() then
                repeat
                    if PRQL."Item No." = '' then begin
                        Message('Item No Field cannot be Blank...?');
                        ErrCnt := ErrCnt + 1;
                    end;
                    if PRQL."Unit of Measure Code" = '' then begin
                        Message('UOM Field cannot be Blank...?');
                        ErrCnt := ErrCnt + 1;
                    end;
                    if PRQL."Indent Quantity" = 0 then begin
                        Message('Indent Quantity Cannot be 0...?');
                        ErrCnt := ErrCnt + 1;
                    end;
                    if PRQL."Purchase Quantity" = 0 then begin
                        Message('Purchase Quantity cannot be 0');
                        ErrCnt := ErrCnt + 1;
                    end;
                    if PRQL."Required Date" = 0D then begin
                        Message('Required Date Cannot be Blank..');
                        ErrCnt := ErrCnt + 1;
                    end;
                    if PRQL."Purchase Rate" = 0 then begin
                        Message('Please Enter Tentative Purchase Rate.....');
                        ErrCnt := ErrCnt + 1;
                    end;
                until PRQL.Next() = 0;

        end;
        //-------------------------------------------------------------------------------------
        if ErrCnt = 0 then
            exit(true)
        else
            exit(false);

    end;


    local procedure CheckFieldsBeforeCreatingPurchaseOrder(var Rec: Record "Purchase Requisition Header"): Boolean

    var
        PRQH: Record "Purchase Requisition Header";
        PRQL: Record "Purchase Requisition Line";
        ErrCnt: Integer;
    begin
        ErrCnt := 0;  //Initilize
        if Rec."Document No." <> '' then begin
            PRQH.Reset();
            PRQH.SetRange("Document No.", Rec."Document No.");
            if PRQH.FindFirst() then
                if PRQH.Status <> PRQH.Status::Released then begin
                    Message('Document status is not Released....');
                    ErrCnt := ErrCnt + 1;
                end;

            //--------------------------------------------------------
            PRQL.Reset();
            PRQL.SetRange("Document No.", Rec."Document No.");
            if PRQL.FindSet() then
                repeat
                    if not PRQL."Release PO" then begin
                        Message('Item NOT selected for PO...');
                        ErrCnt := ErrCnt + 1;
                    end;
                    if PRQL."HSN/SAC" = '' then begin
                        Message('HSN Code... Cannot Be ZERO.....');
                        ErrCnt := ErrCnt + 1;
                    end;
                    if PRQL."Purchase Quantity" = 0 then begin
                        Message('Purhase Quantity Cannot Be ZERO.....');
                        ErrCnt := ErrCnt + 1;
                    end;
                    if PRQL."Suppliers Code" = '' then begin
                        Message('Supplier Code Cannot be Blank....');
                        ErrCnt := ErrCnt + 1;
                    end;
                until PRQL.Next() = 0;

        end;
        //-------------------------------------------------------------------------------------
        if ErrCnt = 0 then
            exit(true)
        else
            exit(false);

    end;
}

