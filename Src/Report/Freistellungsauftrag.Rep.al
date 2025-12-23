report 50000 "Freistellungsauftrag (INT)"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Src\Layout\Freistellungsauftrag.rdlc';
    ApplicationArea = All;

    dataset
    {
        dataitem("Print Document"; "Print Document")
        {
            column(LangTextDocument; LongTextDocument)
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
            column(Company_USAccount; CompanyInfo."US Account (INT)")
            {

            }
            column(CompanyInfoRegNo; CompanyInfo.GetRegistrationNumber)
            {
            }
            column(RegNoCaption; CompanyInfo.GetRegistrationNumberLbl)
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
            column(Text15; Text15)
            {

            }
            column(Text16; Text16)
            {

            }
            column(Text17; Text17)
            {

            }
            column(Text18; Text18)
            {

            }
            column(ContactLabl; ContactLabl)
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
                dataitem("Sales Header"; "Sales Header")
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
                    column(DocumentDate_SalesHeader; "Sales Header"."Document Date")
                    {
                    }
                    column(No_SalesHeader; "Sales Header"."No.")
                    {
                        IncludeCaption = true;
                    }
                    column(Salesperson_Name; StrSubstNo(SalesContact, Salesperson.Name))
                    {
                    }
                    column(Sell_To_No; "Sales Header"."Sell-to Customer No.")
                    {
                    }
                    dataitem(SalesLineInt; "Integer")
                    {
                        column(Description2_SalesLine; SalesLineTemp."Description 2")
                        {
                            IncludeCaption = true;
                        }
                        column(No_SalesLine; SalesLineTemp."No.")
                        {
                            IncludeCaption = true;
                        }
                        column(Line_No_SalesLine; SalesLineTemp."Line No.")
                        {
                        }
                        column(Description_SalesLine; SalesLineTemp.Description)
                        {
                            IncludeCaption = true;
                        }
                        column(Quantity_SalesLine; SalesLineTemp.Quantity)
                        {
                            IncludeCaption = true;
                        }
                        column(UnitOfMeasure_SalesLine; SalesLineTemp."Unit of Measure")
                        {
                        }
                        column(LotNo_SalesLine; SalesLineTemp."Tax Area Code")
                        {
                        }
                        column(ExpirationDate_SalesLine; Ablaufsdatum(SalesLineTemp."Tax Area Code"))
                        {
                        }
                        column(GrossWeigt_SalesLine; SalesLineTemp."Gross Weight" * SalesLineTemp.Quantity)
                        {
                        }
                        column(ProductGroupCode_SalesLine; SaleslineTemp."Item Category Code")
                        {

                        }


                        trigger OnAfterGetRecord()
                        begin
                            if SalesLineInt.Number = 1 then
                                SalesLineTemp.FindFirst
                            else
                                if SalesLineTemp.Next = 0 then;
                            /*
                            IF Item.GET(SalesLineTemp."No.") THEN BEGIN
                              SalesLineTemp.Description := Item.Description;
                              SalesLineTemp."Description 2" := Item."Description 2";
                            END;
                            */

                        end;

                        trigger OnPreDataItem()
                        begin
                            SetRange(SalesLineInt.Number, 1, SalesLineTemp.Count);
                        end;
                    }

                    trigger OnAfterGetRecord()
                    begin

                        FormatAddr.SalesHeaderShipTo(ShipToAddr, CustAdd, "Sales Header");

                        if "Sales Header"."Salesperson Code" <> '' then
                            Salesperson.Get("Sales Header"."Salesperson Code")
                        else
                            Salesperson.Init;
                        CompressArray(ShipToAddr);
                        SalesLineTemp.DeleteAll;
                        SalesLine.SetRange(SalesLine."Document Type", "Sales Header"."Document Type");
                        SalesLine.SetRange(SalesLine."Document No.", "No.");
                        SalesLine.SetRange(Type, SalesLine.Type::Item);
                        SalesLine.SetRange("Location Code", Location.Code);
                        if SalesLine.FindSet then
                            repeat
                                SalesLineTemp := SalesLine;
                                ResEntry.SetRange("Source Type", 37);
                                ResEntry.SetRange("Source Subtype", SalesLine."Document Type");
                                ResEntry.SetRange("Source ID", SalesLine."Document No.");
                                ResEntry.SetRange(ResEntry."Source Ref. No.", SalesLine."Line No.");
                                if ResEntry.FindFirst then begin
                                    SalesLineTemp."Tax Area Code" := ResEntry."Lot No."; //benütze Category Code für Chargennr.
                                    SalesLineTemp."Planned Delivery Date" := ResEntry."Expiration Date"; //benütze für Ablaufsdatum (MHD)
                                end else begin
                                    SalesLineTemp."Tax Area Code" := '';
                                    SalesLineTemp."Planned Delivery Date" := 0D;
                                end;
                                SalesLineTemp.Insert;
                            until SalesLine.Next = 0;
                    end;

                    trigger OnPreDataItem()
                    begin
                        SetRange("Sales Header"."Document Type", "Print Document"."Ref. Type");
                        SetRange("Sales Header"."No.", "Print Document"."Ref. No.");
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
                    SalesLine.Reset;
                    Counter := 1;
                    if "Print Document".GetFilter("Location filter") <> '' then
                        SetFilter(Location.Code, "Print Document".GetFilter("Location filter"))
                    else
                        SetFilter(Location.Code, "Print Document"."Location Code");
                    if ("Print Document"."Location Code" = '') and ("Print Document"."Location filter" = '') then begin
                        SalesLine.SetRange("Document Type", "Print Document"."Ref. Type");
                        SalesLine.SetRange("Document No.", "Print Document"."Ref. No.");
                        SalesLine.SetRange(Type, SalesLine.Type::Item);
                        if SalesLine.FindSet then
                            repeat

                                if StrPos(LocationFilter, SalesLine."Location Code") = 0 then begin
                                    if StrLen(LocationFilter) > 1 then
                                        LocationFilter += '|';
                                    LocationFilter += SalesLine."Location Code";
                                end;
                                Counter += 1;
                            until SalesLine.Next = 0;
                        SetFilter(Location.Code, LocationFilter);
                    end;
                    SalesLine.Reset;
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
                FormatAddr.Company(CompanyAddr, CompanyInfo);
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

    // labels
    // {
    //     Kontakt = 'Contact Person :';
    //     Text16 = 'Receiver';
    //     Text17 = 'Customer No.';
    //     Text15 = 'Warehause';
    //     Text18 = 'Fax No.:';
    // }

    trigger OnInitReport()
    begin
        CompanyInfo.Get;
        CompanyInfo.CalcFields(Picture);
    end;

    var
        LocationAddr: array[8] of Text[90];
        FormatAddr: Codeunit "Format Address";
        CustAdd: array[8] of Text[100];
        ShipToAddr: array[8] of Text[90];
        SalesLineTemp: Record "Sales Line" temporary;
        SalesLine: Record "Sales Line";
        ResEntry: Record "Reservation Entry";
        DocumentText: Record "Document Text";
        LongTextDocument: Text;
        CompanyInfo: Record "Company Information";
        CompanyAddr: array[8] of Text[50];
        FonText: Label 'Telefon:';
        FaxText: Label 'Fax:';
        VATRegNoCaptionLbl: Label 'VAT Reg. No.';
        Salesperson: Record "Salesperson/Purchaser";
        SalesContact: Label 'Kontaktperson: %1';
        Item: Record Item;
        Text15: Label 'Lagerort';
        Text16: Label 'Empfänger';
        Text17: Label 'Debitorennr.';
        Text18: Label 'Faxnr.';
        ContactLabl: Label 'Contact Person:';

    local procedure Ablaufsdatum("Chargennr.": Code[20]): Date
    var
        ItemLedgEntry: Record "Item Ledger Entry";
    begin
        ItemLedgEntry.SetRange("Lot No.", "Chargennr.");
        ItemLedgEntry.SetRange(Positive, true);
        ItemLedgEntry.SetFilter("Remaining Quantity", '>%1', 0);
        if ItemLedgEntry.FindSet then
            exit(ItemLedgEntry."Expiration Date");
    end;
}

