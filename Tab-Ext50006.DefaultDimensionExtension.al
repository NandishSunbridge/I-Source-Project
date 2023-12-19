tableextension 50006 "Default Dimension Extension" extends "Default Dimension"
{
    fields
    {
        modify("Dimension Code")
        {
            trigger OnAfterValidate()
            var
                EmployeeRec: Record Employee;
                DefaultDimensionRec: Record "Default Dimension";
            begin
                DefaultDimensionRec.Reset();
                DefaultDimensionRec.SetRange("No.", Rec."No.");
                if DefaultDimensionRec.Find() then begin
                    repeat
                        if DefaultDimensionRec."Dimension Code" = 'PROJECT' then begin
                            EmployeeRec.Reset();
                            EmployeeRec.SetRange("No.", Rec."No.");
                            if EmployeeRec.FindFirst() then
                                EmployeeRec.Billed := true;
                        end;
                    until DefaultDimensionRec.Next() = 0;
                end;
            end;
        }
    }
}
