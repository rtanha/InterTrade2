report 50006 "Reminder INT"
{
    CaptionML = DEU = 'Mahnung',
                ENU = 'Reminder';
    DefaultLayout = RDLC;
    RDLCLayout = './Src\Layout\Reminder INT.rdlc';
    ApplicationArea = All;

    dataset
    {
        dataitem("Issued Reminder Header"; "Issued Reminder Header")
        {
            DataItemTableView = sorting("No.");
            RequestFilterFields = "No.";
            RequestFilterHeadingML = DEU = 'Mahnung',
                                     ENU = 'Reminder';
            column(No_IssuedReminderHeader; "No.")
            {
            }
            column(DueDateCaption; DueDateCaptionLbl)
            {
            }
            column(DocDateCaption; DocDateCaptionLbl)
            {
            }
            column(VATAmountCaption; VATAmountCaptionLbl)
            {
            }
            column(VATBaseCaption; VATBaseCaptionLbl)
            {
            }
            column(VATCaption; VATCaptionLbl)
            {
            }
            column(TotalCaption; TotalCaptionLbl)
            {
            }
            column(PageCaption; PageCaptionLbl)
            {
            }
            column(HomePageCaption; HomePageCaptionLbl)
            {
            }
            column(EMailCaption; EMailCaptionLbl)
            {
            }
            dataitem("Integer"; "Integer")
            {
                DataItemTableView = sorting(Number) where(Number = const(1));
                column(DueDate_IssuedReminderHdr; Format("Issued Reminder Header"."Due Date"))
                {
                }
                column(PostingDate_IssuedReminderHdr; Format("Issued Reminder Header"."Posting Date"))
                {
                }
                column(YourReference_IssuedReminderHdr; "Issued Reminder Header"."Your Reference")
                {
                }
                column(ReferenceText; ReferenceText)
                {
                }
                column(VATRegNo_IssuedReminderHdr; "Issued Reminder Header"."VAT Registration No.")
                {
                }
                column(VATNoText; VATNoText)
                {
                }
                column(DocDate_IssuedReminderHdr; Format("Issued Reminder Header"."Document Date"))
                {
                }
                column(CustNo_IssuedReminderHdr; "Issued Reminder Header"."Customer No.")
                {
                }
                column(CompanyInfoPicture; CompanyInfo.Picture)
                {
                }
                column(CompanyInfoBankAccountNo; CompanyInfo."Bank Account No.")
                {
                }
                column(CompanyInfoBankName; CompanyInfo."Bank Name")
                {
                }
                column(CompanyInfoGiroNo; CompanyInfo."Giro No.")
                {
                }
                column(CompanyInfoVATRegNo; CompanyInfo."VAT Registration No.")
                {
                }
                column(CompanyInfoHomePage; CompanyInfo."Home Page")
                {
                }
                column(CompanyInfo__Phone_No__; CompanyInfo."Phone No.")
                {
                }
                column(CompanyInfo__Fax_No__; CompanyInfo."Fax No.")
                {
                }
                column(CompanyInfo__VAT_Registration_No__; CompanyInfo."VAT Registration No.")
                {
                }
                column(CompanyInfo__Giro_No__; CompanyInfo."Giro No.")
                {
                }
                column(CompanyInfo__Bank_Name_; CompanyInfo."Bank Name")
                {
                }
                column(CompanyInfo__Bank_Account_No__; CompanyInfo."Bank Account No.")
                {
                }
                column(CompanyInfo__Phone_No__Caption; CompanyInfo__Phone_No__CaptionLbl)
                {
                }
                column(CompanyInfo__Fax_No__Caption; CompanyInfo__Fax_No__CaptionLbl)
                {
                }
                column(CompanyInfo__VAT_Registration_No__Caption; CompanyInfo__VAT_Registration_No__CaptionLbl)
                {
                }
                column(CompanyInfo__Giro_No__Caption; CompanyInfo__Giro_No__CaptionLbl)
                {
                }
                column(CompanyInfo__Bank_Name_Caption; CompanyInfo__Bank_Name_CaptionLbl)
                {
                }
                column(CompanyInfo__Bank_Account_No__Caption; CompanyInfo__Bank_Account_No__CaptionLbl)
                {
                }
                column(CompanyInfoEMail; CompanyInfo."E-Mail")
                {
                }
                column(Company_IBAN; CompanyInfo.IBAN)
                {
                }
                column(Company_Swift; CompanyInfo."SWIFT Code")
                {
                }
                column(Company_Email; CompanyInfo."E-Mail")
                {
                }
                column(Company_HomePage; CompanyInfo."Home Page")
                {
                }
                column(Company_USAccount; CompanyInfo."US Account (INT)")
                {
                    IncludeCaption = true;
                }
                column(Company_RegistrationNo; CompanyInfo."Registration No.")
                {
                }
                column(CustAddr8; CustAddr[8])
                {
                }
                column(CompanyInfoPhoneNo; CompanyInfo."Phone No.")
                {
                }
                column(CustAddr7; CustAddr[7])
                {
                }
                column(CustAddr6; CustAddr[6])
                {
                }
                column(CompanyAddr6; CompanyAddr[6])
                {
                }
                column(CustAddr5; CustAddr[5])
                {
                }
                column(CompanyAddr5; CompanyAddr[5])
                {
                }
                column(CustAddr4; CustAddr[4])
                {
                }
                column(CompanyAddr4; CompanyAddr[4])
                {
                }
                column(CustAddr3; CustAddr[3])
                {
                }
                column(CompanyAddr3; CompanyAddr[3])
                {
                }
                column(CustAddr2; CustAddr[2])
                {
                }
                column(CompanyAddr2; CompanyAddr[2])
                {
                }
                column(CustAddr1; CustAddr[1])
                {
                }
                column(CompanyAddr1; CompanyAddr[1])
                {
                }
                column(TextPage; TextPageLbl)
                {
                }
                column(PostingDateCaption; PostingDateCaptionLbl)
                {
                }
                column(ReminderHeaderNoCaption; ReminderHeaderNoCaptionLbl)
                {
                }
                column(BankAccountNoCaption; BankAccountNoCaptionLbl)
                {
                }
                column(BankNameCaption; BankNameCaptionLbl)
                {
                }
                column(GiroNoCaption; GiroNoCaptionLbl)
                {
                }
                column(VATRegNoCaption; VATRegNoCaptionLbl)
                {
                }
                column(PhoneNoCaption; PhoneNoCaptionLbl)
                {
                }
                column(ReminderCaption; ReminderCaptionLbl)
                {
                }
                column(CurrReportPageNo; StrSubstNo(Text002, CurrReport.PageNo))
                {
                }
                column(CustNo_IssuedReminderHdrCaption; "Issued Reminder Header".FieldCaption("Customer No."))
                {
                }
                column(WithHeader; WithHeader)
                {
                }
                dataitem(DimensionLoop; "Integer")
                {
                    DataItemLinkReference = "Issued Reminder Header";
                    DataItemTableView = sorting(Number) where(Number = filter(1 ..));
                    column(DimText; DimText)
                    {
                    }
                    column(Number_Integer; DimensionLoop.Number)
                    {
                    }
                    column(HeaderDimensionsCaption; HeaderDimensionsCaptionLbl)
                    {
                    }

                    trigger OnAfterGetRecord()
                    begin
                        if Number = 1 then begin
                            if not DimSetEntry.FindSet then
                                CurrReport.break;
                        end else
                            if not Continue then
                                CurrReport.break;

                        Clear(DimText);
                        Continue := false;
                        repeat
                            OldDimText := DimText;
                            if DimText = '' then
                                DimText := StrSubstNo('%1 - %2', DimSetEntry."Dimension Code", DimSetEntry."Dimension Value Code")
                            else
                                DimText :=
                                    StrSubstNo(
                                        '%1; %2 - %3', DimText,
                                        DimSetEntry."Dimension Code", DimSetEntry."Dimension Value Code");
                            if StrLen(DimText) > MaxStrLen(OldDimText) then begin
                                DimText := OldDimText;
                                Continue := true;
                                exit;
                            end;
                        until DimSetEntry.Next = 0;
                    end;

                    trigger OnPreDataItem()
                    begin
                        if not ShowInternalInfo then
                            CurrReport.break;
                    end;
                }
                dataitem("Issued Reminder Line"; "Issued Reminder Line")
                {
                    DataItemLink = "Reminder No." = field("No.");
                    DataItemLinkReference = "Issued Reminder Header";
                    DataItemTableView = sorting("Reminder No.", "Line No.");
                    column(RemainingAmt_IssuedReminderLine; "Remaining Amount")
                    {
                        AutoFormatExpression = "Issued Reminder Line".GetCurrencyCodeFromHeader;
                        AutoFormatType = 1;
                    }
                    column(StartLineNo; StartLineNo)
                    {
                    }
                    column(LineNo_IssuedReminderLine; "Line No.")
                    {
                    }
                    column(Description_IssuedReminderLine; Description)
                    {
                    }
                    column(Type; Format("Issued Reminder Line".Type, 0, 2))
                    {
                    }
                    column(DocDate_IssuedReminderLine; Format("Document Date"))
                    {
                    }
                    column(DocNo_IssuedReminderLine; "Document No.")
                    {
                    }
                    column(DueDate_IssuedReminderLine; Format("Due Date"))
                    {
                    }
                    column(OriginalAmt_IssuedReminderLine; "Original Amount")
                    {
                        AutoFormatExpression = "Issued Reminder Line".GetCurrencyCodeFromHeader;
                        AutoFormatType = 1;
                    }
                    column(DocType_IssuedReminderLine; "Document Type")
                    {
                    }
                    column(No_IssuedReminderLine; "No.")
                    {
                    }
                    column(ShowInternalInfo; ShowInternalInfo)
                    {
                    }
                    column(NNCInterestAmount; NNC_InterestAmount)
                    {
                    }
                    column(TotalText; TotalText)
                    {
                    }
                    column(NNCTotal; NNC_Total)
                    {
                    }
                    column(TotalInclVATText; TotalInclVATText)
                    {
                    }
                    column(NNCVATAmount; NNC_VATAmount)
                    {
                    }
                    column(NNCTotalInclVAT; NNC_TotalInclVAT)
                    {
                    }
                    column(TotalVATAmt; TotalVATAmount)
                    {
                    }
                    column(ReminderNo_IssuedReminderLine; "Reminder No.")
                    {
                    }
                    column(InterestAmountCaption; InterestAmountCaptionLbl)
                    {
                    }
                    column(RemainingAmt_IssuedReminderLineCaption; FieldCaption("Remaining Amount"))
                    {
                    }
                    column(DocNo_IssuedReminderLineCaption; FieldCaption("Document No."))
                    {
                    }
                    column(OriginalAmt_IssuedReminderLineCaption; FieldCaption("Original Amount"))
                    {
                    }
                    column(DocType_IssuedReminderLineCaption; FieldCaption("Document Type"))
                    {
                    }
                    column(Interest; Interest)
                    {
                    }

                    trigger OnAfterGetRecord()
                    begin
                        VATAmountLine.Init;
                        VATAmountLine."VAT Identifier" := "VAT Identifier";
                        VATAmountLine."VAT Calculation Type" := "VAT Calculation Type";
                        VATAmountLine."Tax Group Code" := "Tax Group Code";
                        VATAmountLine."VAT %" := "VAT %";
                        VATAmountLine."VAT Base" := Amount;
                        VATAmountLine."VAT Amount" := "VAT Amount";
                        VATAmountLine."Amount Including VAT" := Amount + "VAT Amount";
                        VATAmountLine."VAT Clause Code" := "VAT Clause Code";
                        VATAmountLine.InsertLine;

                        case Type of
                            Type::"G/L Account":
                                "Remaining Amount" := Amount;
                            Type::"Line Fee":
                                "Remaining Amount" := Amount;
                            Type::"Customer Ledger Entry":
                                ReminderInterestAmount := Amount;
                        end;

                        NNC_InterestAmountTotal += ReminderInterestAmount;
                        NNC_RemainingAmountTotal += "Remaining Amount";
                        NNC_VATAmountTotal += "VAT Amount";

                        NNC_InterestAmount := (NNC_InterestAmountTotal + NNC_VATAmountTotal + "Issued Reminder Header"."Additional Fee" -
                                                                      AddFeeInclVAT + "Issued Reminder Header"."Add. Fee per Line" - AddFeePerLineInclVAT) /
                            (VATInterest / 100 + 1);
                        NNC_Total := NNC_RemainingAmountTotal + NNC_InterestAmountTotal;
                        NNC_VATAmount := NNC_VATAmountTotal;
                        NNC_TotalInclVAT := NNC_RemainingAmountTotal + NNC_InterestAmountTotal + NNC_VATAmountTotal;
                    end;

                    trigger OnPreDataItem()
                    begin
                        if Find('-') then begin
                            StartLineNo := 0;
                            repeat
                                Continue := Type = Type::" ";
                                StartLineNo := "Line No.";
                            until (Next = 0) or not Continue;
                        end;

                        if FindLast then begin
                            EndLineNo := "Line No." + 1;
                            repeat
                                // gbedv EXT -------------------------------------------------- BEGIN
                                //    Continue := NOT ShowNotDueAmounts AND ("No. of Reminders" = 0) AND (Type = Type::"Customer Ledger Entry") OR (Type = Type::" ");
                                Continue :=
                                    not ShowNotDueAmounts and
                                    ("No. of Reminders" = 0) and ((Type = Type::"Customer Ledger Entry") or (Type = Type::"Line Fee")) or (Type = Type::" ");
                                // gbedv EXT -------------------------------------------------- END

                                if Continue then
                                    EndLineNo := "Line No.";
                            until (Next(-1) = 0) or not Continue;
                        end;

                        VATAmountLine.DeleteAll;
                        SetFilter("Line No.", '<%1', EndLineNo);
                        CurrReport.CreateTotals("Remaining Amount", "VAT Amount", ReminderInterestAmount);
                    end;
                }
                dataitem(IssuedReminderLine2; "Issued Reminder Line")
                {
                    DataItemLink = "Reminder No." = field("No.");
                    DataItemLinkReference = "Issued Reminder Header";
                    DataItemTableView = sorting("Reminder No.", "Line No.");
                    column(Description_IssuedReminderLine2; Description)
                    {
                    }
                    column(LineNo_IssuedReminderLine2; "Line No.")
                    {
                    }

                    trigger OnPreDataItem()
                    begin
                        SetFilter("Line No.", '>=%1', EndLineNo);
                        if not ShowNotDueAmounts then begin
                            SetFilter(Type, '<>%1', Type::" ");
                            if FindFirst then
                                if "Line No." > EndLineNo then begin
                                    SetRange(Type);
                                    SetRange("Line No.", EndLineNo, "Line No." - 1); // find "Open Entries Not Due" line
                                    if FindLast then
                                        SetRange("Line No.", EndLineNo, "Line No." - 1);
                                end;
                            SetRange(Type);
                        end;
                    end;
                }
                dataitem(VATCounter; "Integer")
                {
                    DataItemTableView = sorting(Number);
                    column(VATAmtLineAmtInclVAT; VATAmountLine."Amount Including VAT")
                    {
                        AutoFormatExpression = "Issued Reminder Line".GetCurrencyCodeFromHeader;
                        AutoFormatType = 1;
                    }
                    column(VALVATAmount; VALVATAmount)
                    {
                        AutoFormatExpression = "Issued Reminder Line".GetCurrencyCodeFromHeader;
                        AutoFormatType = 1;
                    }
                    column(VALVATBase; VALVATBase)
                    {
                        AutoFormatExpression = "Issued Reminder Line".GetCurrencyCodeFromHeader;
                        AutoFormatType = 1;
                    }
                    column(VALVATBaseVALVATAmount; VALVATBase + VALVATAmount)
                    {
                        AutoFormatExpression = "Issued Reminder Line".GetCurrencyCodeFromHeader;
                        AutoFormatType = 1;
                    }
                    column(VATAmountLineVAT; VATAmountLine."VAT %")
                    {
                    }
                    column(AmountIncludingVATCaption; AmountIncludingVATCaptionLbl)
                    {
                    }
                    column(VATAmtSpecificationCaption; VATAmtSpecificationCaptionLbl)
                    {
                    }
                    column(VALVATBaseCaption; VALVATBaseCaptionLbl)
                    {
                    }

                    trigger OnAfterGetRecord()
                    begin
                        VATAmountLine.GetLine(Number);
                        VALVATBase := VATAmountLine."Amount Including VAT" / (1 + VATAmountLine."VAT %" / 100);
                        VALVATAmount := VATAmountLine."Amount Including VAT" - VALVATBase;
                    end;

                    trigger OnPreDataItem()
                    begin
                        if VATAmountLine.GetTotalVATAmount = 0 then
                            CurrReport.break;

                        SetRange(Number, 1, VATAmountLine.Count);

                        VALVATBase := 0;
                        VALVATAmount := 0;
                    end;
                }
                dataitem(VATClauseEntryCounter; "Integer")
                {
                    DataItemTableView = sorting(Number);
                    column(VATClauseVATIdentifier; VATAmountLine."VAT Identifier")
                    {
                    }
                    column(VATClauseCode; VATAmountLine."VAT Clause Code")
                    {
                    }
                    column(VATClauseDescription; VATClause.Description)
                    {
                    }
                    column(VATClauseDescription2; VATClause."Description 2")
                    {
                    }
                    column(VATClauseAmount; VATAmountLine."VAT Amount")
                    {
                        AutoFormatExpression = "Issued Reminder Header"."Currency Code";
                        AutoFormatType = 1;
                    }
                    column(VATClausesCaption; VATClausesCap)
                    {
                    }
                    column(VATClauseVATIdentifierCaption; VATIdentifierCaptionLbl)
                    {
                    }
                    column(VATClauseVATAmtCaption; VATAmountCaptionLbl)
                    {
                    }

                    trigger OnAfterGetRecord()
                    begin
                        VATAmountLine.GetLine(Number);
                        if not VATClause.Get(VATAmountLine."VAT Clause Code") then
                            CurrReport.Skip;
                        VATClause.TranslateDescription("Issued Reminder Header"."Language Code");
                    end;

                    trigger OnPreDataItem()
                    begin
                        Clear(VATClause);
                        SetRange(Number, 1, VATAmountLine.Count);
                        CurrReport.CreateTotals(VATAmountLine."VAT Amount");
                    end;
                }
                dataitem(VATCounterLCY; "Integer")
                {
                    DataItemTableView = sorting(Number);
                    column(VALExchRate; VALExchRate)
                    {
                    }
                    column(VALSpecLCYHeader; VALSpecLCYHeader)
                    {
                    }
                    column(VALVATAmountLCY; VALVATAmountLCY)
                    {
                        AutoFormatType = 1;
                    }
                    column(VALVATBaseLCY; VALVATBaseLCY)
                    {
                        AutoFormatType = 1;
                    }
                    column(VALVATBaseLCYCaption; VALVATBaseLCYCaptionLbl)
                    {
                    }

                    trigger OnAfterGetRecord()
                    begin
                        VATAmountLine.GetLine(Number);

                        VALVATBaseLCY := Round(VATAmountLine."Amount Including VAT" / (1 + VATAmountLine."VAT %" / 100) / CurrFactor);
                        VALVATAmountLCY := Round(VATAmountLine."Amount Including VAT" / CurrFactor - VALVATBaseLCY);
                    end;

                    trigger OnPreDataItem()
                    begin
                        if (not GLSetup."Print VAT specification in LCY") or
                              ("Issued Reminder Header"."Currency Code" = '') or
                              (VATAmountLine.GetTotalVATAmount = 0) then
                            CurrReport.break;

                        SetRange(Number, 1, VATAmountLine.Count);

                        VALVATBaseLCY := 0;
                        VALVATAmountLCY := 0;

                        if GLSetup."LCY Code" = '' then
                            VALSpecLCYHeader := Text011 + Text012
                        else
                            VALSpecLCYHeader := Text011 + Format(GLSetup."LCY Code");

                        CurrExchRate.FindCurrency("Issued Reminder Header"."Posting Date", "Issued Reminder Header"."Currency Code", 1);
                        CustEntry.SetRange("Customer No.", "Issued Reminder Header"."Customer No.");
                        CustEntry.SetRange("Document Type", CustEntry."Document Type"::Reminder);
                        CustEntry.SetRange("Document No.", "Issued Reminder Header"."No.");
                        if CustEntry.FindFirst then begin
                            CustEntry.CalcFields("Amount (LCY)", Amount);
                            CurrFactor := 1 / (CustEntry."Amount (LCY)" / CustEntry.Amount);
                            VALExchRate := StrSubstNo(Text013, Round(1 / CurrFactor * 100, 0.000001), CurrExchRate."Exchange Rate Amount");
                        end else begin
                            CurrFactor := CurrExchRate.ExchangeRate("Issued Reminder Header"."Posting Date", "Issued Reminder Header"."Currency Code");
                            VALExchRate := StrSubstNo(Text013, CurrExchRate."Relational Exch. Rate Amount", CurrExchRate."Exchange Rate Amount");
                        end;
                    end;
                }
            }

            trigger OnAfterGetRecord()
            var
                GLAcc: Record "G/L Account";
                CustPostingGroup: Record "Customer Posting Group";
                VATPostingSetup: Record "VAT Posting Setup";
            begin
                // CurrReport.Language := Language. GetLanguageID("Language Code");
                CurrReport.Language := LanguageMgt.GetLanguageIdOrDefault("Language Code");
                CurrReport.FormatRegion := LanguageMgt.GetFormatRegionOrDefault("Format Region");

                DimSetEntry.SetRange("Dimension Set ID", "Dimension Set ID");

                FormatAddrCodeunit.IssuedReminder(CustAddr, "Issued Reminder Header");
                if "Your Reference" = '' then
                    ReferenceText := ''
                else
                    ReferenceText := FieldCaption("Your Reference");
                if "VAT Registration No." = '' then
                    VATNoText := ''
                else
                    VATNoText := FieldCaption("VAT Registration No.");
                if "Currency Code" = '' then begin
                    GLSetup.TestField("LCY Code");
                    TotalText := StrSubstNo(Text000, GLSetup."LCY Code");
                    TotalInclVATText := StrSubstNo(Text001, GLSetup."LCY Code");
                end else begin
                    TotalText := StrSubstNo(Text000, "Currency Code");
                    TotalInclVATText := StrSubstNo(Text001, "Currency Code");
                end;
                CurrReport.PageNo := 1;
                if not CurrReport.Preview then begin
                    if LogInteraction then
                        SegManagement.LogDocument(
                            8, "No.", 0, 0, Database::Customer, "Customer No.", '', '', "Posting Description", '');
                    IncrNoPrinted;
                end;
                CalcFields("Additional Fee");
                CustPostingGroup.Get("Customer Posting Group");
                if GLAcc.Get(CustPostingGroup."Additional Fee Account") then begin
                    VATPostingSetup.Get("VAT Bus. Posting Group", GLAcc."VAT Prod. Posting Group");
                    AddFeeInclVAT := "Additional Fee" * (1 + VATPostingSetup."VAT %" / 100);
                end else
                    AddFeeInclVAT := "Additional Fee";

                CalcFields("Add. Fee per Line");
                AddFeePerLineInclVAT := "Add. Fee per Line" + CalculateLineFeeVATAmount;

                CalcFields("Interest Amount", "VAT Amount");
                if ("Interest Amount" <> 0) and ("VAT Amount" <> 0) then begin
                    GLAcc.Get(CustPostingGroup."Interest Account");
                    VATPostingSetup.Get("VAT Bus. Posting Group", GLAcc."VAT Prod. Posting Group");
                    VATInterest := VATPostingSetup."VAT %";
                    Interest :=
                        ("Interest Amount" +
                          "VAT Amount" + "Additional Fee" - AddFeeInclVAT + "Add. Fee per Line" - AddFeePerLineInclVAT) / (VATInterest / 100 + 1);
                end else begin
                    Interest := "Interest Amount";
                    VATInterest := 0;
                end;

                TotalVATAmount := "VAT Amount";
                NNC_InterestAmountTotal := 0;
                NNC_RemainingAmountTotal := 0;
                NNC_VATAmountTotal := 0;
                NNC_InterestAmount := 0;
                NNC_Total := 0;
                NNC_VATAmount := 0;
                NNC_TotalInclVAT := 0;
            end;

            trigger OnPreDataItem()
            begin
                //CompanyInfo.GET;
                FormatAddrCodeunit.Company(CompanyAddr, CompanyInfo);
            end;
        }
    }

    requestpage
    {

        SaveValues = true;

        layout
        {
            area(content)
            {
                group(Options)
                {
                    CaptionML = DEU = 'Optionen',
                                ENU = 'Options';
                    field(ShowInternalInfo; ShowInternalInfo)
                    {
                        CaptionML = DEU = 'Interne Informationen anzeigen',
                                    ENU = 'Show Internal Information';
                        ApplicationArea = All;
                    }
                    field(LogInteraction; LogInteraction)
                    {
                        CaptionML = DEU = 'Aktivität protokollieren',
                                    ENU = 'Log Interaction';
                        Enabled = LogInteractionEnable;
                        ApplicationArea = All;
                    }
                    field(ShowNotDueAmounts; ShowNotDueAmounts)
                    {
                        CaptionML = DEU = 'Nicht fällige Beträge anzeigen',
                                    ENU = 'Show Not Due Amounts';
                        ApplicationArea = All;
                    }
                    // field(WithHeader; WithHeader)
                    // {
                    //     ApplicationArea = All;
                    //     Caption = 'Mit Logo';
                    // }
                }
            }
        }

        actions
        {
        }

        trigger OnInit()
        begin
            LogInteractionEnable := true;
        end;

        // trigger OnOpenPage()
        // begin
        //     WithHeader := true;

        // end;

    }


    trigger OnInitReport()
    begin
        GLSetup.Get;
        CompanyInfo.Get;
        SalesSetup.Get;
        CompanyInfo.CalcFields(Picture);
        WithHeader := true;
    end;

    var
        Text000: TextConst DEU = 'Total %1', ENU = 'Total %1';
        Text001: TextConst DEU = 'Total %1 inkl. MwSt.', ENU = 'Total %1 Incl. VAT';
        Text002: TextConst DEU = 'Seite %1', ENU = 'Page %1';
        GLSetup: Record "General Ledger Setup";
        CompanyInfo: Record "Company Information";
        CompanyInfo1: Record "Company Information";
        CompanyInfo2: Record "Company Information";
        CompanyInfo3: Record "Company Information";
        SalesSetup: Record "Sales & Receivables Setup";
        VATAmountLine: Record "VAT Amount Line" temporary;
        VATClause: Record "VAT Clause";
        DimSetEntry: Record "Dimension Set Entry";
        LanguageMgt: Codeunit language;
        CurrExchRate: Record "Currency Exchange Rate";
        FormatAddrCodeunit: Codeunit "Format Address";
        SegManagement: Codeunit SegManagement;
        CustAddr: array[8] of Text[50];
        CompanyAddr: array[8] of Text[50];
        VATNoText: Text[30];
        ReferenceText: Text[35];
        TotalText: Text[50];
        TotalInclVATText: Text[50];
        ReminderInterestAmount: Decimal;
        EndLineNo: Integer;
        Continue: Boolean;
        DimText: Text[120];
        OldDimText: Text[75];
        ShowInternalInfo: Boolean;
        LogInteraction: Boolean;
        VALVATBaseLCY: Decimal;
        VALVATAmountLCY: Decimal;
        VALSpecLCYHeader: Text[80];
        VALExchRate: Text[50];
        CurrFactor: Decimal;
        Text011: TextConst DEU = 'MwSt.-Betrag Spezifikation in ', ENU = 'VAT Amount Specification in ';
        Text012: TextConst DEU = 'Landeswährung', ENU = 'Local Currency';
        Text013: TextConst DEU = 'Wechselkurs: %1/%2', ENU = 'Exchange rate: %1/%2';
        CustEntry: Record "Cust. Ledger Entry";
        AddFeeInclVAT: Decimal;
        AddFeePerLineInclVAT: Decimal;
        TotalVATAmount: Decimal;
        VATInterest: Decimal;
        VALVATBase: Decimal;
        VALVATAmount: Decimal;
        Interest: Decimal;
        NNC_InterestAmount: Decimal;
        NNC_Total: Decimal;
        NNC_VATAmount: Decimal;
        NNC_TotalInclVAT: Decimal;
        NNC_InterestAmountTotal: Decimal;
        NNC_RemainingAmountTotal: Decimal;
        NNC_VATAmountTotal: Decimal;
        StartLineNo: Integer;
        [InDataSet]
        LogInteractionEnable: Boolean;
        ShowNotDueAmounts: Boolean;
        TextPageLbl: TextConst DEU = 'Seite', ENU = 'Page';
        PostingDateCaptionLbl: TextConst DEU = 'Buchungsdatum', ENU = 'Posting Date';
        ReminderHeaderNoCaptionLbl: TextConst DEU = 'Mahnungsnr.', ENU = 'Reminder No.';
        BankAccountNoCaptionLbl: TextConst DEU = 'Kontonr.', ENU = 'Account No.';
        BankNameCaptionLbl: TextConst DEU = 'Bankkonto', ENU = 'Bank';
        GiroNoCaptionLbl: TextConst DEU = 'Postgirokontonr.', ENU = 'Giro No.';
        VATRegNoCaptionLbl: TextConst DEU = 'USt-IdNr.', ENU = 'VAT Registration No.';
        PhoneNoCaptionLbl: TextConst DEU = 'Telefonnr.', ENU = 'Phone No.';
        ReminderCaptionLbl: TextConst DEU = 'Zahlungserinnerung', ENU = 'Reminder';
        HeaderDimensionsCaptionLbl: TextConst DEU = 'Kopfdimensionen', ENU = 'Header Dimensions';
        InterestAmountCaptionLbl: TextConst DEU = 'Zinsbetrag', ENU = 'Interest Amount';
        AmountIncludingVATCaptionLbl: TextConst DEU = 'Betrag inkl. MwSt.', ENU = 'Amount Including VAT';
        VATAmtSpecificationCaptionLbl: TextConst DEU = 'MwSt.-Betrag - Spezifikation', ENU = 'VAT Amount Specification';
        VATClausesCap: TextConst DEU = 'MwSt.-Klausel', ENU = 'VAT Clause';
        VATIdentifierCaptionLbl: TextConst DEU = 'MwSt.-Kennzeichen', ENU = 'VAT Identifier';
        VALVATBaseCaptionLbl: TextConst DEU = 'Fortsetzung', ENU = 'Continued';
        VALVATBaseLCYCaptionLbl: TextConst DEU = 'Fortsetzung', ENU = 'Continued';
        DueDateCaptionLbl: TextConst DEU = 'Fälligkeitsdatum', ENU = 'Due Date';
        DocDateCaptionLbl: TextConst DEU = 'Belegdatum', ENU = 'Document Date';
        VATAmountCaptionLbl: TextConst DEU = 'MwSt.-Betrag', ENU = 'VAT Amount';
        VATBaseCaptionLbl: TextConst DEU = 'MwSt.-Bemessungsgrundlage', ENU = 'VAT Base';
        VATCaptionLbl: TextConst DEU = 'MwSt. %', ENU = 'VAT %';
        TotalCaptionLbl: TextConst DEU = 'Gesamt', ENU = 'Total';
        PageCaptionLbl: TextConst DEU = 'Seite', ENU = 'Page';
        HomePageCaptionLbl: TextConst DEU = 'Homepage', ENU = 'Home Page';
        EMailCaptionLbl: TextConst DEU = 'E-Mail', ENU = 'E-Mail';
        "+++ OPplus +++": Integer;
        Text5157805: TextConst DEU = 'Zwischensumme Debitor', ENU = 'Subtotal Customer';
        SubTotalText: Text[250];
        Text5157807: TextConst DEU = 'Zwischensumme Kreditor', ENU = 'Subtotal Vendor';
        CompanyInfo__Phone_No__CaptionLbl: TextConst DEU = 'Telefonnr.', ENU = 'Phone No.';
        CompanyInfo__Fax_No__CaptionLbl: TextConst DEU = 'Faxnr.', ENU = 'Fax No.';
        CompanyInfo__VAT_Registration_No__CaptionLbl: TextConst DEU = 'USt-IdNr.', ENU = 'VAT Reg. No.';
        CompanyInfo__Giro_No__CaptionLbl: TextConst DEU = 'Postgirokontonr.', ENU = 'Giro No.';
        CompanyInfo__Bank_Name_CaptionLbl: TextConst DEU = 'Bankkonto', ENU = 'Bank';
        CompanyInfo__Bank_Account_No__CaptionLbl: TextConst DEU = 'Steuernummer:', ENU = 'Registration No.:';
        WithHeader: Boolean;


}

