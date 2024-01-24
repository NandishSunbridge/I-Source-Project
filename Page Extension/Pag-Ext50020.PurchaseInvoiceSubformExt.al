pageextension 50020 "Purchase Invoice Subform Ext" extends "Purch. Invoice Subform"
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
