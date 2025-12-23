table 50003 "Document Type"
{
    CaptionML = ENU = 'Document Type', DEU = 'Belegart';
    DrillDownPageID = "Document Type View (INT)";
    LookupPageID = "Document Type View (INT)";

    fields
    {
        field(1; "Code"; Code[20])
        {
            NotBlank = true;
        }
        field(2; Description; Text[30])
        {
            CaptionML = ENU = 'Description', DEU = 'Beschreibung';
        }
        field(3; "Description 2"; Text[30])
        {
            CaptionML = ENU = 'Description 2', DEU = 'Beschreibung 2';
        }
        field(4; "Sales Document Type"; Option)
        {
            CaptionML = ENU = 'Sales Document Type', DEU = 'Verkauf Belegart';
            OptionCaptionML = ENU = ' ,Quote,Order,Invoice,Credit Memo,Blanket Order,Return Order', DEU = ' ,Angebot,Auftrag,Rechnung,Gutschrift,Rahmenauftrag,Reklamation';
            OptionMembers = " ",Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order";
        }
        field(5; "Purch. Document Type"; Option)
        {
            CaptionML = ENU = 'Purch. Document Type', DEU = 'Einkauf Belegart';
            OptionCaptionML = ENU = ' ,Quote,Order,Invoice,Credit Memo,Blanket Order,Return Order', DEU = ' ,Angebot,Bestellung,Rechnung,Gutschrift,Rahmenbestellung,Reklamation';
            OptionMembers = " ",Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order";
        }
        field(6; "Nos."; Code[10])
        {
            CaptionML = ENU = 'Nos.', DEU = 'Nummernserie';
            TableRelation = "No. Series";
        }
        field(7; "Page ID"; Integer)
        {
            BlankZero = true;
            TableRelation = AllObj."Object ID" WHERE("Object Type" = CONST(Page));
        }
        field(8; "Report ID"; Integer)
        {
            TableRelation = AllObj."Object ID" WHERE("Object Type" = CONST(Report));
        }
        field(9; "Business Partner Type Code"; Code[20])
        {
            CaptionML = ENU = 'Business Partner Type Code', DEU = 'Geschäftspartnertype Code';
            TableRelation = "Business Partner Type";
        }
        field(20; "Receiver Type"; Option)
        {
            CaptionML = ENU = 'Receiver Type', DEU = 'Empfänger';
            OptionCaptionML = ENU = 'Buy/Sell,Pay/Bill,Shipment,Location,Shipping Agent,Frontier Forwarder,Settlement Central Office,Bank', DEU = 'Verk./Eink.,Zahl/Rech.,Lieferung,Lagerort,Zusteller,Grenzspeditor,Abrechnungszentrale,Bank';
            OptionMembers = "Buy/Sell","Pay/Bill",Shipment,Location,"Shipping Agent","Frontier Forwarder","Settlement Central Office",Bank;
        }
        field(21; "Business Process Instance ID"; Integer)
        {
            FieldClass = FlowFilter;
        }
        field(22; "No. of Records"; Integer)
        {
        }
        field(23; "Copy To Posted Documents"; Boolean)
        {
            CaptionML = ENU = 'Copy To Posted Documents', DEU = 'In geb. Belege übernehmen';
        }
        field(24; "Copy To Posted Shpt./Rcpt."; Boolean)
        {
            CaptionML = ENU = 'Copy To Posted Shpt./Rcpt.', DEU = 'In geb. Lieferungen übernehmen';
        }
        field(25; "Document Usage"; Option)
        {
            CaptionML = ENU = 'Document Usage', DEU = 'Belegverwendung';
            OptionCaptionML = ENU = 'Purchase Document,Purchase Print Document,Sales Document,Sales Print Document', DEU = 'Einkaufsbeleg,Einkaufsdruckbeleg,Verkaufsbeleg,Verkaufsdruckbeleg';
            OptionMembers = "Purchase Document","Purchase Print Document","Sales Document","Sales Print Document";
        }
        field(26; "Pdf Name"; Text[30])
        {
            CaptionML = ENU = 'Pdf Name', DEU = 'Pdf Name';
        }
        field(50000; "FTP Adresse"; Text[250])
        {
        }
        field(50001; "FTP User"; Text[50])
        {
        }
        field(50002; "FTP Kennwort"; Text[50])
        {
        }
        field(50003; "Lagerort 1"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = Location.Code;
        }
        field(50004; "Lagerort 1 Export-Wert"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50005; "Lagerort 2"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = Location.Code;
        }
        field(50006; "Lagerort 2 Export-Wert"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50007; "Lagerort 3"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = Location.Code;
        }
        field(50008; "Lagerort 3 Export-Wert"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50010; "Item Export File Name"; Text[250])
        {
            Caption = 'Artikel Export Dateiname';
            DataClassification = CustomerContent;
        }
        field(50011; "Ship. Lines File Name"; Text[250])
        {
            Caption = 'Lieferzeilen Export Dateiname';
            DataClassification = CustomerContent;
        }
        field(50020; "Email Body Text"; Blob)
        {
            Caption = 'Email Nachricht';
            DataClassification = CustomerContent;
        }
        field(50021; "Email Title"; Text[100])
        {
            Caption = 'Email Betreff';
            DataClassification = CustomerContent;
        }
        field(50022; "Send Type"; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = " ","FTP","Email";
            OptionCaption = ' ,FTP,Email';
        }
        field(50023; "Email Receiver"; Text[100])
        {
            Caption = 'Email Receiver';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Code")
        {
        }
        key(Key2; "Nos.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        if not Confirm('Wollen Sie wirklich diesen Belegart löschen', false) then
            Error('Vorgang wurde abgebrochen');
    end;

    procedure SetEmailBody(NewEmailBody: Text)
    var
        OutStream: OutStream;
    begin
        Clear("Email Body Text");
        "Email Body Text".CreateOutStream(OutStream, TEXTENCODING::UTF8);
        OutStream.WriteText(NewEmailBody);
        Modify();
    end;

    procedure GetEmailBody() EmailBody: Text
    var
        TypeHelper: Codeunit "Type Helper";
        InStream: InStream;
    begin
        CalcFields("Email Body Text");
        "Email Body Text".CreateInStream(InStream, TEXTENCODING::UTF8);
        exit(TypeHelper.TryReadAsTextWithSepAndFieldErrMsg(InStream, TypeHelper.LFSeparator(), FieldName("Email Body Text")));
    end;
}

