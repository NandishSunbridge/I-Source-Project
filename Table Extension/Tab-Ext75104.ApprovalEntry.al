/// <summary>
/// TableExtension tableextension50067 (ID 75104) extends Record Approval Entry.
/// </summary>
tableextension 75104 "Approval Entry Ext" extends "Approval Entry"
{

    fields
    {
        field(50001; "Amount to Vendor"; Decimal)
        {
            CalcFormula = sum("Purchase Line"."Amount" where("Document No." = field("Document No.")));
            FieldClass = FlowField;
            Caption = 'Amount to Vendor';
        }
        field(50002; Approve; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Approve';
        }
        field(50003; "Total Indent Amount"; Decimal)
        {
            CalcFormula = sum("Purchase Requisition Line"."Total Amount" where("Document No." = field("Document No.")));
            FieldClass = FlowField;
            Caption = 'Total Indent Amount';
        }
        field(50004; Justification; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Justification';
        }
    }



    /// <summary>
    /// ManuallyApproveIndent.
    /// </summary>
    /// <param name="ApprovalEntry">VAR Record "Approval Entry".</param>
    var
    //PurchaseRequisitionLine: Record "Purchase Requisition Line";

    // procedure ManuallyApproveIndent(var ApprovalEntry: Record "Approval Entry")
    // var
    //     PRQHeader: Record "Purchase Requisition Header";
    //     PRQLine: Record "Purchase Requisition Line";
    //     PostedApproval: Record "Posted Approval Entry";
    // begin
    //     if Rec."Document Type" = Rec."document type"::Indent then begin
    //         Rec.Status := Rec.Status::Approved;
    //         Rec.Modify();
    //         //------------------------------------------------------------
    //         PRQHeader.SetRange("Document Type", PRQHeader."document type"::Indent);
    //         PRQHeader.SetRange("Document No.", Rec."Document No.");
    //         if PRQHeader.FindFirst() then begin
    //             PRQHeader.Status := PRQHeader.Status::Released;  //Finally Release
    //             PRQHeader."Approved Date Time" := CreateDatetime(Today, Time);
    //             PRQHeader.Authorized := true;
    //             PRQHeader.Modify();
    //             //----------------------------
    //             PRQLine.Reset();
    //             PRQLine.SetRange("Document No.", PRQHeader."Document No.");
    //             if PRQLine.FindSet() then
    //                 repeat
    //                     if not PRQLine."Approved Line" then begin
    //                         PRQLine."Approved Line" := true;
    //                         PRQLine.Modify();
    //                     end;
    //                 until PRQLine.Next() = 0;

    //             //----------------------------
    //         end;
    //         //----------Transfer Data to Posted Files------------------------------
    //         PostedApproval.Reset();
    //         if not PostedApproval.Get(Rec."Entry No.") then begin
    //             PostedApproval.Init();
    //             PostedApproval."Entry No." := Rec."Entry No.";
    //             PostedApproval."Table ID" := Rec."Table ID";
    //             PostedApproval."Document No." := Rec."Document No.";
    //             PostedApproval."Sequence No." := Rec."Sequence No.";
    //             PostedApproval."Approval Code" := Rec."Approval Code";
    //             PostedApproval."Sender ID" := Rec."Sender ID";
    //             PostedApproval."Salespers./Purch. Code" := Rec."Salespers./Purch. Code";
    //             PostedApproval."Approver ID" := Rec."Approver ID";
    //             PostedApproval.Status := Rec.Status;
    //             PostedApproval."Date-Time Sent for Approval" := Rec."Date-Time Sent for Approval";
    //             PostedApproval."Last Date-Time Modified" := Rec."Last Date-Time Modified";
    //             PostedApproval."Last Modified By ID" := Rec."Last Modified By User ID";
    //             PostedApproval.Comment := Rec.Comment;
    //             PostedApproval."Due Date" := Rec."Due Date";
    //             PostedApproval.Amount := Rec.Amount;
    //             PostedApproval."Amount (LCY)" := Rec."Amount (LCY)";
    //             PostedApproval."Currency Code" := Rec."Currency Code";
    //             PostedApproval."Approval Type" := Rec."Approval Type";
    //             PostedApproval."Limit Type" := Rec."Limit Type";
    //             PostedApproval."Available Credit Limit (LCY)" := Rec."Available Credit Limit (LCY)";
    //             PostedApproval.Insert();
    //         end;
    //     end;
    // end;

    // /// <summary>
    // /// ManuallyRejectIndent.
    // /// </summary>
    // /// <param name="ApprovalEntry">VAR Record "Approval Entry".</param>
    // procedure ManuallyRejectIndent(var ApprovalEntry: Record "Approval Entry")
    // var
    //     PRQHeader: Record "Purchase Requisition Header";
    //     PostedApproval: Record "Posted Approval Entry";
    // begin
    //     if Rec."Document Type" = Rec."document type"::Indent then begin
    //         Rec.Status := Rec.Status::Rejected;
    //         Rec.Modify();
    //         //------------------------------------------------------------
    //         PRQHeader.SetRange("Document Type", PRQHeader."document type"::Indent);
    //         PRQHeader.SetRange("Document No.", Rec."Document No.");
    //         if PRQHeader.FindFirst() then begin
    //             PRQHeader.Status := PRQHeader.Status::Rejected;  //Finally Rejected
    //             PRQHeader."Approved Date Time" := CreateDatetime(Today, Time);
    //             PRQHeader.Authorized := false;
    //             PRQHeader.Declined := true;
    //             PRQHeader.Modify();
    //         end;
    //         //----------Transfer Data to Posted Files------------------------------
    //         PostedApproval.Reset();
    //         if not PostedApproval.Get(Rec."Entry No.") then begin
    //             PostedApproval.Init();
    //             PostedApproval."Entry No." := Rec."Entry No.";
    //             PostedApproval."Table ID" := Rec."Table ID";
    //             PostedApproval."Document No." := Rec."Document No.";
    //             PostedApproval."Sequence No." := Rec."Sequence No.";
    //             PostedApproval."Approval Code" := Rec."Approval Code";
    //             PostedApproval."Sender ID" := Rec."Sender ID";
    //             PostedApproval."Salespers./Purch. Code" := Rec."Salespers./Purch. Code";
    //             PostedApproval."Approver ID" := Rec."Approver ID";
    //             PostedApproval.Status := Rec.Status;
    //             PostedApproval."Date-Time Sent for Approval" := Rec."Date-Time Sent for Approval";
    //             PostedApproval."Last Date-Time Modified" := Rec."Last Date-Time Modified";
    //             PostedApproval."Last Modified By ID" := Rec."Last Modified By User ID";
    //             PostedApproval.Comment := Rec.Comment;
    //             PostedApproval."Due Date" := Rec."Due Date";
    //             PostedApproval.Amount := Rec.Amount;
    //             PostedApproval."Amount (LCY)" := Rec."Amount (LCY)";
    //             PostedApproval."Currency Code" := Rec."Currency Code";
    //             PostedApproval."Approval Type" := Rec."Approval Type";
    //             PostedApproval."Limit Type" := Rec."Limit Type";
    //             PostedApproval."Available Credit Limit (LCY)" := Rec."Available Credit Limit (LCY)";
    //             PostedApproval.Insert();
    //         end;
    //     end;
    // end;
}

