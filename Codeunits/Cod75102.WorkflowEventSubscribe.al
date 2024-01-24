codeunit 75102 WorkflowEventSuscribe
{
    SingleInstance = true;
    //EventSubscriberInstance = Manual;
    trigger OnRun()
    begin

    end;

    [IntegrationEvent(false, false)]
    procedure OnSendPurchaseRequisitionForApproval(var PurchaseRequisitionHeader: Record "Purchase Requisition Header");
    begin

    end;

    [IntegrationEvent(false, false)]
    procedure OnCancelPurchaseRequisitionApprovalRequest(var PurchaseRequisitionHeader: Record "Purchase Requisition Header")
    begin
    end;

    procedure CheckPurchaseRequisitionApprovalsWorkflowEnabled(var PurchaseRequisitionHeader: Record "Purchase Requisition Header"): Boolean
    begin
        if not WorkflowManagement.CanExecuteWorkflow(PurchaseRequisitionHeader, RunWorkflowOnSendPurchaseRequisitionForApprovalCode()) then
            ERROR(NoWorkflowEnabledErr);

        exit(true);
    end;


    [EventSubscriber(ObjectType::Codeunit, 1535, 'OnSetStatusToPendingApproval', '', false, false)]

    procedure SetStatusToPendingApproval(var Variant: Variant; var IsHandled: Boolean);
    var
        PurchaseRequisitionHeader: Record "Purchase Requisition Header";
        RecRef: RecordRef;
    begin
        RecRef.GetTable(Variant);

        case RecRef.Number of
            DATABASE::"Purchase Requisition Header":
                begin
                    RecRef.SETTABLE(PurchaseRequisitionHeader);
                    PurchaseRequisitionHeader.Status := PurchaseRequisitionHeader.Status::"Pending Approval";
                    PurchaseRequisitionHeader.MODIFY();
                    Variant := PurchaseRequisitionHeader;
                    IsHandled := true;
                end;
        end
    end;

    procedure RunWorkflowOnSendPurchaseRequisitionForApprovalCode(): Code[128]
    begin
        exit(UPPERCASE('RunWorkflowOnSendPurchaseRequisitionForApproval'));
    end;

    procedure RunWorkflowOnCancelPurchaseRequisitionApprovalRequestCode(): Code[128]
    begin
        exit(UPPERCASE('RunWorkflowOnCancelPurchaseRequisitionApprovalRequest'));
    end;

    [EventSubscriber(ObjectType::Codeunit, 75102, 'OnSendPurchaseRequisitionForApproval', '', false, false)]
    procedure RunWorkflowOnSendPurchaseRequisitionForApproval(var PurchaseRequisitionHeader: Record "Purchase Requisition Header")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendPurchaseRequisitionForApprovalCode(), PurchaseRequisitionHeader);
    end;


    [EventSubscriber(ObjectType::Codeunit, 75102, 'OnCancelPurchaseRequisitionApprovalRequest', '', false, false)]
    procedure RunWorkflowOnCancelPurchaseRequisitionApprovalRequest(var PurchaseRequisitionHeader: Record "Purchase Requisition Header");
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelPurchaseRequisitionApprovalRequestCode(), PurchaseRequisitionHeader);
    end;

    [EventSubscriber(ObjectType::Codeunit, 1520, 'OnAddWorkflowEventsToLibrary', '', false, false)]
    procedure CreateEventsLibrary();
    begin
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnSendPurchaseRequisitionForApprovalCode(), DATABASE::"Purchase Requisition Header",
             PurchaseRequisitionSendForApprovalEventDescTxt, 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnCancelPurchaseRequisitionApprovalRequestCode(), DATABASE::"Purchase Requisition Header",
             PurchaseRequisitionApprovalRequestCancelEventDescTxt, 0, false);

    end;

    //WorkFlow Response Handing 1521
    [EventSubscriber(ObjectType::Codeunit, 1521, 'OnAddWorkflowResponsePredecessorsToLibrary', '', false, false)]
    local procedure AddResponsePredecessors(ResponseFunctionName: Code[128]);
    begin
        case ResponseFunctionName of
            WorkFlowResponseHanding.CreateApprovalRequestsCode():

                WorkFlowResponseHanding.AddResponsePredecessor(WorkFlowResponseHanding.CreateApprovalRequestsCode(), RunWorkflowOnSendPurchaseRequisitionForApprovalCode());


            WorkFlowResponseHanding.SendApprovalRequestForApprovalCode():

                WorkFlowResponseHanding.AddResponsePredecessor(WorkFlowResponseHanding.SendApprovalRequestForApprovalCode(), RunWorkflowOnSendPurchaseRequisitionForApprovalCode());

            WorkFlowResponseHanding.OpenDocumentCode():

                WorkFlowResponseHanding.AddResponsePredecessor(WorkFlowResponseHanding.OpenDocumentCode(), RunWorkflowOnCancelPurchaseRequisitionApprovalRequestCode());

            WorkFlowResponseHanding.CancelAllApprovalRequestsCode():

                WorkFlowResponseHanding.AddResponsePredecessor(WorkFlowResponseHanding.CancelAllApprovalRequestsCode(), RunWorkflowOnCancelPurchaseRequisitionApprovalRequestCode());

        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, 1521, 'OnBeforeReleaseDocument', '', false, false)]
    local procedure ReleaseDocument(var Variant: Variant);
    var
        PurchaseRequisitionHeader: Record "Purchase Requisition Header";
        PurchaseRequisitionHeader2: Record "Purchase Requisition Header";
        RecRef: RecordRef;
    begin
        RecRef.GetTable(Variant);
        case RecRef.Number of
            DATABASE::"Purchase Requisition Header":
                begin
                    RecRef.SETTABLE(PurchaseRequisitionHeader);
                    PurchaseRequisitionHeader := Variant;
                    PurchaseRequisitionHeader2.Get(PurchaseRequisitionHeader."Document Type", PurchaseRequisitionHeader."Document No.");
                    PurchaseRequisitionHeader2.Status := PurchaseRequisitionHeader.Status::Released;
                    PurchaseRequisitionHeader2."Approver Id" := copystr(UserId, 1, 50);
                    PurchaseRequisitionHeader2.MODIFY;
                end;

        end
    end;
    //
    [EventSubscriber(ObjectType::Codeunit, 1521, 'OnReleaseDocument', '', false, false)]
    procedure OnReleaseDocument(RecRef: RecordRef; var Handled: Boolean);
    begin
        case RecRef.Number of
            DATABASE::"Purchase Requisition Header":
                Handled := true;

        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, 1521, 'OnOpenDocument', '', false, false)]
    procedure OnOpenDocument(RecRef: RecordRef; var Handled: Boolean);
    var
        PurchaseRequisitionHeader: Record "Purchase Requisition Header";
        PurchaseRequisitionHeader2: Record "Purchase Requisition Header";

    begin
        case RecRef.Number of
            DATABASE::"Purchase Requisition Header":
                begin
                    RecRef.SETTABLE(PurchaseRequisitionHeader);
                    PurchaseRequisitionHeader2.Get(PurchaseRequisitionHeader."Document Type", PurchaseRequisitionHeader."Document No.");
                    PurchaseRequisitionHeader2.Status := PurchaseRequisitionHeader.Status::Open;
                    PurchaseRequisitionHeader2.MODIFY();
                    Handled := true;
                end;
        end
    end;

    [EventSubscriber(ObjectType::Codeunit, codeunit::"Approvals Mgmt.", 'OnPopulateApprovalEntryArgument', '', true, true)]
    procedure OnPopulateApprovalEntryArgument(var RecRef: RecordRef; var ApprovalEntryArgument: Record "Approval Entry"; WorkflowStepInstance: Record "Workflow Step Instance");
    var
        PurchaseRequisitionHeader: Record "Purchase Requisition Header";

    begin
        case RecRef.Number of
            DATABASE::"Purchase Requisition Header":
                begin
                    RecRef.SETTABLE(PurchaseRequisitionHeader);
                    ApprovalEntryArgument."Document No." := PurchaseRequisitionHeader."Document No.";
                end;

        end
    end;

    var
        WorkflowManagement: Codeunit "Workflow Management";
        WorkflowEventHandling: Codeunit "Workflow Event Handling";
        WorkFlowResponseHanding: Codeunit "Workflow Response Handling";
        NoWorkflowEnabledErr: Label 'No approvals workflow for this record type is enabled.';
        PurchaseRequisitionSendForApprovalEventDescTxt: Label 'Approval of a Purchase Requisition is requested.';
        PurchaseRequisitionApprovalRequestCancelEventDescTxt: Label 'An approval request for a Purchase Requisition is canceled.';
}
