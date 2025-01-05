codeunit 50006 "Export CSV Datei"
{

    trigger OnRun()
    begin
    end;

    var
        CSVDatei: File;
        PrintDocumentGL: Record "Print Document";
        fileMgt: Codeunit "File Management";
        ServerFileName: Text;
        CharVar: array[32] of Char;
        ClientFileName: Text;
        DATEINAME: Label '%1.%2';
        FieldCap: array[40] of Text;
        FieldValue: array[40] of Text;
        Customer: Record Customer;
        Vendor: Record Vendor;
        FileName: Text;
        OStream: OutStream;
        LocationFilter: Text;
        Tempblob: Codeunit "Temp Blob";
        DocType: Record "Document Type";

    procedure ExportSalesOrder(PrintDocument: Record "Print Document"): Boolean
    var
        SalesHeader: Record "Sales Header";
        SalesLine: Record "Sales Line";
        FormatAddr: Codeunit "Format Address";
        ShipToAddr: array[8] of Text[50];
        SalesLineTemp: Record "Sales Line" temporary;
        ResEntry: Record "Reservation Entry";
        Sep: Text[1];
        Trenz: Text[1];
        CR: Char;
        LF: Char;
        PrintDocLines: Record "Document Text";
        PrintDocText: Text;
        PurchHeader: Record "Purchase Header";
        PurchLine: Record "Purchase Line";
        PurchLineTemp: Record "Purchase Line" temporary;
        ItemTrackingMgt: Codeunit "Item Tracking Management";
        ExpDate: Date;
        EntriesExist: Boolean;
        ShipmentMethod: Record "Shipment Method";
        i: Integer;
        Line: Text;
    begin
        IF NOT OpenFile THEN
            EXIT(FALSE);
        Sep := '"';
        Trenz := ';';
        CR := 13;
        LF := 10;

        IF PrintDocument."Print of" = PrintDocument."Print of"::"Sales Document" THEN BEGIN
            FileName := 'ITF_KP_1_';
            SalesHeader.SETRANGE("Document Type", PrintDocument."Ref. Type");
            SalesHeader.SETRANGE("No.", PrintDocument."Ref. No.");

            PrintDocText := '';
            PrintDocLines.SETRANGE(PrintDocLines."No.", PrintDocument."Document No.");
            IF PrintDocLines.FINDSET THEN
                REPEAT
                    PrintDocText += ' ' + PrintDocLines."Document Text";
                UNTIL PrintDocLines.NEXT = 0;

            IF SalesHeader.FINDSET THEN BEGIN
                CheckValueTest(SalesHeader, SalesHeader.FIELDNO("No."));
                CheckValueTest(SalesHeader, SalesHeader.FIELDNO(SalesHeader."Ship-to Name"));
                CheckValueTest(SalesHeader, SalesHeader.FIELDNO(SalesHeader."Ship-to Address"));
                CheckValueTest(SalesHeader, SalesHeader.FIELDNO(SalesHeader."Ship-to City"));
                CheckValueTest(SalesHeader, SalesHeader.FIELDNO(SalesHeader."Ship-to Post Code"));

                // FormatAddr.SalesHeaderShipTo(ShipToAddr, SalesHeader);
                FormatAddr.SalesHeaderShipTo(ShipToAddr, ShipToAddr, SalesHeader);
                COMPRESSARRAY(ShipToAddr);
                SalesLineTemp.DELETEALL;
                SalesLine.SETRANGE(SalesLine."Document Type", SalesHeader."Document Type");
                SalesLine.SETRANGE(SalesLine."Document No.", SalesHeader."No.");
                SalesLine.SETRANGE(Type, SalesLine.Type::Item);

                LocationFilter := SetLocationFilter(PrintDocument);
                IF LocationFilter <> '' THEN BEGIN
                    IF STRPOS(LocationFilter, PrintDocument."Location Code") <> 0 THEN
                        SalesLine.SETFILTER("Location Code", LocationFilter);
                END ELSE
                    IF PrintDocument."Location Code" <> '' THEN
                        SalesLine.SETRANGE("Location Code", PrintDocument."Location Code");

                IF NOT SalesLine.FINDSET THEN
                    ERROR(STRSUBSTNO('Kein Datensatz für export gefunden, %1', SalesLine.GETFILTER("Location Code")));
                WITH SalesHeader DO BEGIN
                    IF NOT ShipmentMethod.GET("Shipment Method Code") THEN
                        ShipmentMethod.INIT;
                    CLEAR(FieldCap);
                    InitCaptions(1);
                    //Kopfüberschriften schreiben
                    FOR i := 1 TO 19 DO
                        IF i < 19 THEN
                            Line += Sep + FieldCap[i] + Sep + Trenz
                        ELSE
                            Line += Sep + FieldCap[i] + Sep;
                    WriteInFile(Line);
                END;
                IF SalesLine.FINDSET THEN
                    REPEAT
                        //Zeilenwerte schreiben
                        CheckValueTest(SalesLine, SalesLine.FIELDNO("No."));
                        CheckValueTest(SalesLine, SalesLine.FIELDNO("Line No."));
                        CheckValueTest(SalesLine, SalesLine.FIELDNO(SalesLine."Qty. to Ship"));
                        SalesLineTemp := SalesLine;
                        ResEntry.SETRANGE("Source Type", 37);
                        ResEntry.SETRANGE("Source Subtype", SalesLine."Document Type");
                        ResEntry.SETRANGE("Source ID", SalesLine."Document No.");
                        ResEntry.SETRANGE(ResEntry."Source Ref. No.", SalesLine."Line No.");
                        IF ResEntry.FINDFIRST THEN BEGIN
                            // ExpDate := ItemTrackingMgt.ExistingExpirationDate(
                            //     ResEntry."Item No.",ResEntry."Variant Code",
                            //     ResEntry."Lot No.",ResEntry."Serial No.",FALSE,EntriesExist);
                            ExpDate := ResEntry."Expiration Date";
                            SalesLineTemp."Special Order Purchase No." := ResEntry."Lot No."; //benütze Category Code für Chargennr.
                            SalesLineTemp."Planned Delivery Date" := ExpDate; //benütze für Ablaufsdatum (MHD)
                        END ELSE BEGIN
                            SalesLineTemp."Special Order Purchase No." := '';
                            SalesLineTemp."Planned Delivery Date" := 0D;
                        END;
                        Customer.GET(SalesHeader."Sell-to Customer No.");
                        SalesLineTemp.INSERT;
                        WITH SalesHeader DO BEGIN
                            FieldValue[1] := "No.";
                            FieldValue[2] := '';
                            FieldValue[3] := SalesHeader."Ship-to Name" + ' ' + SalesHeader."Ship-to Name 2";
                            FieldValue[4] := SalesHeader."Ship-to Address" + '  ' + SalesHeader."Ship-to Address 2";
                            FieldValue[5] := SalesHeader."Ship-to Post Code";
                            FieldValue[6] := SalesHeader."Ship-to City";
                            IF SalesHeader."Ship-to Country/Region Code" = '' THEN
                                FieldValue[7] := 'DE'
                            ELSE
                                FieldValue[7] := SalesHeader."Ship-to Country/Region Code";
                            FieldValue[8] := Customer."Phone No."; //Phon
                            FieldValue[9] := Customer."E-Mail";    //Email
                            FieldValue[10] := ''; //Versandart
                            FieldValue[11] := ''; //Sonderversandart
                            FieldValue[12] := SalesLineTemp."No.";
                            FieldValue[13] := FORMAT(SalesLineTemp."Line No.");
                            FieldValue[14] := ''; //Bereitstelldatum_pos
                            FieldValue[15] := FORMAT(SalesLineTemp.Quantity);
                            FieldValue[16] := SalesLineTemp."Special Order Purchase No.";
                            FieldValue[17] := FORMAT(SalesLineTemp."Planned Delivery Date");
                            FieldValue[18] := FORMAT(SalesLineTemp."Gross Weight");
                            IF SalesLineTemp."Location Code" = 'A-OZL' THEN
                                FieldValue[19] := '1'
                            ELSE IF SalesLineTemp."Location Code" = 'DEHN' THEN
                                FieldValue[19] := '0'
                            ELSE
                                FieldValue[19] := '';
                            Line := '';
                            FOR i := 1 TO 19 DO
                                IF i < 19 THEN
                                    Line += Sep + FieldValue[i] + Sep + Trenz
                                ELSE
                                    Line += Sep + FieldValue[i] + Sep;
                            WriteInFile(Line);
                        END;
                    UNTIL SalesLine.NEXT = 0;
            END;
        END ELSE IF PrintDocument."Print of" = PrintDocument."Print of"::"Purchase Document" THEN BEGIN
            FileName := 'ITF_BW_1_';
            PurchHeader.SETRANGE("Document Type", PrintDocument."Ref. Type");
            PurchHeader.SETRANGE("No.", PrintDocument."Ref. No.");
            PrintDocText := '';
            PrintDocLines.SETRANGE(PrintDocLines."No.", PrintDocument."Document No.");
            IF PrintDocLines.FINDSET THEN
                REPEAT
                    PrintDocText += ' ' + PrintDocLines."Document Text";
                UNTIL PrintDocLines.NEXT = 0;

            IF PurchHeader.FINDSET THEN BEGIN
                CheckValueTest(PurchHeader, PurchHeader.FIELDNO("No."));
                FormatAddr.PurchHeaderShipTo(ShipToAddr, PurchHeader);
                COMPRESSARRAY(ShipToAddr);
                CLEAR(FieldCap);
                InitCaptions(2);
                //Kopfüberschriften schreiben
                FOR i := 1 TO 20 DO
                    IF i < 20 THEN
                        Line += Sep + FieldCap[i] + Sep + Trenz
                    ELSE
                        Line += Sep + FieldCap[i] + Sep;
                WriteInFile(Line);
                PurchLineTemp.DELETEALL;
                PurchLine.SETRANGE(PurchLine."Document Type", PurchHeader."Document Type");
                PurchLine.SETRANGE(PurchLine."Document No.", PurchHeader."No.");
                PurchLine.SETRANGE(Type, PurchLine.Type::Item);

                IF (PrintDocument."Location Code" = 'DEHN') OR (PrintDocument."Location Code" = 'D-OZL') THEN
                    PurchLine.SETFILTER("Location Code", '%1|%2', 'DEHN', 'D-OZL')
                ELSE
                    IF PrintDocument."Location Code" <> '' THEN
                        PurchLine.SETRANGE("Location Code", PrintDocument."Location Code");
                IF NOT PurchLine.FINDSET THEN
                    ERROR(STRSUBSTNO('Kein Datensatz in für export gefunden, %1', PurchLine.GETFILTER("Location Code")));
                WITH PurchHeader DO BEGIN
                    IF NOT ShipmentMethod.GET("Shipment Method Code") THEN
                        ShipmentMethod.INIT;
                END;
                IF PurchLine.FINDSET THEN
                    REPEAT
                        CheckValueTest(PurchLine, PurchLine.FIELDNO("No."));
                        CheckValueTest(PurchLine, PurchLine.FIELDNO(PurchLine."Qty. to Receive"));
                        PurchLineTemp := PurchLine;
                        ResEntry.SETRANGE("Source Type", 39);
                        ResEntry.SETRANGE("Source Subtype", PurchLine."Document Type");
                        ResEntry.SETRANGE("Source ID", PurchLine."Document No.");
                        ResEntry.SETRANGE(ResEntry."Source Ref. No.", PurchLine."Line No.");
                        IF ResEntry.FINDFIRST THEN BEGIN
                            PurchLineTemp."Special Order Sales No." := ResEntry."Lot No."; //benütze Category Code für Chargennr.
                            PurchLineTemp."Planned Receipt Date" := ResEntry."Expiration Date"; //benütze für Ablaufsdatum (MHD)
                        END ELSE BEGIN
                            PurchLineTemp."Special Order Sales No." := '';
                            PurchLineTemp."Planned Receipt Date" := 0D;
                        END;
                        PurchLineTemp.INSERT;
                        WITH PurchHeader DO BEGIN
                            FieldValue[1] := "No.";
                            FieldValue[2] := '';
                            FieldValue[3] := PurchHeader."Buy-from Vendor No.";
                            FieldValue[4] := PurchHeader."Buy-from Vendor Name";
                            FieldValue[5] := PurchHeader."Buy-from Address" + ' ' + PurchHeader."Buy-from Address 2" + ' ' + PurchHeader."Pay-to Post Code" + ' ' + PurchHeader."Buy-from City";
                            FieldValue[6] := ''; //Bestellart
                            FieldValue[7] := FORMAT(PurchHeader."Requested Receipt Date"); //Lieferdatum
                            FieldValue[8] := ''; //Liefername
                            FieldValue[9] := ''; //Liefer_Strasse
                            FieldValue[10] := ''; //Liefer_PLZ
                            FieldValue[11] := ''; //Liefer_Ort
                            FieldValue[12] := ''; //Liefer_LCode
                            FieldValue[13] := ''; //ContainerNr
                            FieldValue[14] := ''; //ReferenzNr
                            FieldValue[15] := ''; //ZollreferenzNr
                            FieldValue[16] := ''; //VerdichtungsNr.
                            FieldValue[17] := FORMAT(PurchLineTemp."Line No."); //BestellPos
                            FieldValue[18] := PurchLineTemp."No."; //ArtikelNr
                            FieldValue[19] := FORMAT(PurchLineTemp.Quantity);
                            IF PurchLineTemp."Location Code" = 'A-OZL' THEN
                                FieldValue[20] := '1'
                            ELSE IF PurchLineTemp."Location Code" = 'DEHN' THEN
                                FieldValue[20] := '0'
                            ELSE
                                FieldValue[19] := '';
                            Line := '';
                            FOR i := 1 TO 20 DO
                                IF i < 20 THEN
                                    Line += Sep + FieldValue[i] + Sep + Trenz
                                ELSE
                                    Line += Sep + FieldValue[i] + Sep;
                            WriteInFile(Line);
                        END;
                    UNTIL PurchLine.NEXT = 0;
            END;
        END;
        //CopyToLocalDrive('C:\Intertrade\'+SetFileName(FileName));
        DocType.Get(PrintDocument."Document Type");
        UploadToFTPServer(PrintDocument, DocType."Ship. Lines File Name");
        EXIT(TRUE);

    end;

    local procedure UploadToFTPServer(var PrintDoc: Record "Print Document"; AttachFilename: Text)
    var
        DocType: Record "Document Type";
    begin
        IF DocType.GET(PrintDoc."Document Type") THEN BEGIN
            // DocType.TESTFIELD(DocType."FTP Adresse");
            // DocType.TESTFIELD(DocType."FTP User");
            // DocType.TESTFIELD(DocType."FTP Kennwort");
            FileName := SetFileName(AttachFilename);
            // UploadFile(ServerFileName,DocType."FTP Adresse" + FileName,DocType."FTP User",DocType."FTP Kennwort");
            SaveLocal(PrintDoc, ServerFileName, FileName);

        END;
    end;


    local procedure SetFileName(Name: Text): Text
    begin
        EXIT(STRSUBSTNO(DATEINAME, Name + GetDateString, 'csv'));
    end;

    local procedure WriteInFile(TextLine: Text)
    var
        Cr: Char;
        LF: Char;
        StringLib: Codeunit "String Library (INT)";
    begin
        CR := 13;
        LF := 10;
        // TextLine := StringLib.AsciiToAnsi(TextLine);
        OStream.WriteText(TextLine + Cr + LF);
    end;


    procedure ExportItems(var ItemTemp: Record Item temporary; PrintDocument: Record "Print Document"): Boolean
    var
        i: Integer;
        Line: Text;
        Sep: Text[1];
        Trenz: Text[1];
        ItemUnitofMeasure: Record "Item Unit of Measure";
        DocType: Record "Document Type";
    begin
        IF NOT OpenFile THEN
            EXIT(FALSE);
        Sep := '"';
        Trenz := ';';
        InitCaptions(0);
        Line := '';
        FileName := 'ITF_TZ_1_';
        FOR i := 1 TO 14 DO
            Line += Sep + FieldCap[i] + Sep + Trenz;
        WriteInFile(Line);
        IF ItemTemp.FINDSET THEN
            REPEAT
                Line := '';
                CheckValueTest(ItemTemp, ItemTemp.FIELDNO("No."));
                CheckValueTest(ItemTemp, ItemTemp.FIELDNO(Description));
                FieldValue[1] := ItemTemp."No.";
                FieldValue[2] := ItemTemp.Description;
                FieldValue[3] := ItemTemp."Sales Unit of Measure";
                FieldValue[4] := '';//EAN
                FieldValue[5] := FORMAT(ItemTemp."Gross Weight");
                FieldValue[6] := FORMAT(ItemTemp."Net Weight");
                IF ItemUnitofMeasure.GET(ItemTemp."No.", ItemTemp."Sales Unit of Measure") THEN BEGIN
                    FieldValue[7] := FORMAT(ItemTemp."Gross Weight" * ItemUnitofMeasure."Qty. per Unit of Measure");
                    FieldValue[8] := FORMAT(ItemTemp."Net Weight" * ItemUnitofMeasure."Qty. per Unit of Measure");
                    FieldValue[9] := FORMAT(ItemUnitofMeasure."Qty. per Unit of Measure");
                END;
                FieldValue[10] := '';
                FieldValue[11] := ItemTemp."Tariff No.";
                FieldValue[12] := ItemTemp."Country/Region Purchased Code";
                IF ItemTemp."Lot Nos." <> '' THEN
                    FieldValue[13] := '1'
                ELSE
                    FieldValue[13] := '0';
                FieldValue[14] := '';
                Line := '';
                FOR i := 1 TO 14 DO
                    Line += Sep + FieldValue[i] + Sep + Trenz;
                WriteInFile(Line);
            UNTIL ItemTemp.NEXT = 0;
        // StreamWrtier.Close;
        // CSVDatei.CLOSE;
        // ClientFileName := COPYSTR(fileMgt.ClientTempFileName('csv'),1,250);
        // fileMgt.DownloadToFile(ServerFileName,ClientFileName);
        // SLEEP(1000);
        //CopyToLocalDrive('C:\Intertrade\'+SetFileName(FileName));
        DocType.GEt(PrintDocument."Document Type");
        UploadToFTPServer(PrintDocument, DocType."Item Export File Name");
        EXIT(TRUE);
    end;

    local procedure InitCaptions(Source: Option Item,Sales,Purchase)
    begin
        CLEAR(FieldCap);
        CASE Source OF
            Source::Item:
                BEGIN
                    FieldCap[1] := 'ArtikelNr [TZIDEN]';
                    FieldCap[2] := 'Bezeichnung_1 [TZBEZ1]';
                    FieldCap[3] := 'Mengeneinheit [TZME]';
                    FieldCap[4] := 'EAN_GTIN [TZEAN]';
                    FieldCap[5] := 'Brutto_Gewicht_kg [TZBRUT]';
                    FieldCap[6] := 'Netto_Gewicht_kg [TZnett]';
                    FieldCap[7] := 'VPE_Brutto_Gewicht_kg [TZ1BRUT]';
                    FieldCap[8] := 'VPE_Netto_Gewicht_kg [TZ1NETT]';
                    FieldCap[9] := 'Menge_in_VPE_(StkProVPE) [TZVPE]';
                    FieldCap[10] := 'MEinheit_der_VPE [TZME1]';
                    FieldCap[11] := 'ZolltarifNr [TZZTNR]';
                    FieldCap[12] := 'Herkunftslandcode [TZHKLD]';
                    FieldCap[13] := 'Chargenpflichtig [TZCHPF]';
                    FieldCap[14] := 'MHD_pflichtig [TZMHDP]';
                END;
            Source::Sales:
                BEGIN
                    FieldCap[1] := 'AuftragsNr [AKANR1]';
                    FieldCap[2] := 'Bereitstelldatum [AKDTB]';
                    FieldCap[3] := 'Empf_Name1 [AKAN1]';
                    FieldCap[4] := 'Empf_Adresse [AKSTR]';
                    FieldCap[5] := 'Empf_PLZ [AKPLZ]';
                    FieldCap[6] := 'Empf_Ort [AKLORT]';
                    FieldCap[7] := 'Empf_Lcode [AKLAKZ]';
                    FieldCap[8] := 'Empf_Fon [AKTEL]';
                    FieldCap[9] := 'Empf_Email [AKEMAI]';
                    FieldCap[10] := 'Versandart [AKVART]';
                    FieldCap[11] := 'Tour_Sonderversandart [AKTOUR]';
                    FieldCap[12] := 'ArtikelNr [APIDEN]';
                    FieldCap[13] := 'AuftragsPos [APANRP]';
                    FieldCap[14] := 'Bereitstelldatum_Pos [APDTB]';
                    FieldCap[15] := 'Liefermenge [APANFM]';
                    FieldCap[16] := 'PruefNr_ChargenNr [APPRNR]';
                    FieldCap[17] := 'MHD [APDTDC]';
                    FieldCap[18] := 'Komm_Gewicht_kg [APKGEW]';
                    FieldCap[19] := 'WarenKZ [APWAKZ]';
                END;
            Source::Purchase:
                BEGIN
                    FieldCap[1] := 'BestellNr [BKBST1]';
                    FieldCap[2] := 'Bereitstelldatum [BKDTB]';
                    FieldCap[3] := 'Lieferant_Nr [BKLIEF]';
                    FieldCap[4] := 'Lieferant_Name [BKLNAM]';
                    FieldCap[5] := 'Lieferant_Anschrift [BKLAN1]';
                    FieldCap[6] := 'Bestellart [BKBSTA]';
                    FieldCap[7] := 'Lieferdatum [BKDTLD]';
                    FieldCap[8] := 'Liefer_Name [BKAN1]';
                    FieldCap[9] := 'Liefer_Strasse [BKSTR]';
                    FieldCap[10] := 'Liefer_PLZ [BKPLZ]';
                    FieldCap[11] := 'Liefer_Ort [BKLORT]';
                    FieldCap[12] := 'Liefer_Lcode [BKLAKZ]';
                    FieldCap[13] := 'ContainerNr [BKCTNR]';
                    FieldCap[14] := 'ReferenzNr [BKRFNR]';
                    FieldCap[15] := 'ZollreferenzNr [BKZOLN]';
                    FieldCap[16] := 'VerdichtungsNr [BKAGGN]';
                    FieldCap[17] := 'BestellPos [BPBSTP]';
                    FieldCap[18] := 'ArtikelNr [BPIDEN]';
                    FieldCap[19] := 'Bestellmenge [BPBMEN]';
                    FieldCap[20] := 'WarenKZ [APWAKZ]';
                END;

        END;
    end;

    local procedure GetDateString(): Text
    var
        MyDateTime: DateTime;
    begin
        MyDateTime := CREATEDATETIME(TODAY, TIME);
        EXIT(FORMAT(DT2DATE(MyDateTime), 0, '<Year4><Month,2><Day,2>') + FORMAT(DT2TIME(MyDateTime), 0, '<Hours24,2><Filler Character,0><Minutes,2><Seconds,2>'));
    end;

    local procedure CheckValue("Table": Option; Index: Integer; Value: Text): Text
    begin
        IF Value = '' THEN
            ERROR('Das Feld %1 darf nicht Leer sein.', FieldCap[Index]);
    end;

    local procedure CheckValueTest(Variant: Variant; FieldIndex: Integer)
    var
        Fref: FieldRef;
        RecRef: RecordRef;
    begin
        IF Variant.ISRECORD THEN BEGIN
            RecRef.GETTABLE(Variant);
            RecRef.SETRECFILTER;
            IF RecRef.FINDSET THEN BEGIN
                Fref := RecRef.FIELD(FieldIndex);
                Fref.TESTFIELD;
            END;
        END;
    end;

    procedure SaveLocal(var PrintDoc: Record "Print Document"; From: Text; FileName: Text)
    var
        Path: Text;
    begin
        // Path := '\\SRV-DC01\Daten\Intertrade\DEHN_inbound';
        // Path := 'C:\Users\tanha\Downloads';
        // IF fileMgt.ClientDirectoryExists(Path) THEN
        // fileMgt.DownloadToFile(From,Path + '\' + FileName);
        // Downloadfiles(Path + '\' + FileName)
        Downloadfiles(PrintDoc, FileName);
    end;

    local procedure SetLocationFilter(PrintDocument: Record "Print Document"): Text
    var
        DocumentType: Record "Document Type";
        FilterText: Text;
    begin
        IF DocumentType.GET(PrintDocument."Document Type") THEN BEGIN
            IF DocumentType."Lagerort 1" <> '' THEN
                FilterText := DocumentType."Lagerort 1";
            IF DocumentType."Lagerort 2" <> '' THEN BEGIN
                IF FilterText = '' THEN
                    FilterText := DocumentType."Lagerort 2"
                ELSE
                    FilterText := FilterText + '|' + DocumentType."Lagerort 2";
            END;
            IF DocumentType."Lagerort 3" <> '' THEN BEGIN
                IF FilterText = '' THEN
                    FilterText := DocumentType."Lagerort 3"
                ELSE
                    FilterText := FilterText + '|' + DocumentType."Lagerort 3";
            END;
        END;
        EXIT(FilterText);
    end;

    procedure Downloadfiles(var PrintDoc: Record "Print Document"; FileName: Text)
    var
        Instr: InStream;
        DocMgt: Codeunit "Document Management (INT)";
    begin
        tempblob.CreateInStream(Instr, TextEncoding::UTF8);
        // DownloadFromStream(Instr, '', '', '', FileName);
        DocMgt.SendFileAsEmailAttach(PrintDoc, instr, FileName);
    end;

    procedure OpenFile(): Boolean
    begin
        Tempblob.CreateOutStream(OStream, TextEncoding::UTF8);
        exit(true);
    end;

    procedure CsvExport(var PrintDocument: Record "Print Document")
    var
        Selection: Integer;
        Text001: Label 'Lieferzeilen,Artikelstammdaten,Druckbeleg als Pdf';
        PageItemList: Page "Item List";
        Item: Record item;
        ItemTemp: Record Item temporary;
        PrintDocument2: Record "Print Document";
        DocumentType: Record "Document Type";
        AttachmentFilePath: Text;
        DocMgt: Codeunit "Document Management (INT)";
    begin
        Selection := StrMenu(Text001, 1);
        case Selection of
            1:
                begin
                    if ExportSalesOrder(PrintDocument) then;
                    // Message('CSV-Datei erfolgreich exportiert.');
                end;
            2:
                begin
                    Clear(PageItemList);
                    PageItemList.SetTableView(Item);
                    PageItemList.GetRecord(Item);
                    PageItemList.LookupMode(true);
                    if PageItemList.RunModal() = Action::LookupOK then begin
                        If not Confirm('Möchten Sie die ausgewählten Artikel exportieren?', false) then
                            Error('Export von Daten abgebrochen.');
                        // item.SetView(PageItemList.GetSelectionFilter());
                        // PageItemList.GetSelectionFilter();
                        Item.SetView(PageItemList.GetItemFilter());
                        if Item.FindSet() then
                            repeat
                                ItemTemp.TransferFields(Item);
                                ItemTemp.Insert();
                            Until item.Next() = 0;
                        if ExportItems(ItemTemp, PrintDocument) then;
                        // Message('CSV-Datei erfolgreich exportiert.');
                    end;
                end;
            3:
                begin
                    PrintDocument2.SetView(PrintDocument.GetView());
                    PrintDocument2.FindSet();
                    DocumentType.Get(PrintDocument."Document Type");
                    PrintDocument2.SetRecFilter();
                    AttachmentFilePath := DocMgt.downloadPrintDocReport(PrintDocument2, DocumentType."Ship. Lines File Name");

                end;
        end;
    end;

    // procedure UploadFile()
    // var
    //     fileMgt: Codeunit "File Management";
    //     httpClient: HttpClient;
    //     httpContent: HttpContent;
    //     jsonBody: text;
    //     httpResponse: HttpResponseMessage;
    //     httpHeader: HttpHeaders;
    //     fileName: Text;
    //     fileExt: Text;
    //     InStr: InStream;
    //     base64Convert: Codeunit "Base64 Convert";
    // begin
    //     UploadIntoStream('Select a file to upload', '', 'All files (*.*)|*.*', fileName, InStr);
    //     fileExt := fileMgt.GetExtension(fileName);

    //     jsonBody := ' {"base64":"' + base64Convert.ToBase64(InStr) +
    //     '","fileName":"' + fileName + '.' + fileExt +
    //     '","fileType":"' + GetMimeType(fileName) + '", "fileExt":"' + fileMgt.GetExtension(fileName) +
    //         '"}';

    //     httpContent.WriteFrom(jsonBody);
    //     httpContent.GetHeaders(httpHeader);
    //     httpHeader.Remove('Content-Type');
    //     httpHeader.Add('Content-Type', 'application/json');
    //     httpClient.Post(BaseUrlUploadFunction, httpContent, httpResponse);
    //     //Here we should read the response to retrieve the URI
    //     message('File uploaded.');
    // end;
}

