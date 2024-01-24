pageextension 50019 "Purchase Order Subform Ext" extends "Purchase Order Subform"
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
