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
                column(SrNo; SrNo)
                {
                }
                trigger OnAfterGetRecord()
                begin
                    SrNo += 1;
                end;
            }
            trigger OnAfterGetRecord()
            begin
                CompanyInfo.Get();
                CompanyInfo.CalcFields(Picture);
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
}
