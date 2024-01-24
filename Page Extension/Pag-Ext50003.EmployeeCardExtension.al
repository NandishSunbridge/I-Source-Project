pageextension 50003 "Employee Card Extension" extends "Employee Card"
{
    layout
    {
        addafter(Status)
        {
            field(Billed; Rec.Billed)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Billed field.';
            }
        }
        addafter("Birth Date")
        {
            field("P.A.N. No."; Rec."P.A.N. No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the P.A.N. No. field.';
                AccessByPermission = tabledata Employee = r;
                trigger OnValidate()
                begin
                    if StrLen(Rec."P.A.N. No.") < 10 then
                        Error('Please Enter a valid P.A.N. No.');
                    Rec."P.A.N. No." := DataMaking;
                    Rec."Masked PAN No" := Rec."P.A.N. No.";
                end;
            }
        }
    }
    procedure DataMaking(): Text
    begin
        if StrLen(Rec."P.A.N. No.") > 4 then
            exit('******' + Format(Rec."P.A.N. No.").Substring(StrLen(Rec."P.A.N. No.") - 3))
        else
            exit('');
    end;
}
