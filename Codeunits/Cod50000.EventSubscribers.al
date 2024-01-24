codeunit 50000 "Event Subscribers"
{
    TableNo = "Default Dimension";

    [EventSubscriber(ObjectType::Table, Database::"Default Dimension", 'OnAfterModifyEvent', '', true, true)]
    local procedure OnAfterinsertevent()
    var
        EmployeeRec: Record Employee;
        DefaultDimensionRec: Record "Default Dimension";
    begin
        DefaultDimensionRec.Reset();
        DefaultDimensionRec.SetRange("Table ID", DefaultDimensionRec."Table ID");
        DefaultDimensionRec.SetRange("No.", DefaultDimensionRec."No.");
        if DefaultDimensionRec.FindFirst() then begin
            repeat
                if DefaultDimensionRec."Dimension Code" = 'PROJECT' then begin
                    EmployeeRec.Reset();
                    EmployeeRec.SetRange("No.", DefaultDimensionRec."No.");
                    if EmployeeRec.FindFirst() then
                        EmployeeRec.Billed := true
                    else
                        EmployeeRec.Billed := false;
                end;
            until DefaultDimensionRec.Next() = 0;
        end;
    end;
}
