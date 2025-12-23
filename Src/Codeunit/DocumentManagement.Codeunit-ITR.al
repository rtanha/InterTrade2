codeunit 50000 "Document Management (INT)"
{
    // version Intertrade

    Permissions = TableData "Item Ledger Entry" = rimd,
                    TableData "G/L Entry" = rimd,
                    TableData "Sales Invoice Header" = rimd,
                    TableData "Sales Cr.Memo Header" = rimd,
                    TableData "Purch. Inv. Header" = rimd,
                    TableData "Purch. Cr. Memo Hdr." = rimd;

    trigger OnRun()
    begin
        /*
        Cust.SetFilter(Cust."Gen. Bus. Posting Group", '%1|%2', 'EU', 'IMP/EXP');
        if Cust.FindFirst then
        repeat
            Cust."Transaction Type" := '11';
            Cust."Transaction Specification" := '10000';
            Cust."Transport Method" := '3';
            Cust.Modify;
        until Cust.Next = 0;
        Vend.SetFilter("Gen. Bus. Posting Group", '%1|%2', 'EU', 'IMP/EXP');
        if Vend.FindFirst then
        repeat
            Vend."Transaction Type" := '11';
            Vend."Transaction Specification" := '43000';
            Vend."Transport Method" :=  '3';
            Vend.Modify;
        until Vend.Next = 0;
        */
    end;

    var
        TabRef: RecordRef;
        FeldRef: FieldRef;
        TabRef2: RecordRef;
        TextWindow001: Label 'Copy Lines ...\@1@@@@@@@@@@@@@@@@@@@@@@@@@@@@@';
        Window: Dialog;
        CurrentRecord: Integer;
        RecordCount: Integer;
        Vend: Record Vendor;
        Cust: Record Customer;

    procedure ShowDocument(var DocumentType: Record "Document Type")
    var
        SalesHeader: Record "Sales Header";
        PurchHeader: Record "Purchase Header";
    begin
        /*
        with DocumentType do begin
            TestField("Page ID");

            case DocumentType."Header Table ID" of
                Database::"Sales Header" :
                    begin
                        SalesHeader.Reset;
                        // SalesHeader.FILTERGROUP(2);
                        SalesHeader.SetRange("Document Type", DocumentType."Header Option Value");
                        // SalesHeader.FILTERGROUP(0);
                        Page.RunModal("Page ID", SalesHeader);
                    end;
                Database::"Purchase Header" :
                    begin
                        PurchHeader.Reset;
                        // PurchHeader.FILTERGROUP(2);
                        PurchHeader.SetRange("Document Type", DocumentType."Header Option Value");
                        // PurchHeader.FILTERGROUP(0);
                        Page.RunModal("Page ID", PurchHeader);
                    end;

            end;
        end;
        */
    end;

    procedure GetDocumentType(NoSeries: Code[20]): Code[20]
    var
        DocumentType: Record "Document Type";
    begin
        DocumentType.SetCurrentKey("Nos.");
        DocumentType.SetRange("Nos.", NoSeries);
        DocumentType.Find('-');
        exit(DocumentType.Code);
    end;

    procedure FindDocumentType(var HeaderRef: RecordRef): Code[20]
    var
        DocumentType: Record "Document Type";
        HeaderFieldRef: FieldRef;
        OptionValue: Option;
    begin
        /*
        HeaderFieldRef := HeaderRef.Field(1); // Document Type
        OptionValue := HeaderFieldRef.Value;

        DocumentType.Reset;
        DocumentType.SetRange("Header Table ID", HeaderRef.Number);
        DocumentType.SetRange("Header Option Field ID", 1);
        DocumentType.SetRange("Header Option Value", OptionValue);

        if DocumentType.Find('-') then
            exit(DocumentType.Code)
        else
            exit('');
          */
    end;

    procedure GetCaption(var TableRef: RecordRef): Text[30]
    var
        TableFieldRef: FieldRef;
        Text001: Label 'Not defined';
        OptionValue: Option "0","1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31","32","33","34","35","36","37","38","39","40","41","42","43","44","45","46","47","48","49","50","51","52","53","54","55","56","57","58","59","60","61","62","63","64","65","66","67","68","69","70","71","72","73","74","75","76","77","78","79","80","81","82","83","84","85","86","87","88","89","90","91","92","93","94","95","96","97","98","99";
    begin
        /*
        TableFieldRef := TableRef.Field(1);

        OptionValue := TableFieldRef.Value;

        if DocOptionValue.Get(TableRef.Number, TableFieldRef.Number, OptionValue) then
            exit(DocOptionValue."Option Value Text")
        else
            exit(Text001);
        */
    end;

    procedure GetSalesCaption(SalesHeader: Record "Sales Header"): Text[1024]
    var
        DocumentType: Record "Document Type";
    begin
        /*
        if DocumentType.Get(SalesHeader."Document Type Code") then
            exit(DocumentType.Description)
        else
            exit('');
        */
    end;

    procedure GetPurchaseCaption(PurchHeader: Record "Purchase Header"): Text[1024]
    var
        DocumentType: Record "Document Type";
    begin
        /*
        if DocumentType.Get(PurchHeader."Document Type Code") then
            exit(DocumentType.Description)
        else
            exit('');
        */
    end;

    procedure PrintSalesDocument(SalesHeader: Record "Sales Header"; ReqWindow: Boolean; SystemPrinter: Boolean)
    var
        DocumentType: Record "Document Type";
        SalesHeaderRef: RecordRef;
        SalesHeaderFieldRef: FieldRef;
    begin

        SalesHeaderRef.Open(Database::"Sales Header");
        SalesHeaderRef.GetTable(SalesHeader);

        DocumentType.Get(FindDocumentType(SalesHeaderRef));
        DocumentType.TestField("Report ID");

        SalesHeader.SetRange("Document Type", SalesHeader."Document Type");
        SalesHeader.SetRange("No.", SalesHeader."No.");

        Report.RunModal(DocumentType."Report ID", ReqWindow, SystemPrinter, SalesHeader);

        SalesHeaderRef.Close;
    end;

    procedure PrintPurchDocument(PurchHeader: Record "Purchase Header"; ReqWindow: Boolean; SystemPrinter: Boolean)
    var
        DocumentType: Record "Document Type";
        PurchHeaderRef: RecordRef;
    begin

        PurchHeaderRef.Open(Database::"Purchase Header");
        PurchHeaderRef.GetTable(PurchHeader);
        DocumentType.Get(FindDocumentType(PurchHeaderRef));
        DocumentType.TestField("Report ID");

        PurchHeader.SetRange("Document Type", PurchHeader."Document Type");
        PurchHeader.SetRange("No.", PurchHeader."No.");

        Report.RunModal(DocumentType."Report ID", ReqWindow, SystemPrinter, PurchHeader);

        PurchHeaderRef.Close;
    end;

    procedure PrintDocumentsText(var DocPrint: Record "Print Document")
    var
        DocumentPrintRec: Record "Print Document";
    begin
        //PrintDocumentsText

        DocumentPrintRec.Reset;
        DocumentPrintRec.SetRange("Print of", DocPrint."Print of");
        DocumentPrintRec.SetRange("Ref. Type", DocPrint."Ref. Type");
        DocumentPrintRec.SetRange("Ref. No.", DocPrint."Ref. No.");
        if DocumentPrintRec.Find('-') then
            Page.RunModal(Page::"Print Document List (INT)", DocumentPrintRec)
        else
            NewDocumentText(DocPrint);
    end;

    procedure ConvStr(TableID: Integer; var TableFieldRef: FieldRef; Str: Text[1024])
    var
        "Field": Record "Field";
        VarInteger: Integer;
        VarText: Text[1024];
        VarCode: Code[1024];
        VarDecimal: Decimal;
        VarOption: Option;
        VarBoolean: Boolean;
        VarDate: Date;
        VarTime: Time;
        VarBigInteger: BigInteger;
        VarDuration: Duration;
        VarDateTime: DateTime;
    begin
        // ConvStr

        Field.Get(TableID, TableFieldRef.Number);

        case Field.Type of
            Field.Type::Integer:
                begin
                    Evaluate(VarInteger, Str);
                    TableFieldRef.Value := VarInteger;
                end;
            Field.Type::Text:
                begin
                    Evaluate(VarText, Str);
                    TableFieldRef.Value := VarText;
                end;
            Field.Type::Code:
                begin
                    Evaluate(VarCode, Str);
                    TableFieldRef.Value := VarCode;
                end;
            Field.Type::Decimal:
                begin
                    Evaluate(VarDecimal, Str);
                    TableFieldRef.Value := VarDecimal;
                end;
            Field.Type::Option:
                begin
                    if (Str <> '') then begin
                        Evaluate(VarOption, Str);
                        TableFieldRef.Value := VarOption;
                    end else begin
                        TableFieldRef.Value := 0;
                    end;
                end;
            Field.Type::Boolean:
                begin
                    Evaluate(VarBoolean, Str);
                    TableFieldRef.Value := VarBoolean;
                end;
            Field.Type::Date:
                begin
                    Evaluate(VarDate, Str);
                    TableFieldRef.Value := VarDate;
                end;
            Field.Type::Time:
                begin
                    Evaluate(VarTime, Str);
                    TableFieldRef.Value := VarTime;
                end;
            Field.Type::BigInteger:
                begin
                    Evaluate(VarBigInteger, Str);
                    TableFieldRef.Value := VarBigInteger;
                end;
            Field.Type::Duration:
                begin
                    Evaluate(VarDuration, Str);
                    TableFieldRef.Value := VarDuration;
                end;
            Field.Type::DateTime:
                begin
                    Evaluate(VarDateTime, Str);
                    TableFieldRef.Value := VarDateTime;
                end;
        end;
    end;

    procedure NewDocumentText(var DocPrint: Record "Print Document")
    var
        DocumentType: Record "Document Type";
        Text0001: Label 'Please select the %1.';
        Text0002: Label 'must not be empty';
    begin
        //NewDocumentText

        case DocPrint."Print of" of
            "Print Of (INT)"::"Purchase Document", "Print Of (INT)"::"Purch Invoice", "Print Of (INT)"::"Purchase Receipt", "Print Of (INT)"::"Purchase Cr. Memo":
                DocumentType.SetFilter(DocumentType."Document Usage", '%1|%2',
                                                       DocumentType."Document Usage"::"Purchase Document",
                                                       DocumentType."Document Usage"::"Purchase Print Document");
            "Print Of (INT)"::"Sales Document", "Print Of (INT)"::"Sales Invoice", "Print Of (INT)"::"Sales Shipment", "Print Of (INT)"::"Sales Cr. Memo":
                DocumentType.SetFilter(DocumentType."Document Usage", '%1|%2',
                                                       DocumentType."Document Usage"::"Sales Document",
                                                       DocumentType."Document Usage"::"Sales Print Document");
        end;


        if Page.RunModal(50000, DocumentType) = Action::LookupOK then begin
            if DocumentType."Nos." = '' then
                DocumentType.FieldError(DocumentType."Nos.", Text0002);
            if DocumentType."Report ID" = 0 then
                DocumentType.FieldError(DocumentType."Report ID", Text0002);
            DocPrint."Receiver Type" := DocumentType."Receiver Type";
            DocPrint.Validate("Document Type", DocumentType.Code);
            DocPrint.Insert(true);
            Page.Run(50001, DocPrint);
        end;
    end;

    procedure ChangeExpirationDate(ItemNo: Code[20]; LotNo: Code[20]; ExpirationDate: Text[30])
    var
        ItemLedgentry: Record "Item Ledger Entry";
    begin
        ItemLedgentry.SetRange("Item No.", ItemNo);
        ItemLedgentry.SetRange("Lot No.", LotNo);
        if ItemLedgentry.FindFirst then
            repeat
                Evaluate(ItemLedgentry."Expiration Date", ExpirationDate);
                ItemLedgentry.Modify;
            until ItemLedgentry.Next = 0;
    end;

    procedure EmailPrintDocument(PrintDocument: Record "Print Document")
    var
        DocumentType: Record "Document Type";
        DocumentMailing: Codeunit "Document-Mailing";
        AttachmentFilePath: Text[250];
    begin
        DocumentType.Get(PrintDocument."Document Type");
        PrintDocument.SetRecFilter();
        SendPrintDocReportAsEmail(PrintDocument);
    end;

    procedure SendPrintDocReportAsEmail(var PrintDocument: Record "Print Document")
    var
        FileMgt: Codeunit "File Management";
        ServerAttachmentFilePath: Text;
        OutStream: OutStream;
        InsStream: InStream;
        RecRef: RecordRef;
        TempBlob: Codeunit "Temp Blob";
        Customer: Record Customer;
        Email: Codeunit Email;
        EmailMsG: Codeunit "Email Message";
        Recipients: List of [Text];
        CCs: List of [Text];
        DocType: Record "Document Type";
        MailSubject: Label '%1 %2';
        EmailBody: Text;

    begin
        IF PrintDocument."E-mail" <> '' then begin
            TempBlob.CreateOutStream(OutStream);
            RecRef.GetTable(PrintDocument);
            DocType.GET(PrintDocument."Document Type");
            Report.SaveAs(DocType."Report ID", '', ReportFormat::Pdf, OutStream, RecRef);
            //hier will ich den PDF mit neuen Tools auf SFTP Server exportieren. Wie geht das?

            IF DocType."Email Receiver" <> '' then
                Recipients.Add(DocType."Email Receiver")
            else
                Recipients.Add(PrintDocument."E-mail");
            EmailMsG.Create(Recipients, StrSubstNo(MailSubject, DocType."Pdf Name", PrintDocument."Ref. No."), ConvertBlobToText(DocType), true);
            TempBlob.CreateInStream(InsStream);
            EmailMsG.AddAttachment(StrSubstNo(MailSubject, DocType."Pdf Name", PrintDocument."Ref. No.") + '.pdf', 'pdf', InsStream);
            Email.OpenInEditor(EmailMsG);
        end;
    end;

    procedure SendFileAsEmailAttach(PrintDocument: Record "Print Document"; InStream: InStream; AttachmentFileName: Text)
    var
        DocType: Record "Document Type";
        EmailMsG: Codeunit "Email Message";
        Email: Codeunit Email;
        Recipients: List of [Text];
        MailSubject: Label '%1 %2';
        EmailBocy: OutStream;
    begin
        DocType.get(PrintDocument."Document Type");
        IF DocType."Email Receiver" <> '' then
            Recipients.Add(DocType."Email Receiver")
        else
            Recipients.Add(PrintDocument."E-mail");
        // EmailMsG.Create(Recipients, StrSubstNo(MailSubject, PrintDocument."Print of", PrintDocument."Ref. No."), 'Budy', true);
        // EmailMsG.AddAttachment(StrSubstNo(MailSubject, PrintDocument."Print of", PrintDocument."Ref. No."), 'pdf', InStream);
        EmailMsG.Create(Recipients, StrSubstNo(MailSubject, DocType."Email Title", PrintDocument."Ref. No."), ConvertBlobToText(DocType), true);
        EmailMsG.AddAttachment(AttachmentFileName, '', InStream);
        // Email.RetrieveEmails();

        Email.OpenInEditor(EmailMsG);

    end;

    procedure downloadPrintDocReport(var PrintDocument: Record "Print Document"; AttachmentFileName: Text): Text
    var
        FileMgt: Codeunit "File Management";
        ServerAttachmentFilePath: Text;
        OutStream: OutStream;
        InsStream: InStream;
        RecRef: RecordRef;
        TempBlob: Codeunit "Temp Blob";
        Customer: Record Customer;
        DocType: Record "Document Type";
        Filename: text;
        ServerFilename: Text;
        AttachFileName: Label '%1 %2';
        ExportCsvDatei: Codeunit "Export CSV Datei";

    begin
        TempBlob.CreateOutStream(OutStream);
        RecRef.GetTable(PrintDocument);
        DocType.GET(PrintDocument."Document Type");
        Report.SaveAs(DocType."Report ID", '', ReportFormat::Pdf, OutStream, RecRef);
        TempBlob.CreateInStream(InsStream);
        ExportCsvDatei.SendFileToFTPServer(TempBlob, StrSubstNo(AttachmentFileName, DocType."Pdf Name", PrintDocument."Ref. No.", 'pdf'), 'DEHN');
        // SendFileAsEmailAttach(PrintDocument, InsStream, StrSubstNo(AttachmentFileName, DocType."Pdf Name", PrintDocument."Ref. No.") + '.pdf');
        /*
        ServerFilename := DocType."FTP Adresse" + DocType."Pdf Name" + '.pdf';
        Filename := FileMgt.GetFileName(ServerFilename);
        FileMgt.BLOBExport(TempBlob, ServerFilename, true);
        */
        // FileMgt.BLOBExport(TempBlob, DocType."FTP Adresse" + DocType."Pdf Name" + '.pdf', true);
        /*
                TempBlob.CreateInStream(InsStream);
                ServerAttachmentFilePath := DocType."Pdf Name" + '.pdf';
                DownloadFromStream(InsStream, 'Export', '', '', ServerAttachmentFilePath);
                exit(ServerAttachmentFilePath);
        */
    end;

    procedure TestCalcFields(SalesHeader: Record "Sales Header")
    var
        SalesLine: Record "Sales Line";
    begin
        salesLine.setrange("Document Type", SalesHeader."Document Type"::Order);
        Salesline.setrange("Document No.", SalesHeader."No.");
        SalesLine.CalcSums("Amount Including VAT");

    end;

    procedure TranslateUnitOfMeasure(var UnitOfMeasure: Record "Unit of Measure"; LanguageCode: Code[10])
    var
        UnitOfMeasureTranslation: Record "Unit of Measure Translation";
    begin

        IF UnitofMeasureTranslation.GET(UnitofMeasure.Code, LanguageCode) THEN
            UnitofMeasure.Description := UnitofMeasureTranslation.Description;
    end;

    procedure CreateNewBatch(SalesHeader: Record "Sales Header")
    var
        Batch: Record Batch;
        SalesLine: Record "Sales Line";
    begin

        Batch.Code := SalesHeader."No.";
        Batch.Name := STRSUBSTNO('Auftrag %1', SalesHeader."No.");
        IF Batch.INSERT(TRUE) THEN;
        SalesLine.SuspendStatusCheck(true);
        SalesLine.SETRANGE("Document Type", SalesHeader."Document Type");
        SalesLine.SETRANGE("Document No.", SalesHeader."No.");
        SalesLine.SETRANGE(Type, SalesLine.Type::"G/L Account");
        IF SalesLine.FINDFIRST THEN
            REPEAT
                SalesLine."Batch No. (INT)" := SalesHeader."No.";
                SalesLine.MODIFY;
            UNTIL SalesLine.NEXT = 0;
    end;
    // procedure SendCsvFile(var PrintDoc: Record "Print Document")
    // var
    //   Selection: Integer;
    //   FtpMgt: Codeunit exportcs
    // begin

    // end;


    procedure ConvertBlobToText(DocType: Record "Document Type"): Text
    var
        InStream: InStream;
        TempText: Text;
        TextField: Text;
        UserSetup: Record "User Setup";
        SalesPurcher: Record "Salesperson/Purchaser";
    begin
        // Sicherstellen, dass das BLOB-Feld nicht leer ist
        DocType.CalcFields("Email Body Text");
        if not DocType."Email Body Text".HasValue then
            exit('');

        // BLOB-Feld in einen InStream konvertieren
        DocType."Email Body Text".CreateInStream(InStream, TextEncoding::UTF8);

        // InStream in Text umwandeln
        TempText := '';
        while not InStream.EOS do begin
            InStream.ReadText(TempText);
            TextField := TextField + TempText;
        end;
        IF UserSetup.Get(UserId) then begin
            IF UserSetup."Salespers./Purch. Code" <> '' then
                IF Not SalesPurcher.Get(UserSetup."Salespers./Purch. Code") then
                    SalesPurcher.Init;
        end;
        exit(StrSubstNo(TextField, SalesPurcher.Name, SalesPurcher."Phone No.", SalesPurcher."E-Mail"));
    end;

    procedure CopyBatchNoToGLEntry()
    var
        GLEntry: Record "G/L Entry";
        SalesInvoiceLine: Record "Sales Invoice Line";
        PurchInvoiceLine: Record "Purch. Inv. Line";
        SalesCrMemoLine: Record "Sales Cr.Memo Line";
        PurchCrMemoLine: Record "Purch. Cr. Memo Line";
        SalesInvoiceHeader: Record "Sales Invoice Header";
        PurchInvoiceHeader: Record "Purch. Inv. Header";
        SalesCrMemoHeader: Record "Sales Cr.Memo Header";
        PurchCrMemoHeader: Record "Purch. Cr. Memo Hdr.";
        BatchNo: Code[20];
        SalesInvHeader: record "Sales Invoice Header";
        PurchInvHeader: record "Purch. Inv. Header";
        SalesCrMemoHeader2: Record "Sales Cr.Memo Header";
        PurchCrMemoHeader2: Record "Purch. Cr. Memo Hdr.";
    begin
        BatchNo := '';
        SalesInvoiceHeader.Setrange("Exported To GL/Entry (INT)", false);
        IF SalesInvoiceHeader.FindSet() then
            repeat
                SalesInvoiceLine.Setrange("Document No.", SalesInvoiceHeader."No.");
                SalesInvoiceLine.SetFilter("Batch No. (INT)", '<>%1', '');
                SalesInvoiceLine.SetFilter(Type, '<>%1', SalesInvoiceLine.Type::" ");
                SalesInvoiceLine.SetFilter("No.", '<>%1', '');
                IF SalesInvoiceLine.FindSet() then
                    BatchNo := SalesInvoiceLine."Batch No. (INT)";
                IF BatchNo <> '' then begin
                    GLEntry.SetRange("Document Type", GLEntry."Document Type"::Invoice);
                    GLEntry.SetRange("Document No.", SalesInvoiceLine."Document No.");
                    GLEntry.SetRange("Posting Date", SalesInvoiceLine."Posting Date");
                    IF GLEntry.FindSet() then
                        GLEntry.ModifyAll("Batch No. (INT)", BatchNo);
                    SalesInvHeader.GET(SalesInvoiceHeader.RecordId);
                    SalesInvHeader."Exported To GL/Entry (INT)" := true;
                    SalesInvHeader.MODIFY;
                end;
            until SalesInvoiceHeader.Next() = 0;
        BatchNo := '';
        SalesCrMemoHeader.SetRange("Exported To GL/Entry (INT)", false);
        IF SalesCrMemoHeader.FindSet() then
            repeat
                SalesCrMemoLine.SetRange("Document No.", SalesCrMemoHeader."No.");
                SalesCrMemoLine.SetFilter("Batch No. (INT)", '<>%1', '');
                SalesCrMemoLine.SetFilter(Type, '<>%1', SalesCrMemoLine.Type::" ");
                SalesCrMemoLine.SetFilter("No.", '<>%1', '');
                IF SalesCrMemoLine.FindSet() then
                    BatchNo := SalesCrMemoLine."Batch No. (INT)";
                IF BatchNo <> '' then begin
                    GLEntry.SetRange("Document Type", GLEntry."Document Type"::"Credit Memo");
                    GLEntry.SetRange("Document No.", SalesCrMemoLine."Document No.");
                    GLEntry.SetRange("Posting Date", SalesCrMemoLine."Posting Date");
                    IF GLEntry.FindSet() then
                        GLEntry.ModifyAll("Batch No. (INT)", BatchNo);
                    SalesCrMemoHeader2.GET(SalesCrMemoHeader.RecordId);
                    SalesCrMemoHeader2."Exported To GL/Entry (INT)" := true;
                    SalesCrMemoHeader2.MODIFY;
                end;
            until SalesCrMemoHeader.Next() = 0;
        BatchNo := '';
        PurchInvoiceHeader.Setrange("Exported To GL/Entry (INT)", false);
        IF PurchInvoiceHeader.FindSet() then
            repeat
                PurchInvoiceLine.Setrange("Document No.", PurchInvoiceHeader."No.");
                PurchInvoiceLine.SetFilter("Batch No. (INT)", '<>%1', '');
                PurchInvoiceLine.SetFilter(Type, '<>%1', PurchInvoiceLine.Type::" ");
                PurchInvoiceLine.SetFilter("No.", '<>%1', '');
                IF PurchInvoiceLine.FindSet() then
                    BatchNo := PurchInvoiceLine."Batch No. (INT)";
                IF BatchNo <> '' then begin
                    GLEntry.SetRange("Document Type", GLEntry."Document Type"::Invoice);
                    GLEntry.SetRange("Document No.", PurchInvoiceLine."Document No.");
                    GLEntry.SetRange("Posting Date", PurchInvoiceLine."Posting Date");
                    IF GLEntry.FindSet() then
                        GLEntry.ModifyAll("Batch No. (INT)", BatchNo);
                    PurchInvHeader.GET(PurchInvoiceHeader.RecordId);
                    PurchInvHeader."Exported To GL/Entry (INT)" := true;
                    PurchInvHeader.MODIFY;
                end;
            until PurchInvoiceHeader.Next() = 0;
        BatchNo := '';
        PurchCrMemoHeader.SetRange("Exported To GL/Entry (INT)", false);
        IF PurchCrMemoHeader.FindSet() then
            repeat
                PurchCrMemoLine.Setrange("Document No.", PurchCrMemoHeader."No.");
                PurchCrMemoLine.SetFilter("Batch No. (INT)", '<>%1', '');
                PurchCrMemoLine.SetFilter(Type, '<>%1', PurchCrMemoLine.Type::" ");
                PurchCrMemoLine.SetFilter("No.", '<>%1', '');
                IF PurchCrMemoLine.FindSet() then
                    BatchNo := PurchCrMemoLine."Batch No. (INT)";
                IF BatchNo <> '' then begin
                    GLEntry.SetRange("Document Type", GLEntry."Document Type"::"Credit Memo");
                    GLEntry.SetRange("Document No.", PurchCrMemoLine."Document No.");
                    GLEntry.SetRange("Posting Date", PurchCrMemoLine."Posting Date");
                    IF GLEntry.FindSet() then
                        GLEntry.ModifyAll("Batch No. (INT)", BatchNo);
                    PurchCrMemoHeader2.GET(PurchCrMemoHeader.RecordId);
                    PurchCrMemoHeader2."Exported To GL/Entry (INT)" := true;
                    PurchCrMemoHeader2.MODIFY;
                end;
            until PurchCrMemoHeader.Next() = 0;
    end;

    procedure ConvertBlobToText(DocType: Record "Document Type"): Text
    var
        InStream: InStream;
        TempText: Text;
        TextField: Text;
        UserSetup: Record "User Setup";
        SalesPurcher: Record "Salesperson/Purchaser";
    begin
        // Sicherstellen, dass das BLOB-Feld nicht leer ist
        DocType.CalcFields("Email Body Text");
        if not DocType."Email Body Text".HasValue then
            exit('');

        // BLOB-Feld in einen InStream konvertieren
        DocType."Email Body Text".CreateInStream(InStream, TextEncoding::UTF8);

        // InStream in Text umwandeln
        TempText := '';
        while not InStream.EOS do begin
            InStream.ReadText(TempText);
            TextField := TextField + TempText;
        end;
        IF UserSetup.Get(UserId) then begin
            IF UserSetup."Salespers./Purch. Code" <> '' then
                IF Not SalesPurcher.Get(UserSetup."Salespers./Purch. Code") then
                    SalesPurcher.Init;
        end;
        exit(StrSubstNo(TextField, SalesPurcher.Name, SalesPurcher."Phone No.", SalesPurcher."E-Mail"));

    end;

}

