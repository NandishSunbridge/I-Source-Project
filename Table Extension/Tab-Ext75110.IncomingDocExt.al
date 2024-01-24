/// <summary>
/// TableExtension Incoming Doc.Ext (ID 75110) extends Record Incoming Document.
/// </summary>
tableextension 75110 "Incoming Doc.Ext" extends "Incoming Document"
{
    procedure SetIndentDoc(var IndentHeader: Record "Purchase Requisition Header")
    begin
        if IndentHeader."Incoming Document Entry No." = 0 then
            exit;
        Get(IndentHeader."Incoming Document Entry No.");
        TestReadyForProcessing();
        TestIfAlreadyExists();
        IndentHeader."Document Type" := IndentHeader."document type"::Indent;
        Modify();
        if not DocLinkExists(IndentHeader) then
            IndentHeader.AddLink(GetURL(), Description);
    end;
}

