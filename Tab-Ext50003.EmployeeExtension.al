tableextension 50003 "Employee Extension" extends Employee
{
    fields
    {
        field(50000; Billed; Boolean)
        {
            Caption = 'Billed';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                DefaultDimenRec: Record "Default Dimension";
            begin
                DefaultDimenRec.Reset();
                DefaultDimenRec.SetRange("No.", Rec."No.");
                if DefaultDimenRec.FindFirst() then begin
                    repeat
                        if DefaultDimenRec."Dimension Code" = 'PROJECT' then
                            Rec.Billed := true;
                    until DefaultDimenRec.Next() = 0;
                end;
            end;
        }
        field(50001; "P.A.N. No."; Code[10])
        {
            Caption = 'P.A.N. No.';
            DataClassification = ToBeClassified;
        }
        field(50002; "Masked PAN No"; Code[10])
        {
            Caption = 'Masked PAN No';
            DataClassification = ToBeClassified;
            Editable = false;
        }
    }
}

