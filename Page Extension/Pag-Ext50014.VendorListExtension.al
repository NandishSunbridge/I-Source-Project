pageextension 50014 "Vendor List Extension" extends "Vendor List"
{
    layout
    {
        addafter(Contact)
        {
            field(MSME; Rec.MSME)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the MSME field.';
            }
        }
    }
}
