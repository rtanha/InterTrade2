page 50003 "Print Document List (INT)"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Documents;
    SourceTable = "Print Document";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Document No."; Rec."Document No.")
                {
                    ToolTip = 'Specifies the value of the Document No. field.', Comment = '%';
                }
                field("Document Type"; Rec."Document Type")
                {
                    ToolTip = 'Specifies the value of the Document Type field.', Comment = '%';
                }
                field("Print of"; Rec."Print of")
                {
                    ToolTip = 'Specifies the value of the Print of field.', Comment = '%';
                }
                field("Ref. Type"; Rec."Ref. Type")
                {
                    ToolTip = 'Specifies the value of the Ref. Type field.', Comment = '%';
                }
                field("Ref. No."; Rec."Ref. No.")
                {
                    ToolTip = 'Specifies the value of the Ref. No. field.', Comment = '%';
                }
                field("Receiver Type"; Rec."Receiver Type")
                {
                    ToolTip = 'Specifies the value of the Receiver Type field.', Comment = '%';
                }
                field("Receiver No."; Rec."Receiver No.")
                {
                    ToolTip = 'Specifies the value of the Receiver No. field.', Comment = '%';
                }
                field("No. Series"; Rec."No. Series")
                {
                    ToolTip = 'Specifies the value of the No. Series field.', Comment = '%';
                }
                field("Document Date"; Rec."Document Date")
                {
                    ToolTip = 'Specifies the value of the Document Date field.', Comment = '%';
                }
                field(Name; Rec.Name)
                {
                    ToolTip = 'Specifies the value of the Name field.', Comment = '%';
                }
                field("Name 2"; Rec."Name 2")
                {
                    ToolTip = 'Specifies the value of the Name 2 field.', Comment = '%';
                }
                field(Address; Rec.Address)
                {
                    ToolTip = 'Specifies the value of the Address field.', Comment = '%';
                }
                field("Address 2"; Rec."Address 2")
                {
                    ToolTip = 'Specifies the value of the Address 2 field.', Comment = '%';
                }
                field(City; Rec.City)
                {
                    ToolTip = 'Specifies the value of the City field.', Comment = '%';
                }
                field("Post Code"; Rec."Post Code")
                {
                    ToolTip = 'Specifies the value of the Post Code field.', Comment = '%';
                }
                field(County; Rec.County)
                {
                    ToolTip = 'Specifies the value of the County field.', Comment = '%';
                }
                field("Country Code"; Rec."Country Code")
                {
                    ToolTip = 'Specifies the value of the Country Code field.', Comment = '%';
                }
                field(Contact; Rec.Contact)
                {
                    ToolTip = 'Specifies the value of the Contact field.', Comment = '%';
                }
                field("E-mail"; Rec."E-mail")
                {
                    ToolTip = 'Specifies the value of the E-mail field.', Comment = '%';
                }
                field("Fax No."; Rec."Fax No.")
                {
                    ToolTip = 'Specifies the value of the Fax No. field.', Comment = '%';
                }
                field(Priority; Rec.Priority)
                {
                    ToolTip = 'Specifies the value of the Priority field.', Comment = '%';
                }
                field("Language Code"; Rec."Language Code")
                {
                    ToolTip = 'Specifies the value of the Language Code field.', Comment = '%';
                }
                field("No. Printed"; Rec."No. Printed")
                {
                    ToolTip = 'Specifies the value of the No. Printed field.', Comment = '%';
                }
                field("Business Partner Role No."; Rec."Business Partner Role No.")
                {
                    ToolTip = 'Specifies the value of the Business Partner Role No. field.', Comment = '%';
                }
                field("Shipping Agent Code"; Rec."Shipping Agent Code")
                {
                    ToolTip = 'Specifies the value of the Shipping Agent Code field.', Comment = '%';
                }
                field("Location Code"; Rec."Location Code")
                {
                    ToolTip = 'Specifies the value of the Location Code field.', Comment = '%';
                }
                field("Location filter"; Rec."Location filter")
                {
                    ToolTip = 'Specifies the value of the Lagerortfilter field.', Comment = '%';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(NewDocument)
            {
                CaptionML = ENU = 'New Document', DEU = 'Neuer Beleg';
                ApplicationArea = All;
                Image = NewDocument;
                trigger OnAction()
                var
                    PrintDocument: Record "Print Document";
                begin
                    PrintDocument.Init();
                    PrintDocument."Document No." := '';
                    PrintDocument."Document Type" := Rec."Document Type";
                    PrintDocument."Print of" := Rec."Print of";
                    PrintDocument."Ref. Type" := rec."Ref. Type";
                    PrintDocument."Ref. No." := rec."Ref. No.";
                    NewDocumentText(PrintDocument);
                end;
            }
            action(ShowCard)
            {
                ApplicationArea = all;
                CaptionML = ENU = 'Card', DEU = 'Karte';
                Image = Card;
                trigger OnAction()
                var
                    PrintDocumentPage: Page "Print Document (INT)";
                    printDocument: Record "Print Document";
                begin
                    printDocument.Get(Rec.RecordId);
                    printDocument.SetRecFilter();
                    PrintDocumentPage.SetTableView(printDocument);
                    PrintDocumentPage.RunModal()
                end;

            }
        }
        area(Promoted)
        {
            actionref(NewProm; NewDocument)
            {

            }
            actionref(CardProm; ShowCard)
            {

            }

        }
    }

    var
        myInt: Integer;

    PROCEDURE GetDocumentType(NoSeries: Code[20]): Code[20];
    VAR
        DocumentType: Record "Document Type";
    BEGIN
        DocumentType.SETCURRENTKEY("Nos.");
        DocumentType.SETRANGE("Nos.", NoSeries);
        DocumentType.FIND('-');
        EXIT(DocumentType.Code);
    END;

    PROCEDURE PrintSalesDocument(SalesHeader: Record "Sales Header"; ReqWindow: Boolean; SystemPrinter: Boolean);
    VAR
        DocumentType: Record "Document Type";
        SalesHeaderRef: RecordRef;
        SalesHeaderFieldRef: FieldRef;
    BEGIN

        SalesHeaderRef.OPEN(DATABASE::"Sales Header");
        SalesHeaderRef.GETTABLE(SalesHeader);

        //   DocumentType.GET(FindDocumentType(SalesHeaderRef));
        DocumentType.TESTFIELD("Report ID");

        SalesHeader.SETRANGE("Document Type", SalesHeader."Document Type");
        SalesHeader.SETRANGE("No.", SalesHeader."No.");

        REPORT.RUNMODAL(DocumentType."Report ID", ReqWindow, SystemPrinter, SalesHeader);

        SalesHeaderRef.CLOSE;
    END;

    PROCEDURE PrintPurchDocument(PurchHeader: Record "Purchase Header"; ReqWindow: Boolean; SystemPrinter: Boolean);
    VAR
        DocumentType: Record "Document Type";
        PurchHeaderRef: RecordRef;
    BEGIN

        PurchHeaderRef.OPEN(DATABASE::"Purchase Header");
        PurchHeaderRef.GETTABLE(PurchHeader);
        //   DocumentType.GET(FindDocumentType(PurchHeaderRef));
        DocumentType.TESTFIELD("Report ID");

        PurchHeader.SETRANGE("Document Type", PurchHeader."Document Type");
        PurchHeader.SETRANGE("No.", PurchHeader."No.");

        REPORT.RUNMODAL(DocumentType."Report ID", ReqWindow, SystemPrinter, PurchHeader);

        PurchHeaderRef.CLOSE;
    END;

    PROCEDURE PrintDocumentsText(VAR DocPrint: Record "Print Document");
    VAR
        DocumentPrintRec: Record "Print Document";
    BEGIN
        //PrintDocumentsText

        DocumentPrintRec.RESET;
        DocumentPrintRec.SETRANGE("Print of", DocPrint."Print of");
        DocumentPrintRec.SETRANGE("Ref. Type", DocPrint."Ref. Type");
        DocumentPrintRec.SETRANGE("Ref. No.", DocPrint."Ref. No.");
        IF DocumentPrintRec.FIND('-') THEN
            PAGE.RUNMODAL(PAGE::"Print Document List (INT)", DocumentPrintRec)
        ELSE
            NewDocumentText(DocPrint);
    END;

    PROCEDURE NewDocumentText(VAR DocPrint: Record "Print Document");
    VAR
        DocumentType: Record "Document Type";
        NoSeriesManagement: Codeunit "No. Series";
        Text0001: Label 'Bitte wählen Sie eine %1 aus.';
        Text0002: Label 'darf nicht leer sein';
    BEGIN

        CASE DocPrint."Print of" OF
            0, 2, 4, 6, 8:
                DocumentType.SETFILTER(DocumentType."Document Usage", '%1|%2',
                            DocumentType."Document Usage"::"Purchase Document",
                            DocumentType."Document Usage"::"Purchase Print Document");
            1, 3, 5, 7, 9:
                DocumentType.SETFILTER(DocumentType."Document Usage", '%1|%2',
                            DocumentType."Document Usage"::"Sales Document",
                            DocumentType."Document Usage"::"Sales Print Document");
        END;


        IF PAGE.RUNMODAL(50000, DocumentType) = ACTION::LookupOK THEN BEGIN
            IF DocumentType."Nos." = '' THEN
                DocumentType.FIELDERROR(DocumentType."Nos.", Text0002);
            IF DocumentType."Report ID" = 0 THEN
                DocumentType.FIELDERROR(DocumentType."Report ID", Text0002);
            DocPrint."Receiver Type" := DocumentType."Receiver Type";
            DocPrint.VALIDATE("Document Type", DocumentType.Code);
        END;
        DocPrint."Document No." := '';
        DocPrint.INSERT(TRUE);
        PAGE.RUN(50001, DocPrint);
    END;

}