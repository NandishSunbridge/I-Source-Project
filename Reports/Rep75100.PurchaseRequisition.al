/// <summary>
/// Report SSDPurchase Requisition (ID 75100).
/// </summary>
report 75100 "Purchase Requisition"
{
    Caption = 'GST- Tax Invoice-Hor';
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    RDLCLayout = './Report Layouts/PurchaseRequisition.rdlc';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem(Copyloop; Integer)
        {
            DataItemTableView = sorting(Number);
            PrintOnlyIfDetail = true;
            dataitem("Purchase Requisition Header"; "Purchase Requisition Header")
            {
                RequestFilterFields = "Document No.";
                column(txt; txt)
                {
                }
                column(LocName; LocName)
                {
                }
                column(LocAddress; LocAddress)
                {
                }
                column(LocAddress2; LocAddress2 + '-' + Locpin)
                {
                }
                column(PRH_RequirementType; "Purchase Requisition Header"."Requirement Type")
                {
                }
                column(PRH_RequisitionType; "Purchase Requisition Header"."Requisition Type")
                {
                }
                column(lbl_ReportName; lbl_ReportNameLbl)
                {
                }
                column(PRH_Branch; "Purchase Requisition Header"."Shortcut Dimension 1 Code")
                {
                }
                column(PRH_Unit; "Purchase Requisition Header"."Shortcut Dimension 2 Code")
                {
                }
                column(PRH_LocationCode; "Purchase Requisition Header"."Location Code")
                {
                }
                column(PRH_DocumentNo; "Purchase Requisition Header"."Document No.")
                {
                }
                column(PRH_DocumentDate; "Purchase Requisition Header"."Document Date")
                {
                }
                column(IndentType; '(' + Format("Requisition Type") + ')')
                {
                }
                column(PRH_DeptCode; "Purchase Requisition Header"."Dept. Code")
                {
                }
                column(PRH_FAIdentificationNo; "Purchase Requisition Header"."FA Identification No")
                {
                }
                column(PRH_FixedAssetsCode; "Purchase Requisition Header"."Fixed Assets Code")
                {
                }
                column(PRH_Justification; "Purchase Requisition Header".Justification)
                {
                }
                column(PRH_Comments; "Purchase Requisition Header".Comments)
                {
                }
                column(PRH_TotalAmount; "Purchase Requisition Header"."Total Amount")
                {
                }
                column(PRH_DeptName; "Purchase Requisition Header"."Dept Name")
                {
                }
                column(PreparedBy; PreparedBy)
                {
                }
                column(ApprovedBy; ApprovedBy)
                {
                }
                dataitem("Purchase Requisition Line"; "Purchase Requisition Line")
                {
                    DataItemLink = "Document No." = field("Document No.");
                    DataItemTableView = sorting("Document Type", "Document No.", "Line No.");
                    column(SlNo; SlNo)
                    {
                    }
                    column(PRL_Type; "Purchase Requisition Line".Type)
                    {
                    }
                    column(PRL_ItemNo; "Purchase Requisition Line"."Item No.")
                    {
                    }
                    column(PRL_Description; "Purchase Requisition Line".Description)
                    {
                    }
                    column(PRL_PartDescription; "Purchase Requisition Line"."Part Description")
                    {
                    }
                    column(PRL_UOM; "Purchase Requisition Line"."Unit of Measure Code")
                    {
                    }
                    column(PRL_StockinHand; "Purchase Requisition Line"."Stock in Hand")
                    {
                    }
                    column(PRL_HSNSAC; "Purchase Requisition Line"."HSN/SAC")
                    {
                    }
                    column(PRL_GPPG; "Purchase Requisition Line".GPPG)
                    {
                    }
                    column(PRL_MonthlyConsumption; "Purchase Requisition Line"."Monthly Consumption")
                    {
                    }
                    column(PRL_LastQuantity; "Purchase Requisition Line"."Last Quantity")
                    {
                    }
                    column(PRL_LastRate; "Purchase Requisition Line"."Last Rate")
                    {
                    }
                    column(PRL_LastPurDate; "Purchase Requisition Line"."Last Pur Date")
                    {
                    }
                    column(prl_SuppliersCode; "Purchase Requisition Line"."Suppliers Code")
                    {
                    }
                    column(PRL_PurchaseRate; "Purchase Requisition Line"."Purchase Rate")
                    {
                    }
                    column(PRL_IndentQuqntity; "Purchase Requisition Line"."Indent Quantity")
                    {
                    }
                    column(PRL_RequiredDate; "Purchase Requisition Line"."Required Date")
                    {
                    }
                    trigger OnPreDataItem();
                    begin
                        SlNo := 0;
                        LastPurDate := 0D;
                        if ItemRec.Get("Purchase Requisition Line".Type) then
                            //LastPurDate := ItemRec."Last Pur. Date";
                            //
                            TotalLine := MAXLine - NbrItem - 1;
                    end;

                    trigger OnAfterGetRecord();
                    var
                    // StructureLineDetails: Record "Posted Str Order Line Details";//YS Report TAble Is Removed In Bc
                    begin
                        SlNo += 1;
                        //
                    end;

                }
                dataitem(BlankLines; Integer)
                {
                    DataItemTableView = sorting(Number);
                    PrintOnlyIfDetail = false;
                    column(Bline; BlankLine)
                    {
                    }
                    trigger OnPreDataItem();
                    begin
                        SetRange(Number, 1, TotalLine);
                    end;

                    trigger OnAfterGetRecord();
                    begin
                        SlNo += 1;
                    end;

                }
                trigger OnAfterGetRecord();
                begin
                    PreparedBy := '';
                    ApprovedBy := '';
                    //------------------------------------------------------------------------
                    if LocationRec.Get("Purchase Requisition Header"."Location Code") then begin
                        LocName := LocationRec.Name;
                        LocAddress := LocationRec.Address;
                        LocAddress2 := LocationRec."Address 2";
                        LocCity := LocationRec.City;
                        LocPhone := LocationRec."Phone No.";
                        "LocE-mail" := LocationRec."E-Mail";
                        Locpin := LocationRec."Post Code";
                    end;
                    //
                    /*    if StateRec.Get(LocationRec."State Code") then-----------------Nandish 30-10-23
                            LocState := StateRec.Description;
                        //
                        if StateRec.Get(CompanyInformationRec."State Code") then//YS Report
                            StateDescription := StateRec.Description;
                        //*/
                    PreparedBy := GetFullUserName("Purchase Requisition Header"."User ID");
                    ApprovedBy := GetFullUserName("Purchase Requisition Header"."Approver ID");
                end;

            }
            trigger OnPreDataItem();
            begin
                //----------------
                if NoOfLoops <= 0 then
                    NoOfLoops := 1;
                //
                txt := '';
                SetRange(Number, 1, NoOfLoops);
                Output := 0;
            end;

            trigger OnAfterGetRecord();
            begin
                if NoOfLoops = 1 then
                    Output := OutputNo
                else
                    if NoOfLoops > 1 then
                        Output += 1;

                //-----------------------------------------------------------------------------
                // IF Output = 1 THEN
                //	 txt:='1-ORIGINAL FOR RECIPIENT';
                // IF Output = 2 THEN
                //	 txt:='2-QUADRUPLICATE - EXTRA';
                // IF Output= 3 THEN
                //	 txt:='3-DUPLICATE FOR TRANSPORTER';
                // IF Output= 4 THEN
                //	 txt:='4-TRIPLICATE FOR SUPPLIER';
                //-----------------------------------------------------------
            end;

        }
    }

    requestpage
    {


        SaveValues = false;
        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';

                }
            }
        }

        actions
        {
        }
    }



    trigger OnPreReport()
    begin
        MAXLine := 1;
        ;
    end;

    var
        CompanyInformationRec: Record "Company Information";
        LocationRec: Record Location;
        //   StateRec: Record State;
        ItemRec: Record Item;
        NoOfLoops: Integer;
        OutputNo: Integer;
        SlNo: Integer;
        txt: Text[30];
        Output: Integer;
        BlankLine: Integer;
        NbrItem: Integer;
        TotalLine: Integer;
        MAXLine: Integer;
        StateDescription: Text[50];
        LocName: Text[100];
        LocAddress: Text[100];
        LocAddress2: Text[50];
        LocCity: Text[50];
        LocPhone: Text[30];
        "LocE-mail": Text[80];
        LocState: Text[50];
        Locpin: Code[20];
        LastPurDate: Date;
        lbl_ReportNameLbl: label 'PURCHASE REQUISITION SLIP';
        PreparedBy: Text[80];
        ApprovedBy: Text[80];

    local procedure GetFullUserName(InUser: Code[50]): Text[80]
    var
        varUsersetupRec: Record "User Setup";
    begin
        // if InUser <> '' then
        //     if varUsersetupRec.Get(InUser) then
        //         exit(varUsersetupRec."Full Name");
    end;

}