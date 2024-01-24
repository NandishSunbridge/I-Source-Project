pageextension 50021 "Posted Purch. Inv. Subform Ext" extends "Posted Purch. Invoice Subform"
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
