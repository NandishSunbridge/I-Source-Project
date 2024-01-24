report 50000 "Purchase Order Report"
{
    //  ApplicationArea = All;
    Caption = 'Purchase Order Report';
    //  UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './Report Layouts/Purchaseorderreport.rdl';

    dataset
    {
        dataitem(PurchaseHeader; "Purchase Header")
        {
            // PrintOnlyIfDetail = true;
            DataItemTableView = sorting("No.", "Document Type") where("Document Type" = filter(order));
            column(No; "No.")
            {
            }
            column(PANNo; "P.A.N. No.")
            {
            }
            column(PaymentTermsCode; "Payment Terms Code")
            {
            }
            column(BuyfromVendorNo; "Buy-from Vendor No.")
            {
            }
            column(BuyfromVendorName; "Buy-from Vendor Name")
            {
            }
            column(BuyfromVendorName2; "Buy-from Vendor Name 2")
            {
            }
            column(BuyfromCountryRegionCode; "Buy-from Country/Region Code")
            {
            }
            column(BuyfromCountryName; CountryName[1])
            {
            }
            column(ShiptoCountryName; CountryName[2])
            {
            }
            column(CompanyCountryName; CountryName[3])
            {
            }
            column(BuyfromCity; "Buy-from City")
            {
            }
            column(BuyfromAddress; "Buy-from Address")
            {
            }
            column(BuyfromAddress2; "Buy-from Address 2")
            {
            }
            column(BuyfromPostCode; "Buy-from Post Code")
            {
            }
            column(BuyfromContact_PurchaseHeader; "Buy-from Contact")
            {
            }
            column(DocumentDate_PurchaseHeader; "Document Date")
            {
            }
            column(ShiptoName_PurchaseHeader; "Ship-to Name")
            {
            }
            column(ShiptoAddress_PurchaseHeader; "Ship-to Address")
            {
            }
            column(ShiptoAddress2_PurchaseHeader; "Ship-to Address 2")
            {
            }
            column(ShiptoCity_PurchaseHeader; "Ship-to City")
            {
            }
            column(ShiptoPostCode_PurchaseHeader; "Ship-to Post Code")
            {
            }
            column(ShiptoCountryRegionCode_PurchaseHeader; "Ship-to Country/Region Code")
            {
            }
            column(ShiptoContact_PurchaseHeader; "Ship-to Contact")
            {
            }
            column(CompanyName; CompanyInfo.Name)
            {
            }
            column(CompanyAddress; CompanyInfo.Address)
            {
            }
            column(CompanyAddress2; CompanyInfo."Address 2")
            {
            }
            column(CompanyCity; CompanyInfo.City)
            {
            }
            column(CompanyCountry; CompanyInfo."Country/Region Code")
            {
            }
            column(CompanyPostcode; CompanyInfo."Post Code")
            {
            }
            column(CompanyHomepage; CompanyInfo."Home Page")
            {
            }
            column(CompanyGSTNO; CompanyInfo."GST Registration No.")
            {
            }
            column(CompanyCinno; CompanyInfo."CIN NO.")
            {
            }
            column(CompanyPANNO; CompanyInfo."P.A.N. No.")
            {
            }
            column(CompanyLogo; CompanyInfo.Picture)
            {
            }
            column(CompanyRegistrationNo; CompanyInfo."Registration No.")
            {
            }
            column(Vendorgst; Vendorgst)
            {
            }
            column(Vendorpanno; Vendorpanno)
            {
            }
            column(Vendorcinno; Vendorcinno)
            {
            }
            dataitem(PurchaseLine; "Purchase Line")
            {
                DataItemLink = "Document No." = field("No.");
                DataItemTableView = sorting("Document No.", "Document Type") where("Document Type" = filter(order));
                column(ItemNo; "No.")
                {
                }
                column(Quantity_PurchaseLine; Quantity)
                {
                }
                column(Description_PurchaseLine; Description)
                {
                }
                column(UnitofMeasureCode_PurchaseLine; "Unit of Measure Code")
                {
                }
                column(UnitCost_PurchaseLine; "Unit Cost")
                {
                }
                column(Amount_PurchaseLine; Amount)
                {
                }
                column(ServiceDuration_PurchaseLine; "Service Duration")
                {
                }
                column(SrNo; SrNo)
                {
                }
                column(Subtotal; Subtotal)
                {
                }
                column(CGSTAmount; CGSTAmount)
                {
                }
                column(SGSTAmount; SGSTAmount)
                {
                }
                column(IGSTAmount; IGSTAmount)
                {
                }
                column(CGSTper; GSTper[1])
                {
                }
                column(SGSTper; GSTper[2])
                {
                }
                column(IGSTper; GSTper[3])
                {
                }
                column(Total; Total)
                {
                }
                trigger OnAfterGetRecord()
                var
                    RecLocation: Record Location;
                begin
                    SrNo += 1;

                    /////Sub Total Calculation/////////
                    Purchaselinerec.Reset();
                    Purchaselinerec.SetRange("Document Type", "Document Type"::Order);
                    Purchaselinerec.SetRange("Document No.", PurchaseLine."Document No.");
                    if Purchaselinerec.FindFirst() then begin
                        repeat
                            Subtotal += Purchaselinerec.Amount;
                        until Purchaselinerec.Next() = 0;
                    end;

                    //For CGST Calculation
                    TaxTransactionValue.SetRange("Tax Record ID", PurchaseLine.RecordId);
                    TaxTransactionValue.SetRange("Tax Type", 'GST');
                    TaxTransactionValue.SetRange("Value Type", TaxTransactionValue."Value Type"::COMPONENT);
                    TaxTransactionValue.SetRange("Value ID", 2); //For CGST
                    if TaxTransactionValue.FindSet() then begin
                        repeat
                            GSTper[1] += TaxTransactionValue.Percent;
                            TaxComponent.Get('GST', 2);
                            CGSTAmount += TaxTransactionValue.Amount;
                        //CGSTAmount := GSTAMT1[1];
                        //   TaxRateComputation.RoundAmount(TaxTransactionValue.Amount, TaxComponent."Rounding Precision", TaxComponent.Direction);
                        until TaxTransactionValue.Next() = 0;
                    end;
                    //FOR SGST Calculation
                    TaxTransactionValue.SetRange("Tax Record ID", PurchaseLine.RecordId);
                    TaxTransactionValue.SetRange("Tax Type", 'GST');
                    TaxTransactionValue.SetRange("Value Type", TaxTransactionValue."Value Type"::COMPONENT);
                    TaxTransactionValue.SetRange("Value ID", 6); //For SGST
                    if TaxTransactionValue.FindFirst() then begin
                        repeat
                            GSTper[2] += TaxTransactionValue.Percent;
                            TaxComponent.Get('GST', 6);
                            GSTAMT1[2] += TaxTransactionValue.Amount;
                            SGSTAmount := GSTAMT1[2];
                        // TaxRateComputation.RoundAmount(TaxTransactionValue.Amount, TaxComponent."Rounding Precision", TaxComponent.Direction);
                        until TaxTransactionValue.Next() = 0;
                    end;
                    //FOR IGST Calculation
                    TaxTransactionValue.SetRange("Tax Record ID", PurchaseLine.RecordId);
                    TaxTransactionValue.SetRange("Tax Type", 'GST');
                    TaxTransactionValue.SetRange("Value Type", TaxTransactionValue."Value Type"::COMPONENT);
                    TaxTransactionValue.SetRange("Value ID", 3); //For IGST
                    if TaxTransactionValue.FindFirst() then begin
                        repeat
                            GSTper[3] += TaxTransactionValue.Percent;
                            TaxComponent.Get('GST', 3);
                            GSTAMT1[3] += TaxTransactionValue.Amount;
                            IGSTAmount := IGSTAmount;
                        // TaxRateComputation.RoundAmount(TaxTransactionValue.Amount, TaxComponent."Rounding Precision", TaxComponent.Direction);
                        until TaxTransactionValue.Next() = 0;
                    end;
                    //Total Calculation
                    Total := Subtotal + GSTAMT1[1] + GSTAMT1[2] + GSTAMT1[3];
                end;
            }
            trigger OnAfterGetRecord()
            begin
                CompanyInfo.Get();
                CompanyInfo.CalcFields(Picture);

                /////Vendor Details////////
                VendorRec.Reset();
                VendorRec.SetRange("No.", "Buy-from Vendor No.");
                if VendorRec.FindFirst() then begin
                    Vendorgst := VendorRec."GST Registration No.";
                    Vendorpanno := VendorRec."P.A.N. No.";
                    Vendorcinno := VendorRec."CIN NO.";
                end;

                CountryNameRec.Reset();
                CountryNameRec.SetRange(Code, PurchaseHeader."Buy-from Country/Region Code");
                if CountryNameRec.FindFirst() then begin
                    CountryName[1] := CountryNameRec.Name;
                end;

                CountryNameRec.Reset();
                CountryNameRec.SetRange(Code, PurchaseHeader."Ship-to Country/Region Code");
                if CountryNameRec.FindFirst() then begin
                    CountryName[2] := CountryNameRec.Name;
                end;

                CountryNameRec.Reset();
                CountryNameRec.SetRange(Code, CompanyInfo."Country/Region Code");
                if CountryNameRec.FindFirst() then begin
                    CountryName[3] := CountryNameRec.Name;
                end;


                // DetailedGSTLedgerEntry.Reset;
                // DetailedGSTLedgerEntry.SetCurrentKey("GST Component Code");
                // DetailedGSTLedgerEntry.SetRange("Document No.", PurchaseHeader."No.");
                // DetailedGSTLedgerEntry.SetRange("Entry Type", DetailedGSTLedgerEntry."Entry Type"::"Initial Entry");
                // DetailedGSTLedgerEntry.SetRange("Transaction Type", DetailedGSTLedgerEntry."Transaction Type"::Purchase);
                // if DetailedGSTLedgerEntry.FindSet() then begin
                //     TotalGST := 0;
                //     CGSTAmount := 0;
                //     SGSTAmount := 0;
                //     IGSTAmount := 0;
                //     REPEAT
                //         if DetailedGSTLedgerEntry."GST Component Code" = 'CGST' then begin

                //             CGSTAmount += DetailedGSTLedgerEntry."GST Amount";

                //             // GSTpercentage := DGST."GST %";

                //         end;
                //         if DetailedGSTLedgerEntry."GST Component Code" = 'SGST' then begin

                //             SGSTAmount += DetailedGSTLedgerEntry."GST Amount";

                //             //  SGSTpercentage := DGST."GST %";

                //         end;

                //         if DetailedGSTLedgerEntry."GST Component Code" = 'IGST' then begin

                //             IGSTAmount += DetailedGSTLedgerEntry."GST Amount";

                //             //   IGSTpercentage := DGST."GST %";

                //         end;
                //     UNTIL DetailedGSTLedgerEntry.NEXT = 0;
                // end;




            end;
        }
    }
    // requestpage
    // {
    //     layout
    //     {
    //         area(content)
    //         {
    //             group(GroupName)
    //             {
    //             }
    //         }
    //     }
    //     actions
    //     {
    //         area(processing)
    //         {
    //         }
    //     }
    // }
    var
        CompanyInfo: Record "Company Information";
        SrNo: Integer;
        VendorRec: Record Vendor;
        Vendorgst: Code[20];
        Vendorpanno: code[20];
        Purchaseheaderrec: Record "Purchase Header";
        Purchaselinerec: Record "Purchase Line";
        Subtotal: Decimal;
        DetailedGSTLedgerEntry: Record "Detailed GST Ledger Entry";
        TotalGST: Decimal;
        CGSTAmount: Decimal;
        IGSTAmount: Decimal;
        SGSTAmount: Decimal;
        Vendorcinno: Code[21];
        TaxTransactionValue: Record "Tax Transaction Value";
        GSTAMT1: array[4] of Decimal;
        TaxComponent: Record "Tax Component";
        GSTPer: array[4] of Decimal;
        Total: Decimal;
        TaxRateComputation: Codeunit "Tax Rate Computation";
        purchline: Record "Purchase Line";
        CountryNameRec: Record "Country/Region";
        CountryName: array[3] of Text[50];
}
