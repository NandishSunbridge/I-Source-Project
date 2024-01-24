report 50002 "Purchase Return Order Report"
{
    Caption = 'Purchase Return Order Report';
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './Report Layouts/Purchasereturnorderreport.rdl';
    dataset
    {
        dataitem(PurchaseHeader; "Purchase Header")
        {
            column(No_PurchaseHeader; "No.")
            {
            }
            column(BuyfromVendorNo_PurchaseHeader; "Buy-from Vendor No.")
            {
            }
            column(BuyfromVendorName_PurchaseHeader; "Buy-from Vendor Name")
            {
            }
            column(BuyfromVendorName2_PurchaseHeader; "Buy-from Vendor Name 2")
            {
            }
            column(BuyfromAddress_PurchaseHeader; "Buy-from Address")
            {
            }
            column(BuyfromAddress2_PurchaseHeader; "Buy-from Address 2")
            {
            }
            column(BuyfromCity_PurchaseHeader; "Buy-from City")
            {
            }
            column(BuyfromContact_PurchaseHeader; "Buy-from Contact")
            {
            }
            column(BuyfromContactNo_PurchaseHeader; "Buy-from Contact No.")
            {
            }
            column(BuyfromCountryRegionCode_PurchaseHeader; "Buy-from Country/Region Code")
            {
            }
            column(BuyfromPostCode_PurchaseHeader; "Buy-from Post Code")
            {
            }
            column(DocumentDate_PurchaseHeader; "Document Date")
            {
            }
            column(PANNo_PurchaseHeader; "P.A.N. No.")
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
            column(ShiptoCode_PurchaseHeader; "Ship-to Code")
            {
            }
            column(ShiptoContact_PurchaseHeader; "Ship-to Contact")
            {
            }
            column(ShiptoCountryRegionCode_PurchaseHeader; "Ship-to Country/Region Code")
            {
            }
            column(ShiptoPostCode_PurchaseHeader; "Ship-to Post Code")
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
            dataitem("Purchase Line"; "Purchase Line")
            {
                DataItemLink = "Document No." = field("No.");

                column(No_PurchaseLine; "No.")
                {
                }
                column(Quantity_PurchaseLine; Quantity)
                {
                }
                column(UnitofMeasureCode_PurchaseLine; "Unit of Measure Code")
                {
                }
                column(UnitCost_PurchaseLine; "Unit Cost")
                {
                }
                column(SrNo; SrNo)
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
                    Purchaselinerec.SetRange("Document No.", "Purchase Line"."Document No.");
                    if Purchaselinerec.FindFirst() then begin
                        repeat
                            Subtotal += Purchaselinerec.Amount;
                        until Purchaselinerec.Next() = 0;
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
                    Vendorcinno := VendorRec."CIN NO.";
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
        Vendorcinno: Code[21];
        Purchaselinerec: Record "Purchase Line";
        Subtotal: Decimal;
}
