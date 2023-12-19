pageextension 50013 "Sales Order Line Extension" extends "Sales Order Subform"
{
    layout
    {
        addafter("Qty. Assigned")
        {
            field("License Keys"; Rec."License Keys")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the License Keys field.';
            }
            field("Tenant ID"; Rec."Tenant ID")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Tenant ID field.';
            }
            field("Domain ID"; Rec."Domain ID")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Domain ID field.';
            }
        }
    }
}
