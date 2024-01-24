pageextension 50024 "Purch. Cr. Memo Sub. Ext" extends "Purch. Cr. Memo Subform"
{
    layout
    {
        addbefore(Quantity)
        {
            field("Service Duration"; Rec."Service Duration")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Service Duration of Item.';
            }
        }
    }
}
