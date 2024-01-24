pageextension 50022 "Purch. Return Ord. Subform Ext" extends "Purchase Return Order Subform"
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
