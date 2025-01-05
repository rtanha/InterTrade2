report 50018 "VK-Preisliste Intertrade"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Src\Layout\VK-Preisliste Intertrade.rdlc';
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem(Item; Item)
        {
            column(CompanyInfo1Picture; companyInfo.Picture)
            {
            }
            column(CompanyAddr1; CompanyAddr[1])
            {
            }
            column(CompanyAddr2; CompanyAddr[2])
            {
            }
            column(CompanyAddr3; CompanyAddr[3])
            {
            }
            column(CompanyAddr4; CompanyAddr[4])
            {
            }
            column(CompanyAddr5; CompanyAddr[5])
            {
            }
            column(CompanyAddr6; CompanyAddr[6])
            {
            }
            column(CompanyAddr7; CompanyAddr[7])
            {
            }
            column(CompanyAddr8; CompanyAddr[8])
            {
            }
            column(CompanyInfoPhoneNo; companyInfo."Phone No.")
            {
            }
            column(CompanyInfo_Fax_No_; companyInfo."Fax No.")
            {
            }
            column(CompanyInfoHomePage; companyInfo."Home Page")
            {
            }
            column(CompanyInfoEMail; companyInfo."E-Mail")
            {
            }
            column(CompanyInfoVATRegNo; companyInfo."VAT Registration No.")
            {
            }
            column(CompanyInfoBankName; companyInfo."Bank Name")
            {
            }
            column(Company_IBAN; companyInfo.IBAN)
            {
            }
            column(Company_Swift; companyInfo."SWIFT Code")
            {
            }
            column(Company_USAccount; companyInfo."US Account (INT)")
            {
                IncludeCaption = true;
            }
            column(CompanyInfoRegNo; companyInfo.GetRegistrationNumber)
            {
            }
            column(RegNoCaption; companyInfo.GetRegistrationNumberLbl)
            {
            }
            column(CompanyInfo__Phone_No__Caption; FonText)
            {
            }
            column(CompanyInfo__Fax_No__Caption; FaxText)
            {
            }
            column(VATRegNoCaption; VATRegNoCaptionLbl)
            {
            }
            column(ItemNoCaption; ItemNoCaptionLbl)
            {
            }
            column(ItemDescCaption; ItemDescCaptionLbl)
            {
            }
            column(UnitOfMeasureCaption; UnitOfMeasureCaptionLbl)
            {
            }
            column(MinimumQuantityCaption; MinimumQuantityCaptionLbl)
            {
            }
            column(VATTextCaption; VATTextCaptionLbl)
            {
            }
            column(SalesType; StrSubstNo(PriceGroup, SalesDesc))
            {
            }
            column(SalesCode; SalesCode)
            {
            }
            column(SalesDesc; SalesDesc)
            {
            }
            column(UnitPriceFieldCaption; SalesPrice.FieldCaption("Unit Price") + CurrencyText)
            {
            }
            column(LineDiscountFieldCaption; SalesLineDisc.FieldCaption("Line Discount %") + CurrencyText)
            {
            }
            column(No_Item; "No.")
            {
            }
            column(Description2FieldCaption; FieldCaption("Description 2"))
            {
            }
            column(Description2; "Description 2")
            {
            }
            column(Lieferbedingung; Lieferbedingung)
            {
            }
            column(CurrencyText2; CurrencyText2)
            {
            }
            column(OhnePreis; OhnePreis)
            {
            }
            column(PriceValidFrom; StrSubstNo(PriceValid, DateReq))
            {
            }
            dataitem(SalesPrices; "Integer")
            {
                DataItemTableView = SORTING(Number) WHERE(Number = FILTER(1 ..));
                column(VATText_SalesPrices; VATText)
                {
                }
                column(SalesPriceUnitPrice; SalesPrice."Unit Price")
                {
                    AutoFormatExpression = Currency.Code;
                    AutoFormatType = 2;
                }
                column(UOM_SalesPrices; UnitofMeasureRec.Description)
                {
                }
                column(ItemNo_SalesPrices; ItemNo)
                {
                }
                column(ItemDesc_SalesPrices; ItemDesc)
                {

                }
                column(MinimumQty_SalesPrices; SalesPrice."Minimum Quantity")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    PrintSalesPrice(false);
                end;

                trigger OnPreDataItem()
                begin
                    PreparePrintSalesPrice(false);
                end;
            }
            dataitem(SalesLineDiscs; "Integer")
            {
                DataItemTableView = SORTING(Number) WHERE(Number = FILTER(1 ..));
                column(LineDisc_SalesLineDisc; SalesLineDisc."Line Discount %")
                {
                    AutoFormatExpression = Currency.Code;
                    AutoFormatType = 2;
                }
                column(MinimumQty_SalesLineDiscs; SalesLineDisc."Minimum Quantity")
                {
                }
                column(UOM_SalesLineDiscs; UnitOfMeasure)
                {
                }
                column(ItemDesc_SalesLineDiscs; ItemDesc)
                {
                }
                column(ItemNo_SalesLineDiscs; ItemNo)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    PrintSalesDisc;
                end;

                trigger OnPreDataItem()
                begin
                    PreparePrintSalesDisc(false);
                end;
            }

            trigger OnAfterGetRecord()
            begin

                SalesPriceCalcMgt.FindSalesPrice(
                  SalesPrice, CustNo, ContNo, CustPriceGrCode, CampaignNo, "No.", '', '', Currency.Code, DateReq, false);

                SalesPriceCalcMgt.FindSalesLineDisc(
                  SalesLineDisc, CustNo, ContNo, CustDiscGrCode, CampaignNo, "No.",
                  "Item Disc. Group", '', '', Currency.Code, DateReq, false);
                if SalesType = SalesType::"Customer Price Group" then begin
                    SalesPrice.SetRange(SalesPrice."Sales Type", SalesPrice."Sales Type"::"Customer Price Group");
                    SalesPrice.SetRange(SalesPrice."Item No.", Item."No.");
                    if not SalesPrice.FindFirst then
                        CurrReport.Skip;
                end;
                if ItemTranslation.Get("No.", '', Language.Code) then begin
                    Description := ItemTranslation.Description;
                    "Description 2" := ItemTranslation."Description 2";
                end;
                ItemNo := "No.";
                ItemDesc := Description;
            end;

            trigger OnPreDataItem()
            begin
                CustNo := '';
                ContNo := '';
                CustPriceGrCode := '';
                CustDiscGrCode := '';
                SalesDesc := '';

                case SalesType of
                    SalesType::Customer:
                        begin
                            Cust.Get(SalesCode);
                            CustNo := Cust."No.";
                            CustPriceGrCode := Cust."Customer Price Group";
                            CustDiscGrCode := Cust."Customer Disc. Group";
                            SalesDesc := Cust.Name;
                        end;
                    SalesType::"Customer Price Group":
                        begin
                            CustPriceGr.Get(SalesCode);
                            CustPriceGrCode := SalesCode;
                            SalesDesc := CustPriceGr.Description;
                        end;
                    SalesType::Campaign:
                        begin
                            Campaign.Get(SalesCode);
                            CampaignNo := SalesCode;
                            SalesDesc := Campaign.Description;
                        end;
                end;

                ContBusRel.SetRange("Link to Table", ContBusRel."Link to Table"::Customer);
                ContBusRel.SetRange("No.", CustNo);
                if ContBusRel.FindFirst then
                    ContNo := ContBusRel."Contact No.";
                GLSetup.Get;
                if Currency.Code = '' then
                    CurrencyText2 := StrSubstNo(CURRTEXT, GLSetup."Currency Code For EURO")
                else
                    CurrencyText2 := StrSubstNo(CURRTEXT, Currency.Code);
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
                group(Optionen)
                {
                    Caption = 'Options';
                    field(Date; DateReq)
                    {
                        Caption = 'Date';
                        ApplicationArea = All;
                    }
                    field(SalesType; SalesType)
                    {
                        Caption = 'Sales Type';
                        OptionCaption = 'Customer,Customer Price Group,All Customers,Campaign';
                        ApplicationArea = All;

                        trigger OnValidate()
                        begin
                            SalesCodeCtrlEnable := SalesType <> SalesType::"All Customers";
                            SalesCode := '';
                        end;
                    }
                    field(SalesCodeCtrl; SalesCode)
                    {
                        Caption = 'Sales Code';
                        Enabled = SalesCodeCtrlEnable;
                        ApplicationArea = All;

                        trigger OnLookup(var Text: Text): Boolean
                        var
                            CustList: Page "Customer List";
                            CustPriceGrList: Page "Customer Price Groups";
                            CampaignList: Page "Campaign List";
                        begin
                            case SalesType of
                                SalesType::Customer:
                                    begin
                                        CustList.LookupMode := true;
                                        CustList.SetRecord(Cust);
                                        if CustList.RunModal = ACTION::LookupOK then begin
                                            CustList.GetRecord(Cust);
                                            SalesCode := Cust."No.";
                                        end;
                                    end;
                                SalesType::"Customer Price Group":
                                    begin
                                        CustPriceGrList.LookupMode := true;
                                        CustPriceGrList.SetRecord(CustPriceGr);
                                        if CustPriceGrList.RunModal = ACTION::LookupOK then begin
                                            CustPriceGrList.GetRecord(CustPriceGr);
                                            SalesCode := CustPriceGr.Code;
                                        end;
                                    end;
                                SalesType::Campaign:
                                    begin
                                        CampaignList.LookupMode := true;
                                        CampaignList.SetRecord(Campaign);
                                        if CampaignList.RunModal = ACTION::LookupOK then begin
                                            CampaignList.GetRecord(Campaign);
                                            SalesCode := Campaign."No.";
                                        end;
                                    end;
                            end;
                        end;

                        trigger OnValidate()
                        begin
                            ValidateSalesCode;
                        end;
                    }
                    field(OhnePreis; OhnePreis)
                    {
                        Caption = 'Print without Price';
                        ApplicationArea = All;
                    }
                    field(Sprache; Sprache)
                    {
                        Caption = 'Language';
                        TableRelation = Language;
                        ApplicationArea = All;
                    }
                    field("Currency.Code"; Currency.Code)
                    {
                        Caption = 'Currency Code';
                        TableRelation = Currency;
                        ApplicationArea = All;
                    }
                    field(Lieferbedingung; Lieferbedingung)
                    {
                        Caption = 'Shipment Method';
                        ApplicationArea = All;
                    }
                }
            }
        }

        actions
        {
        }

        trigger OnInit()
        begin
            SalesCodeCtrlEnable := SalesType <> SalesType::"All Customers";
        end;
    }

    labels
    {
    }

    trigger OnPreReport()
    begin
        companyInfo.Get;
        companyInfo.CalcFields(Picture);
        FormatAddr.Company(CompanyAddr, companyInfo);
        if Sprache <> '' then begin
            Language.Get(Sprache);
            CurrReport.Language := Language."Windows Language ID";
        end;
    end;

    var
        companyInfo: Record "Company Information";
        FonText: Label 'Telefon:';
        FaxText: Label 'Fax:';
        VATRegNoCaptionLbl: Label 'VAT Reg. No.';
        DocumentNo: Label 'No. %1';
        PageText: Label 'Page';
        CompanyAddr: array[8] of Text[50];
        FormatAddr: Codeunit "Format Address";
        Text000: Label 'Incl.';
        Text001: Label 'Excl.';
        Text002: Label 'Page %1';
        Text003: Label 'As of %1';
        Text004: Label 'You must specify a sales code, if the sales type is different from All Customers.';
        PriceListCaptionLbl: Label 'Price List';
        CompanyInfoPhoneNoCaptionLbl: Label 'Phone No.';
        CompanyInfoFaxNoCaptionLbl: Label 'Fax No.';
        CompanyInfoVATRegNoCaptionLbl: Label 'VAT Reg. No.';
        CompanyInfoGiroNoCaptionLbl: Label 'Giro No.';
        CompanyInfoBankNameCaptionLbl: Label 'Bank';
        CompanyInfoBankAccNoCaptionLbl: Label 'Account No.';
        ItemNoCaptionLbl: Label 'Item No.';
        ItemDescCaptionLbl: Label 'Description';
        UnitOfMeasureCaptionLbl: Label 'Unit of Measure';
        MinimumQuantityCaptionLbl: Label 'Minimum Quantity';
        VATTextCaptionLbl: Label 'VAT';
        PricesInCurrency: Boolean;
        Currency: Record Currency;
        CurrencyText: Text[30];
        CurrencyFactor: Decimal;
        GLSetup: Record "General Ledger Setup";
        CurrExchRate: Record "Currency Exchange Rate";
        DateReq: Date;
        SalesPrice: Record "Sales Price" temporary;
        SalesType: Option Customer,"Customer Price Group","All Customers",Campaign;
        SalesCode: Code[20];
        IsFirstSalesPrice: Boolean;
        IsFirstSalesLineDisc: Boolean;
        VATText: Text[20];
        UnitOfMeasure: Code[10];
        SalesLineDisc: Record "Sales Line Discount" temporary;
        Cust: Record Customer;
        CustPriceGr: Record "Customer Price Group";
        Campaign: Record Campaign;
        SalesDesc: Text[50];
        ItemNo: Code[20];
        ItemDesc: Text[50];
        [InDataSet]
        SalesCodeCtrlEnable: Boolean;
        CustNo: Code[20];
        ContNo: Code[20];
        CustPriceGrCode: Code[10];
        CustDiscGrCode: Code[20];
        CampaignNo: Code[20];
        ContBusRel: Record "Contact Business Relation";
        SalesPriceCalcMgt: Codeunit "Sales Price Calc. Mgt.";
        Lieferbedingung: Text;
        CurrencyText2: Text;
        CURRTEXT: Label 'All Price are excl. vat in %1.';
        OhnePreis: Boolean;
        PriceValid: Label 'Prices valid as from %1';
        Language: Record Language;
        ItemTranslation: Record "Item Translation";
        Sprache: Code[10];
        UnitofMeasureRec: Record "Unit of Measure";
        DocMgt: Codeunit "Document Management (INT)";
        PriceGroup: Label 'Price Group: %1';

    local procedure SetCurrency(CurrencyCode2: Code[10]; CurrencyFactor2: Decimal)
    begin
        PricesInCurrency := Currency.Code <> '';
        if PricesInCurrency then begin
            Currency.Find;
            CurrencyText := ' (' + Currency.Code + ')';
            CurrencyFactor := 0;
        end else
            GLSetup.Get;
    end;

    procedure ConvertPricetoUoM(var UOMCode: Code[10]; var UnitPrice: Decimal)
    var
        UOMMgt: Codeunit "Unit of Measure Management";
    begin
        if UOMCode = '' then begin
            UnitPrice :=
              UnitPrice * UOMMgt.GetQtyPerUnitOfMeasure(Item, Item."Sales Unit of Measure");
            if UOMCode = '' then
                UOMCode := Item."Sales Unit of Measure"
            else
                UOMCode := Item."Base Unit of Measure";
        end;
    end;

    local procedure ConvertPriceLCYToFCY(CurrencyCode: Code[10]; var UnitPrice: Decimal)
    begin
        if PricesInCurrency then begin
            if CurrencyCode = '' then begin
                if CurrencyFactor = 0 then begin
                    Currency.TestField("Unit-Amount Rounding Precision");
                    CurrencyFactor := CurrExchRate.ExchangeRate(DateReq, Currency.Code);
                end;
                UnitPrice := CurrExchRate.ExchangeAmtLCYToFCY(DateReq, Currency.Code, UnitPrice, CurrencyFactor);
            end;
            UnitPrice := Round(UnitPrice, Currency."Unit-Amount Rounding Precision");
        end else
            UnitPrice := Round(UnitPrice, GLSetup."Unit-Amount Rounding Precision");
    end;

    procedure PreparePrintSalesPrice(IsVariant: Boolean)
    begin
        with SalesPrice do begin
            if PricesInCurrency then begin
                SetRange("Currency Code", Currency.Code);
                if Find('-') then begin
                    SetRange("Currency Code", '');
                    DeleteAll;
                end;
                SetRange("Currency Code");
            end;

            SetRange("Sales Type", SalesType);
            SetRange("Sales Code", SalesCode);

            if IsVariant then begin
                SetRange("Variant Code", '');
                DeleteAll;
                SetRange("Variant Code");
            end;
        end;

        IsFirstSalesPrice := true;
    end;

    procedure PrintSalesPrice(IsVariant: Boolean)
    begin
        with SalesPrice do begin
            if IsFirstSalesPrice then begin
                IsFirstSalesPrice := false;
                if not Find('-') then begin
                    if not IsVariant then begin
                        if SalesType = SalesType::Campaign then
                            CurrReport.Skip;

                        "Currency Code" := '';
                        "Price Includes VAT" := Item."Price Includes VAT";
                        "Unit Price" := Item."Unit Price";
                        "Unit of Measure Code" := Item."Base Unit of Measure";
                        "Minimum Quantity" := 0;
                    end else
                        CurrReport.Skip;
                end;
            end else
                if Next = 0 then
                    CurrReport.Break;

            if (SalesType = SalesType::Campaign) and ("Sales Type" <> "Sales Type"::Campaign) then
                CurrReport.Skip;

            if "Price Includes VAT" then
                VATText := Text000
            else
                VATText := Text001;

            ConvertPricetoUoM(UnitOfMeasure, "Unit Price");
            ConvertPriceLCYToFCY("Currency Code", "Unit Price");
            if "Unit of Measure Code" = '' then
                "Unit of Measure Code" := Item."Sales Unit of Measure";
            if "Unit of Measure Code" <> '' then begin
                UnitofMeasureRec.Get("Unit of Measure Code");
                DocMgt.TranslateUnitOfMeasure(UnitofMeasureRec, Sprache);
                UnitOfMeasure := UnitofMeasureRec.Description;
            end;
        end;
    end;

    procedure PreparePrintSalesDisc(IsVariant: Boolean)
    begin
        with SalesLineDisc do begin
            if PricesInCurrency then begin
                SetRange("Currency Code", Currency.Code);
                if Find('-') then begin
                    SetRange("Currency Code", '');
                    DeleteAll;
                end;
                SetRange("Currency Code");
            end;

            if IsVariant then begin
                SetRange("Variant Code", '');
                DeleteAll;
                SetRange("Variant Code");
            end;
        end;

        IsFirstSalesLineDisc := true;
    end;

    procedure PrintSalesDisc()
    begin
        with SalesLineDisc do begin
            if IsFirstSalesLineDisc then begin
                IsFirstSalesLineDisc := false;
                if not Find('-') then
                    CurrReport.Break;
            end else
                if Next = 0 then
                    CurrReport.Break;

            if (SalesType = SalesType::Campaign) and ("Sales Type" <> "Sales Type"::Campaign) then
                CurrReport.Skip;

            if "Unit of Measure Code" = '' then
                UnitOfMeasure := Item."Base Unit of Measure"
            else
                UnitOfMeasure := "Unit of Measure Code";
        end;
    end;

    procedure InitializeRequest(NewDateReq: Date; NewSalesType: Option; NewSalesCode: Code[20]; NewCurrencyCode: Code[10])
    begin
        DateReq := NewDateReq;
        SalesType := NewSalesType;
        SalesCode := NewSalesCode;
        Currency.Code := NewCurrencyCode;
    end;

    procedure ValidateSalesCode()
    begin
        if (SalesType <> SalesType::"All Customers") and (SalesCode = '') then
            Error(Text004);

        case SalesType of
            SalesType::Customer:
                Cust.Get(SalesCode);
            SalesType::"Customer Price Group":
                CustPriceGr.Get(SalesCode);
            SalesType::Campaign:
                Campaign.Get(SalesCode);
        end;
    end;
}

