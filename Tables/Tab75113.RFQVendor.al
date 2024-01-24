table 75113 "RFQ Vendor"
{
    Caption = 'RFQ Vendor';
    DataClassification = ToBeClassified;

    fields
    {
        field(2; "Document No."; Code[20])
        {
            Caption = 'Document No';
            DataClassification = ToBeClassified;
        }
        field(3; "Line No."; Integer)
        {
            Caption = 'Line No';
            DataClassification = ToBeClassified;
        }
        field(4; "Vendor No."; Code[20])
        {
            Caption = 'Vendor No.';
            DataClassification = ToBeClassified;
            TableRelation = Vendor;

            trigger OnValidate()
            var
                VendorRec: Record Vendor;

            begin
                if VendorRec.Get("Vendor No.") then begin
                    "Vendor Name" := VendorRec.Name;
                    //"Vendor GST No." := VendorRec."GST Registration No."; // AA 07Jun23
                end;
            end;
        }
        field(5; "Vendor Name"; Text[100])
        {
            Caption = 'Vendor Name';
            DataClassification = ToBeClassified;
            Editable = false;

        }
        field(8; "Vendor GST No."; Text[100])
        {
            Caption = 'Vendor GST No.';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(10; Remarks; Text[100])
        {
            Caption = 'Remarks';
            DataClassification = ToBeClassified;
        }


    }
    keys
    {
        key(PK; "Document No.", "Line No.")
        {
            Clustered = true;
        }
    }
}
