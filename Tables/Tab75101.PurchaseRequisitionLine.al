/// <summary>
/// Table Purchase Requisition Line (ID 75101).
/// </summary>
table 75101 "Purchase Requisition Line"
{
    Caption = 'Purchase Requisition Line';
    DrillDownPageID = "Purchase Requisition Sub Form";
    LookupPageID = "Purchase Requisition Sub Form";
    DataClassification = CustomerContent;
    fields
    {
        field(50001; "Document No."; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Purchase Requisition Header"."Document No.";
            Caption = 'Document No.';
        }
        field(50002; "Line No."; Integer)
        {
            AutoIncrement = true;
            DataClassification = CustomerContent;
            Caption = 'Line No.';
        }
        field(50003; Type; Enum "Purchase Line Type")
        {
            Caption = 'Type';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                GetPRQHeader();  //Get Data from Header
            end;
        }
        field(50004; "Item No."; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = if (Type = const(" ")) "Standard Text"
            else
            if (Type = const("G/L Account")) "G/L Account" where("Account Type" = const(Posting))
            else
            if (Type = const(Item)) Item
            else
            if (Type = const("Fixed Asset")) "Fixed Asset"
            else
            if (Type = const("Charge (Item)")) "Item Charge"
            else
            if (Type = const(Resource)) "Resource";
            Caption = 'Item No.';

            trigger OnValidate()
            begin
                case Type of
                    Type::"G/L Account":
                        begin
                            if GLAccount.Get("Item No.") then
                                if Description = '' then
                                    Description := GLAccount.Name;
                            "Stock in Hand" := 0;
                            "Safety Stock" := 0;
                            "HSN/SAC" := '';
                            GPPG := '';
                        end;
                    Type::"Fixed Asset":
                        if FixedAsset.Get("Item No.") then begin
                            if Description = '' then
                                Description := FixedAsset.Description;
                            //"FA Identification" := FixedAsset."FA Identification No";
                        end;

                    Type::Item:
                        if Item.Get("Item No.") then begin
                            if Description = '' then
                                Description := Item.Description;

                            "Unit of Measure Code" := Item."Base Unit of Measure";
                            "Stock in Hand" := GetStockInHeandInBhiwadi("Item No.", "Location Code"); //Required Bhiwadi Only
                            "Safety Lead Time" := Item."Safety Lead Time";
                            "Safety Stock" := Item."Safety Stock Quantity";
                            //"HSN/SAC" := Item."HSN/SAC Code";
                            Description := Item.Description;
                            GPPG := Item."Gen. Prod. Posting Group";
                        end;
                /*  Type::Resource:
                      if Resource.Get("No.") then begin--------------------Nandish 30-10-23
                          IF Description = '' then
                              //  Description := ItemCategory.Description;
                              Description := Resource.Name;
                      end;*/
                end;


                //
                ItemVendor.Reset();
                ItemVendor.SetRange(ItemVendor."Item No.", "Item No.");
                if ItemVendor.Find('-') then begin
                    Vendor.Reset();
                    Vendor.SetRange(Vendor."No.", ItemVendor."Vendor No.");
                    if Vendor.Find('-') then begin
                        "Suppliers Code" := Vendor."No.";
                        "Suppliers Name" := Vendor.Name;
                    end;
                end;
                //-------------------Last Purchase----------------------------------
                GeneralLedgerSetup.Get();   //Get Current FY Dates
                PurchInvLine.Reset();
                PurchInvLine.SetCurrentkey("Posting Date", "Document No.");
                PurchInvLine.SetRange(Type, PurchInvLine.Type::Item);
                PurchInvLine.SetRange("No.", "Item No.");
                if PurchInvLine.FindLast() then begin
                    repeat
                        "Last Purchase Doc" := PurchInvLine."Document No.";  // Save this Last Purchase Document
                        "Last Quantity" := PurchInvLine.Quantity;
                        "Last Rate" := PurchInvLine."Direct Unit Cost";
                        "Last Pur Date" := PurchInvLine."Posting Date";      // Last Purchase Date
                        "Total Amount" := ROUND("Indent Quantity" * "Last Rate", 1.0);    //Tentative Required Amount
                        "Suppliers Code" := PurchInvLine."Buy-from Vendor No.";
                        Vendor.Reset();
                        Vendor.SetRange(Vendor."No.", "Suppliers Code");
                        if Vendor.Find('-') then
                            "Suppliers Name" := Vendor.Name;

                    until PurchInvLine.Next() = 0;
                    //-----------------------------------------------------------
                    TotalIssue := 0;
                    //AKS Start
                    PurchaseRequisitionHeader.Reset();
                    PurchaseRequisitionHeader.SetRange(PurchaseRequisitionHeader."Document No.", "Document No.");
                    if PurchaseRequisitionHeader.Find('-') then
                        DocDate := PurchaseRequisitionHeader."Document Date";
                    OneYearBackDate := CalcDate('<-365D>', DocDate);

                    //MESSAGE('%1-%2',DocDate,OneYearBackDate);
                    //AKS End
                    ItemLedgerEntry.Reset();
                    ItemLedgerEntry.SetRange(ItemLedgerEntry."Item No.", "Item No.");
                    ItemLedgerEntry.SetFilter(ItemLedgerEntry."Entry Type", '%1|%2', ItemLedgerEntry."entry type"::Consumption, ItemLedgerEntry."entry type"::"Negative Adjmt.");
                    ItemLedgerEntry.SetFilter(ItemLedgerEntry."Posting Date", '%1..%2', OneYearBackDate, DocDate); //AKS
                    if ItemLedgerEntry.Find('-') then
                        repeat
                            TotalIssue := TotalIssue + Abs(ItemLedgerEntry.Quantity);
                        until ItemLedgerEntry.Next() = 0;

                    //"Monthly Consumption":=ROUND(((TotalIssue/365)*30),1);
                    "Monthly Consumption" := ROUND((TotalIssue / 12), 1);
                    if "Monthly Consumption" <> 0 then
                        "Stock Sufficient Days" := ROUND(("Stock in Hand" - "Safety Stock") / ("Monthly Consumption" / 30), 1.0);

                end;
            end;
        }
        field(50005; Description; Text[100])
        {
            DataClassification = CustomerContent;
            Editable = true;
            Caption = 'Description';
        }
        field(50006; "Unit of Measure Code"; Code[10])
        {
            DataClassification = CustomerContent;
            Editable = true;
            TableRelation = "Unit of Measure";
            Caption = 'Unit of Measure Code';
        }
        field(50007; "Indent Quantity"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Indent Quantity';
            trigger OnValidate()
            begin
                if "Indent Quantity" = 0 then
                    Error(Text001Lbl)
                else begin
                    "Purchase Quantity" := "Indent Quantity";
                    "Balance Quantity" := "Indent Quantity";
                end;
                "Total Amount" := "Indent Quantity" * "Last Rate";
            end;
        }
        field(50008; "Required Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Required Date';
        }
        field(50009; "Monthly Consumption"; Decimal)
        {
            DataClassification = CustomerContent;
            Editable = false;
            Caption = 'Monthly Consumption';
        }
        field(50010; "Last Quantity"; Decimal)
        {
            DataClassification = CustomerContent;
            Editable = false;
            Caption = 'Last Quantity';
        }
        field(50011; "Last Rate"; Decimal)
        {
            DataClassification = CustomerContent;
            Editable = true;
            Caption = 'Last Rate';
        }
        field(50012; "Suppliers Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Editable = true;
            TableRelation = if (Type = const(Item)) "Item Vendor"."Vendor No." where("Item No." = field("Item No."))
            else
            if (Type = const("G/L Account")) Vendor."No." where("No." = filter('V-*'))
            else
            if (Type = const("Fixed Asset")) Vendor."No." where("No." = filter('V-*'));
            Caption = 'Suppliers Code';
            trigger OnValidate()
            begin
                if "Suppliers Code" <> '' then begin
                    if Vendor.Get("Suppliers Code") then
                        "Suppliers Name" := Vendor.Name;

                end else
                    "Suppliers Name" := '';

            end;
        }
        field(50013; "Suppliers Name"; Text[100])
        {
            Caption = 'Supplier''s Name';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(50014; "Stock in Hand"; Decimal)
        {
            DataClassification = CustomerContent;
            Editable = false;
            Caption = 'Stock in Hand';
        }
        field(50015; "Document Type"; Option)
        {
            DataClassification = CustomerContent;
            Editable = true;
            OptionCaption = 'Indent';
            OptionMembers = Indent;
            Caption = 'Document Type';
        }
        field(50016; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
            DataClassification = CustomerContent;
            Description = 'Global Dimension -1 (Branch)';
            Editable = true;
            TableRelation = "Dimension Value".Code where("Dimension Code" = const('DIM-BRN'));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(1, "Shortcut Dimension 1 Code");
            end;
        }
        field(50017; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            DataClassification = CustomerContent;
            Description = 'Global Dimension -2 (Unit)';
            Editable = true;
            TableRelation = "Dimension Value".Code where("Dimension Code" = const('DIM-UNIT'));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(2, "Shortcut Dimension 2 Code");
            end;
        }
        field(50018; "Location Code"; Code[10])
        {
            DataClassification = CustomerContent;
            Editable = true;
            TableRelation = Location.Code where("Use As In-Transit" = filter(false));
            Caption = 'Location Code';
        }
        field(50019; "Last Date Modified"; Date)
        {
            DataClassification = CustomerContent;
            Editable = false;
            Caption = 'Last Date Modified';
        }
        field(50020; "User ID"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "User Setup"."User ID";
            Caption = 'User ID';
        }
        field(50021; "Requisition Type"; Option)
        {
            DataClassification = CustomerContent;
            Editable = false;
            OptionCaption = 'Raw Material,General,Fixed Assets';
            OptionMembers = "Raw Material",General,"Fixed Assets";
            Caption = 'Requisition Type';
        }
        field(50022; "Dept. Code"; Code[10])
        {
            DataClassification = CustomerContent;
            Editable = true;
            TableRelation = "Dimension Value".Code where("Dimension Code" = const('DIM-DEPT'));
            Caption = 'Dept. Code';
        }
        field(50023; "Purchase Quantity"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Purchase Quantity';
            trigger OnValidate()
            begin
                if "Purchase Quantity" <> 0 then begin
                    "Total Amount" := ROUND("Purchase Quantity" * "Purchase Rate", 1.0);
                    "Balance Quantity" := "Indent Quantity" - "Purchase Quantity";
                end;
            end;
        }
        field(50024; "Balance Quantity"; Decimal)
        {
            DataClassification = CustomerContent;
            Editable = false;
            Caption = 'Balance Quantity';
        }
        field(50025; "Last Pur Date"; Date)
        {
            DataClassification = CustomerContent;
            Editable = false;
            Caption = 'Last Pur Date';
        }
        field(50026; "Total Amount"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Total Amount';
        }
        field(50027; "Purchase Order"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Purchase Order';
        }
        field(50028; "Purchase Order Line"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Purchase Order Line';
        }
        field(50029; "Purchase Rate"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Purchase Rate';
            trigger OnValidate()
            begin
                if "Purchase Rate" <> 0 then
                    "Total Amount" := ROUND("Purchase Quantity" * "Purchase Rate", 1.0)
                else
                    "Total Amount" := 0;

            end;
        }
        field(50030; "Safety Lead Time"; DateFormula)
        {
            DataClassification = CustomerContent;
            Caption = 'Safety Lead Time';
        }
        field(50031; "Approved Line"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Approved Line';
        }
        field(50032; "Safety Stock"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Safety Stock';
        }
        field(50033; "Stock Sufficient Days"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Stock Sufficient Days';
        }
        field(50034; "Requirement Type"; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'Normal,Urgent';
            OptionMembers = Normal,Urgent;
            Caption = 'Requirement Type';
        }
        field(50035; "HSN/SAC"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'HSN/SAC';
        }
        field(50036; GPPG; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Gen. Product Posting Group".Code;
            Caption = 'GPPG';
        }
        field(50037; "FA Identification"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'FA Identification';
        }
        field(50038; "Part Description"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Part Description';
        }
        field(50039; "Release PO"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Release PO';
        }
        field(50040; "Last Purchase Doc"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Purch. Inv. Header"."No." where("Buy-from Vendor No." = field("Suppliers Code"));
            Caption = 'Last Purchase Doc';
        }
        field(50041; "Purchase Order Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Purchase Order Date';
        }
        field(50080; "Dimension Set ID"; Integer)
        {
            Caption = 'Dimension Set ID';
            DataClassification = CustomerContent;
            Editable = false;
            TableRelation = "Dimension Set Entry";

            trigger OnLookup()
            begin
                ShowDimensions();
            end;
        }
        field(50081; Q1; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Q1';
        }
        field(50082; Q2; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Q2';
        }
        field(50083; Q3; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Q3';
        }
    }

    keys
    {
        key(Key1; "Document Type", "Document No.", "Line No.")
        {
            Clustered = true;
        }
        key(Key2; "Stock in Hand", "Document No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        if ("Document Type" <> PurchaseRequisitionHeader."Document Type") or ("Document No." <> PurchaseRequisitionHeader."Document No.") then
            PurchaseRequisitionHeader.Get("Document Type", "Document No.");

        "Document Type" := "document type"::Indent;
        PurchaseRequisitionHeader.TestField(Authorized, false);
        PurchaseRequisitionHeader.TestField("Sent for Authorization", false);
    end;

    trigger OnModify()
    begin
        if ("Document Type" <> PurchaseRequisitionHeader."Document Type") or ("Document No." <> PurchaseRequisitionHeader."Document No.") then
            PurchaseRequisitionHeader.Get("Document Type", "Document No.");

        //PRQHeader.TESTFIELD(Authorized,FALSE);
        //PRQHeader.TESTFIELD("Sent for Authorization",FALSE);
    end;

    var
        FixedAsset: Record "Fixed Asset";
        GLAccount: Record "G/L Account";
        GeneralLedgerSetup: Record "General Ledger Setup";
        Item: Record Item;
        ItemCategory: Record "Item Category";
        ItemLedgerEntry: Record "Item Ledger Entry";
        ItemVendor: Record "Item Vendor";
        PurchInvLine: Record "Purch. Inv. Line";
        PurchaseRequisitionHeader: Record "Purchase Requisition Header";
        //StandardText: Record "Standard Text";
        Vendor: Record Vendor;
        DimensionManagement: Codeunit DimensionManagement;
        FixedAssest: Boolean;
        DocDate: Date;
        OneYearBackDate: Date;
        TotalIssue: Decimal;
        Text001Lbl: label 'Indent Quantity Can not be ZERO';




    procedure GetPRQHeader()

    begin
        PurchaseRequisitionHeader.Reset();
        PurchaseRequisitionHeader.SetRange(PurchaseRequisitionHeader."Document No.", "Document No.");
        if PurchaseRequisitionHeader.Find('-') then begin
            "Document Type" := PurchaseRequisitionHeader."Document Type";
            "Requisition Type" := PurchaseRequisitionHeader."Requisition Type";
            "Requirement Type" := PurchaseRequisitionHeader."Requirement Type";
            "Dept. Code" := PurchaseRequisitionHeader."Dept. Code";
            "Shortcut Dimension 1 Code" := PurchaseRequisitionHeader."Shortcut Dimension 1 Code";
            "Shortcut Dimension 2 Code" := PurchaseRequisitionHeader."Shortcut Dimension 2 Code";
            "Location Code" := PurchaseRequisitionHeader."Location Code";
            "Purchase Order" := PurchaseRequisitionHeader."Purchase Order";  // Pass on to line
#pragma warning disable AA0206
            FixedAssest := false;  // Set Fixed Assest
#pragma warning restore AA0206
            if PurchaseRequisitionHeader."Fixed Assets Code" <> '' then
                FixedAssest := true;

        end;
    end;



    procedure ShowDimensions()

    begin
        "Dimension Set ID" :=
#pragma warning disable AA0217
          DimensionManagement.EditDimensionSet("Dimension Set ID", StrSubstNo('%1 %2 %3', "Document Type", "Document No.", "Line No."));
#pragma warning restore AA0217
        //VerifyItemLineDim;
        DimensionManagement.UpdateGlobalDimFromDimSetID("Dimension Set ID", "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code");
    end;



    procedure CreateDim(Type1: Integer; No1: Code[20]; Type2: Integer; No2: Code[20]; Type3: Integer; No3: Code[20])

    var
        SourceCodeSetup: Record "Source Code Setup";
        No: array[10] of Code[20];
        TableID: array[10] of Integer;
    begin
        SourceCodeSetup.Get();
        TableID[1] := Type1;
        No[1] := No1;
        TableID[2] := Type2;
        No[2] := No2;
        TableID[3] := Type3;
        No[3] := No3;
        "Shortcut Dimension 1 Code" := '';
        "Shortcut Dimension 2 Code" := '';

        /*  "Dimension Set ID" :=      ----------------20-11-23 Nandish
   #pragma warning disable AL0432
            DimensionManagement.GetDefaultDimID(
   #pragma warning restore AL0432
             TableID, No, SourceCodeSetup.Sales,
             "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code",
            PurchaseRequisitionHeader."Dimension Set ID", Database::Item);
          DimensionManagement.UpdateGlobalDimFromDimSetID("Dimension Set ID", "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code");*/
    end;



    procedure ValidateShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])

    begin
        DimensionManagement.ValidateShortcutDimValues(FieldNumber, ShortcutDimCode, "Dimension Set ID");
    end;



    procedure LookupShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])

    begin
        DimensionManagement.LookupDimValueCode(FieldNumber, ShortcutDimCode);
        ValidateShortcutDimCode(FieldNumber, ShortcutDimCode);
    end;



    procedure ShowShortcutDimCode(var ShortcutDimCode: array[8] of Code[20])

    begin
        DimensionManagement.GetShortcutDimensions("Dimension Set ID", ShortcutDimCode);
    end;

    local procedure GetStockInHeandInBhiwadi(InItem: Code[20]; InLocation: Code[20]): Decimal
    var
        ILE: Record "Item Ledger Entry";
        TempQty: Decimal;
    begin
        TempQty := 0;
        if InItem <> '' then begin
            ILE.Reset();
            ILE.SetRange("Item No.", InItem);
            ILE.SetFilter(Quantity, '<>%1', 0);
            ILE.SetRange("Location Code", InLocation);
            if ILE.FindSet() then
                repeat
                    TempQty += ILE.Quantity;
                until ILE.Next() = 0;

        end;
        exit(TempQty);
    end;
}

