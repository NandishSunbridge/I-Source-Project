report 50000 "Purchase Order Report"
{
    ApplicationArea = All;
    Caption = 'Purchase Order Report';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = 'Purchaseorderreport.rdl';

    dataset
    {
        dataitem(PurchaseHeader; "Purchase Header")
        {
            PrintOnlyIfDetail = true;
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
            dataitem("Purchase Line"; "Purchase Line")
            {
                DataItemLink = "Document No." = field("No.");
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
                trigger OnAfterGetRecord()
                begin
                    SrNo += 1;

                    DGST.Reset();
                    DGST.SetRange("Document No.", PurchaseHeader."No.");
                    TotalGST := 0;
                    CGSTAmount := 0;
                    SGSTAmount := 0;
                    IGSTAmount := 0;
                    if DGST.FindFirst() then begin
                        if DGST."GST Component Code" = 'CGST' then begin

                            CGSTAmount += -DGST."GST Amount";

                            // GSTpercentage := DGST."GST %";

                        end;
                        if DGST."GST Component Code" = 'SGST' then begin

                            SGSTAmount += -DGST."GST Amount";

                            //  SGSTpercentage := DGST."GST %";

                        end;

                        if DGST."GST Component Code" = 'IGST' then begin

                            IGSTAmount += -DGST."GST Amount";

                            //   IGSTpercentage := DGST."GST %";

                        end;
                    end;
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
                end;

                /////Sub Total Calculation/////////
                Purchaselinerec.Reset();
                Purchaselinerec.SetRange("Document Type", "Document Type"::Order);
                Purchaselinerec.SetRange("Document No.", "Purchase Line"."Document No.");
                if Purchaselinerec.FindFirst() then begin
                    repeat
                        Subtotal += Purchaselinerec.Amount;
                    until Purchaselinerec.Next() = 0;
                end;

            end;
        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(processing)
            {
            }
        }
    }
    var
        CompanyInfo: Record "Company Information";
        SrNo: Integer;
        VendorRec: Record Vendor;
        Vendorgst: Code[20];
        Vendorpanno: code[20];
        Purchaseheaderrec: Record "Purchase Header";
        Purchaselinerec: Record "Purchase Line";
        Subtotal: Decimal;
        DGST: Record "Detailed GST Ledger Entry";
        TotalGST: Decimal;
        CGSTAmount: Decimal;
        IGSTAmount: Decimal;
        SGSTAmount: Decimal;
}
