pageextension 50000 "Item Card Extension" extends "Item Card"
{
    layout
    {
        addafter("Inventory Posting Group")
        {
            field("OEM-Partner"; Rec."OEM-Partner")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the OEM-Partner field,OEM-Original Equipment Manufacturer.';
            }
        }
    }
}
