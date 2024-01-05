report 50001 "Customer Invoice Report"
{
    ApplicationArea = All;
    Caption = 'Customer Invoice Report';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = 'Customerinvoicereport.rdl';
    dataset
    {
        dataitem(PurchaseHeader; "Purchase Header")
        {
            PrintOnlyIfDetail = true;
            DataItemTableView = sorting("No.", "Document Type") where("Document Type" = filter(order));
            column(No; "No.")
            {
            }
            column(BuyfromVendorNo; "Buy-from Vendor No.")
            {
            }
            column(DocumentDate; "Document Date")
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
            column(CompanyCinno; CompanyInfo."CIN NO.")
            {
            }
            column(CompanyPhoneno; CompanyInfo."Phone No.")
            {
            }
            column(CompanyEmail; CompanyInfo."E-Mail")
            {
            }
            column(Date; Date)
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

                /////Vendor Details////////
                VendorRec.Reset();
                VendorRec.SetRange("No.", "Buy-from Vendor No.");
                if VendorRec.FindFirst() then begin
                    Vendorgst := VendorRec."GST Registration No.";
                    Vendorpanno := VendorRec."P.A.N. No.";
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
        VendorRec: Record Vendor;
        Vendorgst: Code[20];
        Vendorpanno: code[20];
        SrNo: Integer;
        Date: DateTime;
}
