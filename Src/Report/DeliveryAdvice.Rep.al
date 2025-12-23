report 50002 "Delivery Advice (INT)"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Src\Layout\Delivery Advice.rdlc';
    ApplicationArea = All;

    dataset
    {
        dataitem("Print Document"; "Print Document")
        {
            column(LangTextDocument; LongTextDocument)
            {
            }
            column(ShippingAgentName; ShippingAgent.Name)
            {
            }
            column(FaxNo_Vendor; "Print Document"."Fax No.")
            {
            }
            column(Email_Vendor; "Print Document"."E-mail")
            {
            }
            column(CompanyInfo1Picture; CompanyInfo.Picture)
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
            column(CompanyInfoPhoneNo; CompanyInfo."Phone No.")
            {
            }
            column(CompanyInfo_Fax_No_; CompanyInfo."Fax No.")
            {
            }
            column(CompanyInfoHomePage; CompanyInfo."Home Page")
            {
            }
            column(CompanyInfoEMail; CompanyInfo."E-Mail")
            {
            }
            column(CompanyInfoVATRegNo; CompanyInfo."VAT Registration No.")
            {
            }
            column(CompanyInfoBankName; CompanyInfo."Bank Name")
            {
            }
            column(Company_IBAN; CompanyInfo.IBAN)
            {
            }
            column(Company_Swift; CompanyInfo."SWIFT Code")
            {
            }
            column(CompanyInfoRegNo; CompanyInfo.GetRegistrationNumber)
            {
            }
            column(RegNoCaption; CompanyInfo.GetRegistrationNumberLbl)
            {
            }
            column(Company_USAccount; CompanyInfo."US Account (INT)")
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
            dataitem(Location; Location)
            {
                column(LocationAddr1; LocationAddr[1])
                {
                }
                column(LocationAddr2; LocationAddr[2])
                {
                }
                column(LocationAddr3; LocationAddr[3])
                {
                }
                column(LocationAddr4; LocationAddr[4])
                {
                }
                column(LocationAddr5; LocationAddr[5])
                {
                }
                column(LocationAddr6; LocationAddr[6])
                {
                }
                column(LocationAddr7; LocationAddr[7])
                {
                }
                column(LocationAddr8; LocationAddr[8])
                {
                }
                column(Code_Location; Location.Code)
                {
                }
                dataitem("Purchase Header"; "Purchase Header")
                {
                    column(ShipToAddr1; ShipToAddr[1])
                    {
                    }
                    column(ShipToAddr2; ShipToAddr[2])
                    {
                    }
                    column(ShipToAddr3; ShipToAddr[3])
                    {
                    }
                    column(ShipToAddr4; ShipToAddr[4])
                    {
                    }
                    column(ShipToAddr5; ShipToAddr[5])
                    {
                    }
                    column(ShipToAddr6; ShipToAddr[6])
                    {
                    }
                    column(ShipToAddr7; ShipToAddr[7])
                    {
                    }
                    column(ShipToAddr8; ShipToAddr[8])
                    {
                    }
                    column(BuyFromVendorNo_PurchHeader; "Purchase Header"."Buy-from Vendor No.")
                    {
                    }
                    column(DocumentDate_PurchHeader; "Purchase Header"."Document Date")
                    {
                    }
                    column(No_PurchHeader; "Purchase Header"."No.")
                    {
                    }
                    column(ContactName_PurchPerson; SalesPerson.Name)
                    {
                    }
                    column(ExpectedReceiptDate_PurchHeader; "Purchase Header"."Expected Receipt Date")
                    {
                    }
                    column(BuyFromVendorName_PurchHeader; "Purchase Header"."Buy-from Vendor Name")
                    {
                    }
                    dataitem(PurchLineInt; "Integer")
                    {
                        column(Description2_PurchLine; PurchLineTemp."Description 2")
                        {
                        }
                        column(No_PurchLine; PurchLineTemp."No.")
                        {
                        }
                        column(Description_PurchLine; PurchLineTemp.Description)
                        {
                        }
                        column(Quantity_PurchLine; PurchLineTemp.Quantity)
                        {
                        }
                        column(UnitOfMeasure_PurchLine; PurchLineTemp."Unit of Measure")
                        {
                        }
                        column(LotNo_PurchLine; PurchLineTemp."Special Order Sales No.")
                        {
                        }
                        column(ExpirationDate_PurchLine; Ablaufsdatum(PurchLineTemp."Special Order Sales No."))
                        {
                        }
                        column(GrossWeigt_PurchLine; PurchLineTemp."Gross Weight" * PurchLineTemp.Quantity)
                        {
                        }
                        column(ProductGroupCode_PurchLine; PurchLineTemp."Item Category Code")
                        {

                        }
                        column(LineNo_PurchLine; PurchLineTemp."Line No.")
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin
                            if PurchLineInt.Number = 1 then
                                PurchLineTemp.FindFirst
                            else
                                if PurchLineTemp.Next = 0 then;
                        end;

                        trigger OnPreDataItem()
                        begin
                            SetRange(PurchLineInt.Number, 1, PurchLineTemp.Count);
                        end;
                    }

                    trigger OnAfterGetRecord()
                    begin

                        //FormatAddr.SalesHeaderShipTo(ShipToAddr, "Purchase Header");
                        FormatAddr.PurchHeaderShipTo(ShipToAddr, "Purchase Header");
                        CompressArray(ShipToAddr);
                        PurchLineTemp.DeleteAll;
                        PurchLine.SetRange(PurchLine."Document Type", "Purchase Header"."Document Type");
                        PurchLine.SetRange(PurchLine."Document No.", "No.");
                        PurchLine.SetRange(Type, PurchLine.Type::Item);
                        PurchLine.SetRange("Location Code", Location.Code);
                        if PurchLine.FindSet then
                            repeat
                                PurchLineTemp := PurchLine;
                                /*
                                IF Item.GET(PurchLine."No.") THEN
                                  PurchLineTemp.Description := Item.Description;
                                */
                                ResEntry.SetRange("Source Type", 39);
                                ResEntry.SetRange("Source Subtype", PurchLine."Document Type");
                                ResEntry.SetRange("Source ID", PurchLine."Document No.");
                                ResEntry.SetRange(ResEntry."Source Ref. No.", PurchLine."Line No.");
                                if ResEntry.FindFirst then begin
                                    PurchLineTemp."Special Order Sales No." := ResEntry."Lot No."; //benütze Category Code für Chargennr.
                                    PurchLineTemp."Promised Receipt Date" := ResEntry."Expiration Date"; //benütze für Ablaufsdatum (MHD)
                                end else begin
                                    PurchLineTemp."Item Category Code" := '';
                                    PurchLineTemp."Promised Receipt Date" := 0D;
                                end;
                                PurchLineTemp.Insert;
                            until PurchLine.Next = 0;
                        if "Purchase Header"."Purchaser Code" <> '' then
                            SalesPerson.Get("Purchase Header"."Purchaser Code")
                        else
                            SalesPerson.Init;

                    end;

                    trigger OnPreDataItem()
                    begin
                        SetRange("Purchase Header"."Document Type", "Print Document"."Ref. Type");
                        SetRange("Purchase Header"."No.", "Print Document"."Ref. No.");
                    end;
                }

                trigger OnAfterGetRecord()
                begin

                    FormatAddr.FormatAddr(
                      LocationAddr,
                      Name,
                      "Name 2",
                      Contact,
                      Address,
                      "Address 2",
                      City,
                      "Post Code",
                      County,
                      "Country/Region Code");

                    CompressArray(LocationAddr);
                end;

                trigger OnPreDataItem()
                var
                    LocationFilter: Text[250];
                    ExitLoop: Boolean;
                    Counter: Integer;
                begin
                    PurchLine.Reset;
                    Counter := 1;
                    if "Print Document"."Location filter" <> '' then
                        SetFilter(Location.Code, "Print Document"."Location filter")
                    else
                        SetFilter(Location.Code, "Print Document"."Location Code");
                    if ("Print Document"."Location Code" = '') and ("Print Document"."Location filter" = '') then begin
                        PurchLine.SetRange("Document Type", "Print Document"."Ref. Type");
                        PurchLine.SetRange("Document No.", "Print Document"."Ref. No.");
                        PurchLine.SetRange(Type, PurchLine.Type::Item);
                        if PurchLine.FindSet then
                            repeat

                                if StrPos(LocationFilter, PurchLine."Location Code") = 0 then begin
                                    if StrLen(LocationFilter) > 1 then
                                        LocationFilter += '|';
                                    LocationFilter += PurchLine."Location Code";
                                end;
                                Counter += 1;
                            until PurchLine.Next = 0;
                        SetFilter(Location.Code, LocationFilter);
                    end;
                    PurchLine.Reset;
                end;
            }

            trigger OnAfterGetRecord()
            var
                CRLF: Text[2];
            begin
                CRLF := '';
                CRLF[1] := 13;
                CRLF[2] := 10;
                DocumentText.SetRange("No.", "Print Document"."Document No.");
                if DocumentText.FindSet then
                    repeat
                        LongTextDocument += DocumentText."Document Text" + CRLF;
                    until DocumentText.Next = 0;
                if not ShippingAgent.Get("Print Document"."Shipping Agent Code") then
                    ShippingAgent.Init
                else if not Vendor.Get(ShippingAgent."Vendor No.") then
                    Vendor.Init;
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
        Kontakt = 'Kontakt :';
        Text16 = 'Empfänger';
        Text17 = 'Debitorennr.';
        Text15 = 'Lagerort';
        Text18 = 'Fax Nr.:';
    }

    trigger OnInitReport()
    begin
        CompanyInfo.Get;
        CompanyInfo.CalcFields(Picture);
        FormatAddr.Company(CompanyAddr, CompanyInfo);
    end;

    var
        LocationAddr: array[8] of Text[90];
        FormatAddr: Codeunit "Format Address";
        ShipToAddr: array[8] of Text[90];
        PurchLineTemp: Record "Purchase Line" temporary;
        PurchLine: Record "Purchase Line";
        ResEntry: Record "Reservation Entry";
        DocumentText: Record "Document Text";
        LongTextDocument: Text;
        ShippingAgent: Record "Shipping Agent";
        Vendor: Record Vendor;
        SalesPerson: Record "Salesperson/Purchaser";
        CompanyInfo: Record "Company Information";
        CompanyAddr: array[8] of Text[50];
        FonText: Label 'Telefon:';
        FaxText: Label 'Fax:';
        VATRegNoCaptionLbl: Label 'VAT Reg. No.';
        Item: Record Item;

    local procedure Ablaufsdatum("Chargennr.": Code[20]): Date
    var
        ItemLedgEntry: Record "Item Ledger Entry";
    begin
        ItemLedgEntry.SetRange("Lot No.", "Chargennr.");
        ItemLedgEntry.SetRange(Positive, true);
        ItemLedgEntry.SetFilter("Remaining Quantity", '>%1', 0);
        if ItemLedgEntry.FindSet then
            exit(ItemLedgEntry."Expiration Date");
        exit(0D)
    end;
}

