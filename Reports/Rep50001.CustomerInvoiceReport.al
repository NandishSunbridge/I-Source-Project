report 50001 "Customer Invoice Report"
{
    ApplicationArea = All;
    Caption = 'Customer Invoice Report';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './Report Layouts/Customerinvoicereport1.rdl';
    dataset
    {
        dataitem(SalesInvoiceHeader; "Sales Invoice Header")
        {
            column(No; "No.")
            {
            }
            column(BilltoCustomerNo; "Bill-to Customer No.")
            {
            }
            column(BilltoName; "Bill-to Name")
            {
            }
            column(BilltoName2; "Bill-to Name 2")
            {
            }
            column(BilltoAddress; "Bill-to Address")
            {
            }
            column(BilltoAddress2; "Bill-to Address 2")
            {
            }
            column(BilltoCity; "Bill-to City")
            {
            }
            column(BilltoCountryRegionCode; "Bill-to Country/Region Code")
            {
            }
            column(BilltoPostCode; "Bill-to Post Code")
            {
            }
            column(BilltoContact; "Bill-to Contact")
            {
            }
            column(SelltoCustomerName; "Sell-to Customer Name")
            {
            }
            column(SelltoCustomerName2; "Sell-to Customer Name 2")
            {
            }
            column(SelltoCustomerNo; "Sell-to Customer No.")
            {
            }
            column(SelltoCountryRegionCode; "Sell-to Country/Region Code")
            {
            }
            column(SelltoEMail; "Sell-to E-Mail")
            {
            }
            column(SelltoPhoneNo; "Sell-to Phone No.")
            {
            }
            column(SelltoPostCode; "Sell-to Post Code")
            {
            }
            column(SelltoContact; "Sell-to Contact")
            {
            }
            column(SelltoCity; "Sell-to City")
            {
            }
            column(SelltoAddress; "Sell-to Address")
            {
            }
            column(SelltoAddress2; "Sell-to Address 2")
            {
            }
            column(SalespersonCode; "Salesperson Code")
            {
            }
            column(ShiptoName; "Ship-to Name")
            {
            }
            column(ShiptoName2; "Ship-to Name 2")
            {
            }
            column(ShiptoCountryRegionCode; "Ship-to Country/Region Code")
            {
            }
            column(ShiptoContact; "Ship-to Contact")
            {
            }
            column(ShiptoCode; "Ship-to Code")
            {
            }
            column(ShiptoCity; "Ship-to City")
            {
            }
            column(ShiptoAddress; "Ship-to Address")
            {
            }
            column(ShiptoAddress2; "Ship-to Address 2")
            {
            }
            column(ShiptoPostCode; "Ship-to Post Code")
            {
            }
            column(DocumentDate_SalesInvoiceHeader; "Document Date")
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
            column(Bankname; CompanyInfo."Bank Name")
            {
            }
            column(Bankaccountno; CompanyInfo."Bank Account No.")
            {
            }
            column(Swiftcode; CompanyInfo."SWIFT Code")
            {
            }
            column(Bankbranchno; CompanyInfo."Bank Branch No.")
            {
            }
            column(Date; Date)
            {
            }
            column(CompanyCountryName; CountryName[3])
            {
            }
            column(StateCode; StateCode)
            {
            }
            column(Customergst; Customergst)
            {
            }
            column(Vendorpanno; Vendorpanno)
            {
            }
            dataitem("Sales Invoice Line"; "Sales Invoice Line")
            {
                DataItemLink = "Document No." = field("No.");
                column(No_SalesInvoiceLine; "No.")
                {
                }
                column(Quantity_SalesInvoiceLine; Quantity)
                {
                }
                column(UnitPrice_SalesInvoiceLine; "Unit Price")
                {
                }
                column(UnitofMeasureCode_SalesInvoiceLine; "Unit of Measure Code")
                {
                }
                column(Description_SalesInvoiceLine; Description)
                {
                }
                column(TOTAL; TOTAL)
                {
                }
                column(GrandTotal; GrandTotal)
                {
                }
                column(SrNo; SrNo)
                {
                }
                trigger OnAfterGetRecord()
                begin
                    SrNo += 1;

                    ///////Calculation of Sub-Total//////////
                    "Sales Invoice Line".RESET;
                    "Sales Invoice Line".SETRANGE("Document No.", "Sales Invoice Line"."Document No.");
                    IF "Sales Invoice Line".FINDFIRST THEN BEGIN
                        repeat
                            TOTAL += "Sales Invoice Line".Amount;
                        until "Sales Invoice Line".Next() = 0;
                    END;

                    //////Amount Including VAT-Grand Total///////
                    "Sales Invoice Line".RESET;
                    "Sales Invoice Line".SETRANGE("Document No.", "Sales Invoice Line"."Document No.");
                    IF "Sales Invoice Line".FINDFIRST THEN BEGIN
                        repeat
                            GrandTotal += "Sales Invoice Line"."Amount Including VAT";
                        until "Sales Invoice Line".Next() = 0;
                    END;
                end;

            }
            trigger OnAfterGetRecord()
            begin
                Date := CurrentDateTime;
                CompanyInfo.Get();
                CompanyInfo.CalcFields(Picture);

                if CompanyInfo.FindFirst() then begin
                    StateRec.Reset();
                    StateRec.SetRange(Code, CompanyInfo."State Code");
                    if StateRec.FindFirst() then begin
                        StateCode := StateRec."State Code (GST Reg. No.)";
                    end;
                end;



                /////Vendor Details////////
                VendorRec.Reset();
                //  VendorRec.SetRange("No.", "Buy-from Vendor No.");
                if VendorRec.FindFirst() then begin
                    Vendorgst := VendorRec."GST Registration No.";
                    Vendorpanno := VendorRec."P.A.N. No.";
                end;

                /////Customer Details////////
                CustomerRec.Reset();
                CustomerRec.SetRange("No.", SalesInvoiceHeader."Sell-to Customer No.");
                if CustomerRec.FindFirst() then begin
                    Customergst := CustomerRec."GST Registration No.";
                    Customerpanno := CustomerRec."P.A.N. No.";
                end;

                CountryNameRec.Reset();
                CountryNameRec.SetRange(Code, CompanyInfo."Country/Region Code");
                if CountryNameRec.FindFirst() then begin
                    CountryName[3] := CountryNameRec.Name;
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
        CountryNameRec: Record "Country/Region";
        CountryName: array[3] of Text[50];
        StateRec: Record State;
        StateCode: Code[10];
        CustomerRec: Record Customer;
        Customergst: Code[20];
        Customerpanno: code[10];
        TOTAL: Decimal;
        GrandTotal: Decimal;

}
