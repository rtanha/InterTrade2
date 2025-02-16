table 50004 "Print Document"
{

    CaptionML = ENU = 'Print Document', DEU = 'Druckbeleg';
    DrillDownPageID = "Print Document List (INT)";
    LookupPageID = "Print Document List (INT)";

    fields
    {
        field(1; "Document No."; Code[20])
        {
            CaptionML = ENU = 'Document No.', DEU = 'Belegnr.';
            Editable = false;
        }
        field(2; "Document Type"; Code[20])
        {
            CaptionML = ENU = 'Document Type', DEU = 'Belegart';
            Editable = false;
            TableRelation = "Document Type".Code;

            trigger OnValidate()
            begin
                DocumentType.Get("Document Type");
                case "Print of" of

                    "Print of"::"Purchase Document":
                        GetFieldFromPurchaseHeader;
                    "Print of"::"Sales Document":
                        GetFieldFromSalesHeader;
                    "Print of"::"Purch Invoice":
                        GetFieldFromPurchInvoiceHeader;
                    "Print of"::"Sales Invoice":
                        GetFieldFromSalesInvoiceHeader;
                    "Print of"::"Purchase Receipt":
                        GetFieldFromPurchReptHeader;
                    "Print of"::"Sales Shipment":
                        GetFieldFromSalesShpmHeader;
                    "Print of"::"Purchase Cr. Memo":
                        GetFieldFromPurchCrMemoHeader;
                    "Print of"::"Sales Cr. Memo":
                        GetFieldFromSalesCrMemoHeader;

                end;
            end;
        }
        field(4; "Print of"; Option)
        {
            CaptionML = ENU = 'Print of', DEU = 'Ausdruck';
            Editable = false;
            OptionCaptionML = ENU = 'Purchase Document,Sales Document,,,Purchase Invoice,Sales Invoice,Purchase Receipt,Sales Shipment,Purchase Cr. Memo,Sales Cr. Memo', DEU = 'Einkaufsbeleg,Verkaufsbeleg,,,EK-Rechnung,VK-Rechnung,geb. EK-Lieferung,geb. VK-Lieferung,geb. EK-Gutschrift,geb. VK-Gutschrift';
            OptionMembers = "Purchase Document","Sales Document",,,"Purch Invoice","Sales Invoice","Purchase Receipt","Sales Shipment","Purchase Cr. Memo","Sales Cr. Memo";
        }
        field(5; "Ref. Type"; Integer)
        {
            CaptionML = ENU = 'Ref. Type';
            Editable = false;
        }
        field(6; "Ref. No."; Code[20])
        {
            CaptionML = ENU = 'Ref. No.', DEU = 'Ref. Nr.';
            Editable = false;
            TableRelation = IF ("Print of" = CONST("Purchase Document")) "Purchase Header"."No."
            ELSE IF ("Print of" = CONST("Sales Document")) "Sales Header"."No."
            ELSE IF ("Print of" = CONST("Purch Invoice")) "Purch. Inv. Header"."No."
            ELSE IF ("Print of" = CONST("Sales Invoice")) "Sales Invoice Header"."No."
            ELSE IF ("Print of" = CONST("Purchase Receipt")) "Purch. Rcpt. Header"."No."
            ELSE IF ("Print of" = CONST("Sales Shipment")) "Sales Shipment Header"."No."
            ELSE IF ("Print of" = CONST("Purchase Cr. Memo")) "Purch. Cr. Memo Hdr."."No."
            ELSE IF ("Print of" = CONST("Sales Cr. Memo")) "Sales Cr.Memo Header"."No.";
        }
        field(7; "Receiver Type"; Option)
        {
            CaptionML = ENU = 'Receiver Type', DEU = 'Empfänger Art';
            Editable = false;
            OptionCaptionML = ENU = 'Buy/Sell,Pay/Bill,Shipment,Location,Shipping Agent', DEU = 'Verk./Eink.,Zahl./Rech.,Lieferung,Lagerort,Zusteller';
            OptionMembers = "Buy/Sell","Pay/Bill",Shipment,Location,"Shipping Agent";
        }
        field(8; "Receiver No."; Code[20])
        {
            CaptionML = ENU = 'Receiver No.', DEU = 'Empfänger Nr.';
            TableRelation = IF ("Print of" = CONST("Purchase Document"),
                                "Receiver Type" = FILTER(<> Location)) Vendor."No."
            ELSE IF ("Print of" = CONST("Sales Document"),
                                         "Receiver Type" = FILTER("Buy/Sell" | Shipment)) Customer."No."
            Else if ("Print of" = Const("Sales document"), "Receiver Type" = Filter("Shipping Agent")) Vendor."No."
            ELSE IF ("Print of" = Const("Sales document"), "Receiver Type" = CONST(Location)) Location.Code
            ELSE IF ("Print of" = CONST("Purch Invoice"),
                                                  "Receiver Type" = FILTER(<> Location)) Vendor."No."
            ELSE IF ("Print of" = CONST("Sales Invoice"),
                                                           "Receiver Type" = FILTER(<> Location)) Customer."No.";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnValidate()
            begin
                if not Confirm(Text0003, false, FieldCaption("Receiver No.")) then
                    exit;

                case "Print of" of

                    "Print of"::"Purchase Document", "Print of"::"Purch Invoice":
                        begin
                            Vendor.Get("Receiver No.");
                            "Receiver No." := Vendor."No.";
                            Name := Vendor.Name;
                            "Name 2" := Vendor."Name 2";
                            Address := Vendor.Address;
                            "Address 2" := Vendor."Address 2";
                            City := Vendor.City;
                            "Post Code" := Vendor."Post Code";
                            County := Vendor.County;
                            "Country Code" := Vendor."Country/Region Code";
                            Contact := Vendor.Contact;
                            "Language Code" := Vendor."Language Code";
                            "E-mail" := Vendor."E-Mail";
                            "Fax No." := Vendor."Fax No.";
                            Priority := 0;
                        end;

                    "Print of"::"Sales Document", "Print of"::"Sales Invoice":
                        begin
                            case "Receiver Type" of
                                "Receiver Type"::"Buy/Sell", "Receiver Type"::Shipment:
                                    begin
                                        Customer.Get("Receiver No.");
                                        "Receiver No." := Customer."No.";
                                        Name := Customer.Name;
                                        "Name 2" := Customer."Name 2";
                                        Address := Customer.Address;
                                        "Address 2" := Customer."Address 2";
                                        City := Customer.City;
                                        "Post Code" := Customer."Post Code";
                                        County := Customer.County;
                                        "Country Code" := Customer."Country/Region Code";
                                        Contact := Customer.Contact;
                                        "Language Code" := Customer."Language Code";
                                        "E-mail" := Customer."E-Mail";
                                        "Fax No." := Customer."Fax No.";
                                        Priority := Customer.Priority;
                                    end;
                                "Receiver Type"::"Shipping Agent":
                                    begin
                                        Vendor.Get("Receiver No.");
                                        "Receiver No." := Vendor."No.";
                                        Name := Vendor.Name;
                                        "Name 2" := Vendor."Name 2";
                                        Address := Vendor.Address;
                                        "Address 2" := Vendor."Address 2";
                                        City := Vendor.City;
                                        "Post Code" := Vendor."Post Code";
                                        County := Vendor.County;
                                        "Country Code" := Vendor."Country/Region Code";
                                        Contact := Vendor.Contact;
                                        "Language Code" := Vendor."Language Code";
                                        "E-mail" := Vendor."E-Mail";
                                        "Fax No." := Vendor."Fax No.";
                                        Priority := 0;

                                    end;
                                "Receiver Type"::Location:
                                    begin
                                        Location.Get("Receiver No.");
                                        Name := Location.Name;
                                        "Name 2" := Location."Name 2";
                                        Address := Location.Address;
                                        "Address 2" := Location."Address 2";
                                        City := Location.City;
                                        "Post Code" := Location."Post Code";
                                        County := Location.County;
                                        "Country Code" := Location."Country/Region Code";
                                        Contact := Location.Contact;
                                        "Language Code" := '';
                                        "E-mail" := Location."E-Mail";
                                        "Fax No." := Location."Fax No.";
                                        Priority := 0;
                                    end;
                            end;
                        end;
                end;
            end;
        }
        field(9; "No. Series"; Code[20])
        {
            CaptionML = ENU = 'No. Series', DEU = 'Nummernserie';
            Editable = false;
            TableRelation = "No. Series";
        }
        field(10; "Document Date"; Date)
        {
            CaptionML = ENU = 'Document Date', DEU = 'Belegdatum';
        }
        field(11; Name; Text[50])
        {
            CaptionML = ENU = 'Name', DEU = 'Name';
        }
        field(12; "Name 2"; Text[50])
        {
            CaptionML = ENU = 'Name 2', DEU = 'Name 2';
        }
        field(13; Address; Text[50])
        {
            CaptionML = ENU = 'Address', DEU = 'Adresse';
        }
        field(14; "Address 2"; Text[50])
        {
            CaptionML = ENU = 'Address 2', DEU = 'Adresse 2';
        }
        field(15; City; Text[50])
        {
            CaptionML = ENU = 'City', DEU = 'Ort';
        }
        field(16; "Post Code"; Code[20])
        {
            CaptionML = ENU = 'Post Code', DEU = 'PLZ';
            TableRelation = "Post Code";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(17; County; Text[30])
        {
            CaptionML = ENU = 'County', DEU = 'Budesregion';
        }
        field(19; "Country Code"; Code[10])
        {
            CaptionML = ENU = 'Country Code', DEU = 'Ländercode';
            TableRelation = "Country/Region";
        }
        field(20; Contact; Text[30])
        {
            CaptionML = ENU = 'Contact', DEU = 'Kontakt';
        }
        field(21; "E-mail"; Text[80])
        {
            CaptionML = ENU = 'E-mail', DEU = 'E-Mail';
        }
        field(22; "Fax No."; Text[30])
        {
            CaptionML = ENU = 'Fax No.', DEU = 'Fax Nr.';
        }
        field(23; Priority; Option)
        {
            CaptionML = ENU = 'Priority', DEU = 'Priorität';
            OptionCaptionML = ENU = 'low,normal,high', DEU = 'niedrig,normal,hoch';
            OptionMembers = low,normal,high;
        }
        field(24; "Language Code"; Code[10])
        {
            CaptionML = ENU = 'Language Code', DEU = 'Sprachcode';
            TableRelation = Language;
        }
        field(25; "No. Printed"; Integer)
        {
            CaptionML = ENU = 'No. Printed', DEU = 'Anzahl gedruckt';
            Editable = false;
        }
        field(26; "Business Partner Role No."; Code[20])
        {
            CaptionML = ENU = 'Business Partner Role No.', DEU = 'Geschäftsparner Nr.';
            TableRelation = "Business Partner Role"."No.";

            trigger OnLookup()
            begin
                DocumentType.Get("Document Type");
                if DocumentType."Business Partner Type Code" <> '' then
                    BusinessPartnerRoleRec.Reset;
                BusinessPartnerRoleRec.SetRange(BusinessPartnerRoleRec."Business Partner Type", DocumentType."Business Partner Type Code");
                if PAGE.RunModal(50004, BusinessPartnerRoleRec) = ACTION::LookupOK then begin
                    Validate("Business Partner Role No.", BusinessPartnerRoleRec."No.");
                    "Receiver No." := BusinessPartnerRoleRec."No.";
                end;
            end;

            trigger OnValidate()
            begin

                case BusinessPartnerRoleRec.Type of

                    BusinessPartnerRoleRec.Type::Vendor:
                        begin
                            Vendor.Get("Business Partner Role No.");
                            "Receiver No." := Vendor."No.";
                            Name := Vendor.Name;
                            "Name 2" := Vendor."Name 2";
                            Address := Vendor.Address;
                            "Address 2" := Vendor."Address 2";
                            City := Vendor.City;
                            "Post Code" := Vendor."Post Code";
                            County := Vendor.County;
                            "Country Code" := Vendor."Country/Region Code";
                            Contact := Vendor.Contact;
                            "Language Code" := Vendor."Language Code";
                            "E-mail" := Vendor."E-Mail";
                            "Fax No." := Vendor."Fax No.";
                            Priority := 0;
                        end;

                    BusinessPartnerRoleRec.Type::Customer:
                        begin
                            Customer.Get("Business Partner Role No.");
                            "Receiver No." := Customer."No.";
                            Name := Customer.Name;
                            "Name 2" := Customer."Name 2";
                            Address := Customer.Address;
                            "Address 2" := Customer."Address 2";
                            City := Customer.City;
                            "Post Code" := Customer."Post Code";
                            County := Customer.County;
                            "Country Code" := Customer."Country/Region Code";
                            Contact := Customer.Contact;
                            "Language Code" := Customer."Language Code";
                            "E-mail" := Customer."E-Mail";
                            "Fax No." := Customer."Fax No.";
                            Priority := Customer.Priority;
                        end;
                end;
            end;
        }
        field(27; "Shipping Agent Code"; Code[10])
        {
            CaptionML = ENU = 'Shipping Agent Code', DEU = 'Zustellercode';
            TableRelation = "Shipping Agent";

            trigger OnValidate()
            begin
                case "Receiver Type" of
                    "Receiver Type"::"Shipping Agent":
                        begin
                            if ("Shipping Agent Code" = '') then
                                Error(Text0004, FieldCaption("Shipping Agent Code"), FieldCaption("Receiver Type"), "Receiver Type");

                            GetShippingAgentCode;
                        end;
                end;

                //GetShippingAgentCode;
            end;
        }
        field(28; "Location Code"; Code[10])
        {
            CaptionML = ENU = 'Location Code', DEU = 'Lagerortcode';
            TableRelation = Location;

            trigger OnValidate()
            begin
                case "Receiver Type" of
                    "Receiver Type"::Location:
                        begin
                            //IF ("Location Code" = '') THEN
                            //ERROR(Text0004,FIELDCAPTION("Location Code"), FIELDCAPTION("Receiver Type"), "Receiver Type");

                            GetLocation;
                        end;
                end;

                //GetLocation;
            end;
        }
        field(50400; "Location filter"; Code[100])
        {
            CaptionML = ENU = 'Lagerortfilter', DEU = 'Lagerortfilter';
            TableRelation = Location;
            ValidateTableRelation = false;
        }
    }

    keys
    {
        key(Key1; "Document No.")
        {
        }
        key(Key2; "Print of", "Ref. Type", "Ref. No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin

        DocumentText.Reset;
        DocumentText.SetRange("No.", "Document No.");
        DocumentText.DeleteAll(true);
    end;

    trigger OnInsert()
    begin
        "Document Date" := WorkDate;
        DocumentType.Get("Document Type");
        if Rec."Document No." = '' then
            rec."Document No." := NoSeriesManagement.GetNextNo(DocumentType."Nos.", "Document Date");
    end;

    var
        DocumentType: Record "Document Type";
        NoSeriesManagement: Codeunit "No. Series";
        Text0001: Label 'is only valid for Salesdocuments';
        PurchaseHeader: Record "Purchase Header";
        SalesHeader: Record "Sales Header";
        Location: Record Location;
        Vendor: Record Vendor;
        Customer: Record Customer;
        Bank: Record "Bank Account";
        ShippingAgent: Record "Shipping Agent";
        Text0002: Label 'must not be empty';
        Text0003: Label 'Do you want to update the %1?';
        BusinessPartnerRoleRec: Record "Business Partner Role";
        PurchInvoiceHeader: Record "Purch. Inv. Header";
        SalesInvoiceHeader: Record "Sales Invoice Header";
        PurchReceipt: Record "Purch. Rcpt. Header";
        SalesShipment: Record "Sales Shipment Header";
        PurchCrMemo: Record "Purch. Cr. Memo Hdr.";
        SalesCrMemo: Record "Sales Cr.Memo Header";
        DocumentText: Record "Document Text";
        Text0004: Label '''%1'' is not allowed to be empty if ''%2''=''%3''.';

    procedure GetFieldFromPurchaseHeader()
    var
        PurchaseHeader: Record "Purchase Header";
        Vendor: Record Vendor;
        ShipToAdress: Record "Ship-to Address";
    begin
        TestField("Ref. No.");
        PurchaseHeader.Get("Ref. Type", "Ref. No.");
        case "Receiver Type" of

            "Receiver Type"::"Buy/Sell":
                begin
                    Vendor.Get(PurchaseHeader."Buy-from Vendor No.");
                    "Receiver No." := PurchaseHeader."Buy-from Vendor No.";
                    Name := PurchaseHeader."Buy-from Vendor Name";
                    "Name 2" := PurchaseHeader."Buy-from Vendor Name 2";
                    Address := PurchaseHeader."Buy-from Address";
                    "Address 2" := PurchaseHeader."Buy-from Address 2";
                    City := PurchaseHeader."Buy-from City";
                    "Post Code" := PurchaseHeader."Buy-from Post Code";
                    County := PurchaseHeader."Buy-from County";
                    "Country Code" := PurchaseHeader."Buy-from Country/Region Code";
                    Contact := PurchaseHeader."Buy-from Contact";
                    "Language Code" := PurchaseHeader."Language Code";
                    "E-mail" := Vendor."E-Mail";
                    "Fax No." := Vendor."Fax No.";
                    Priority := 0;
                end;

            "Receiver Type"::"Pay/Bill":
                begin
                    Vendor.Get(PurchaseHeader."Pay-to Vendor No.");
                    "Receiver No." := PurchaseHeader."Pay-to Vendor No.";
                    Name := PurchaseHeader."Pay-to Name";
                    "Name 2" := PurchaseHeader."Pay-to Name 2";
                    Address := PurchaseHeader."Pay-to Address";
                    "Address 2" := PurchaseHeader."Pay-to Address 2";
                    City := PurchaseHeader."Pay-to City";
                    "Post Code" := PurchaseHeader."Pay-to Post Code";
                    County := PurchaseHeader."Pay-to County";
                    "Country Code" := PurchaseHeader."Pay-to Country/Region Code";
                    Contact := PurchaseHeader."Pay-to Contact";
                    "Language Code" := PurchaseHeader."Language Code";
                    "E-mail" := Vendor."E-Mail";
                    "Fax No." := Vendor."Fax No.";
                    Priority := 0;
                end;

            "Receiver Type"::Shipment:
                begin
                    ShipToAdress.get(PurchaseHeader."Sell-to Customer No.", PurchaseHeader."Ship-to Code");
                    "Receiver No." := PurchaseHeader."Ship-to Code";
                    Name := PurchaseHeader."Ship-to Name";
                    "Name 2" := PurchaseHeader."Ship-to Name 2";
                    Address := PurchaseHeader."Ship-to Address";
                    "Address 2" := PurchaseHeader."Ship-to Address 2";
                    City := PurchaseHeader."Ship-to City";
                    "Post Code" := PurchaseHeader."Ship-to Post Code";
                    County := PurchaseHeader."Ship-to County";
                    "Country Code" := PurchaseHeader."Ship-to Country/Region Code";
                    Contact := PurchaseHeader."Ship-to Contact";
                    "Language Code" := PurchaseHeader."Language Code";
                    "E-mail" := ShipToAdress."E-Mail";
                    "Fax No." := ShipToAdress."Fax No.";
                    Priority := 0;
                end;

            "Receiver Type"::Location:
                begin
                    PurchaseHeader.TestField("Location Code");
                    Location.Get(PurchaseHeader."Location Code");
                    "Receiver No." := PurchaseHeader."Location Code";
                    Name := Location.Name;
                    "Name 2" := Location."Name 2";
                    Address := Location.Address;
                    "Address 2" := Location."Address 2";
                    City := Location.City;
                    "Post Code" := Location."Post Code";
                    County := Location.County;
                    "Country Code" := Location."Country/Region Code";
                    Contact := Location.Contact;
                    "Language Code" := '';
                    "E-mail" := Location."E-Mail";
                    "Fax No." := Location."Fax No.";
                    Priority := 0;
                end;
        /*
        "Receiver Type"::"Shipping Agent", "Receiver Type"::"Frontier Forwarder" :
          BEGIN

            IF "Receiver Type" = "Receiver Type"::"Shipping Agent" THEN BEGIN
              PurchaseHeader.TESTFIELD(PurchaseHeader."Shipping Agent Code");
              ShippingAgent.GET(PurchaseHeader."Shipping Agent Code")
            END ELSE BEGIN
              PurchaseHeader.TESTFIELD(PurchaseHeader."Frontier Forwarder");
              ShippingAgent.GET(PurchaseHeader."Frontier Forwarder");
            END;

            IF ShippingAgent."Vendor No." = '' THEN
              ShippingAgent.FIELDERROR("Vendor No.",Text0002)
            ELSE
              Vendor.GET(ShippingAgent."Vendor No.");

            "Receiver No." := Vendor."No.";
            Name := Vendor.Name;
            "Name 2" := Vendor."Name 2";
            Address := Vendor.Address;
            "Address 2" := Vendor."Address 2";
            City := Vendor.City;
            "Post Code" := Vendor."Post Code";
            County := Vendor.County;
            "Country Code" := Vendor."Country Code";
            Contact := Vendor.Contact;
            "Language Code" := Vendor."Language Code";
            "E-mail" := Vendor."E-Mail";
            "Fax No." := Vendor."Fax No.";
            Priority := Vendor.Priority;
          END;

        "Receiver Type"::"Settlement Central Office":
          BEGIN
            FIELDERROR("Receiver Type",Text0001);
          END;

        "Receiver Type"::Bank:
          BEGIN
            PurchaseHeader.TESTFIELD(PurchaseHeader."House Bank");
            Bank.GET(PurchaseHeader."House Bank");
            "Receiver No." := PurchaseHeader."House Bank";
            Name := Bank.Name;
            "Name 2" := Bank."Name 2";
            Address := Bank.Address;
            "Address 2" := Bank."Address 2";
            City := Bank.City;
            "Post Code" :=  Bank."Post Code";
            County := Bank.County;
            "Country Code" := Bank."Country Code";
            Contact := Bank.Contact;
            "Language Code" := Bank."Language Code";
            "E-mail" := Bank."E-Mail";
            "Fax No." := Bank."Fax No.";
            Priority := 0;
          END;
        */
        end;

    end;

    procedure GetFieldFromSalesHeader()
    var
        SalesHeader: Record "Sales Header";
        Customer: Record Customer;
        ShipToAddress: Record "Ship-to Address";
    begin
        TestField("Ref. No.");
        SalesHeader.Get("Ref. Type", "Ref. No.");
        case "Receiver Type" of

            "Receiver Type"::"Buy/Sell":
                begin
                    "Receiver No." := SalesHeader."Sell-to Customer No.";
                    Name := SalesHeader."Sell-to Customer Name";
                    "Name 2" := SalesHeader."Sell-to Customer Name 2";
                    Address := SalesHeader."Sell-to Address";
                    "Address 2" := SalesHeader."Sell-to Address 2";
                    City := SalesHeader."Sell-to City";
                    "Post Code" := SalesHeader."Sell-to Post Code";
                    County := SalesHeader."Sell-to County";
                    "Country Code" := SalesHeader."Sell-to Country/Region Code";
                    Contact := SalesHeader."Sell-to Contact";
                    "Language Code" := SalesHeader."Language Code";
                    "E-mail" := SalesHeader."Sell-to E-Mail";
                    "Fax No." := SalesHeader.GetSellToCustomerFaxNo();
                    Priority := 0;
                end;


            "Receiver Type"::"Pay/Bill":
                begin
                    Customer.Get(SalesHeader."Bill-to Customer No.");
                    "Receiver No." := SalesHeader."Bill-to Customer No.";
                    Name := SalesHeader."Bill-to Name";
                    "Name 2" := SalesHeader."Bill-to Name 2";
                    Address := SalesHeader."Bill-to Address";
                    "Address 2" := SalesHeader."Bill-to Address 2";
                    City := SalesHeader."Bill-to City";
                    "Post Code" := SalesHeader."Bill-to Post Code";
                    County := SalesHeader."Bill-to County";
                    "Country Code" := SalesHeader."Bill-to Country/Region Code";
                    Contact := SalesHeader."Bill-to Contact";
                    "Language Code" := SalesHeader."Language Code";
                    "E-mail" := Customer."E-Mail";
                    "Fax No." := Customer."Fax No.";
                    Priority := 0;
                end;

            "Receiver Type"::Shipment:
                begin
                    ShipToAddress.Get(SalesHeader."Sell-to Customer No.", SalesHeader."Ship-to Code");
                    "Receiver No." := SalesHeader."Ship-to Code";
                    Name := SalesHeader."Ship-to Name";
                    "Name 2" := SalesHeader."Ship-to Name 2";
                    Address := SalesHeader."Ship-to Address";
                    "Address 2" := SalesHeader."Ship-to Address 2";
                    City := SalesHeader."Ship-to City";
                    "Post Code" := SalesHeader."Ship-to Post Code";
                    County := SalesHeader."Ship-to County";
                    "Country Code" := SalesHeader."Ship-to Country/Region Code";
                    Contact := SalesHeader."Ship-to Contact";
                    "Language Code" := SalesHeader."Language Code";
                    "E-mail" := ShipToAddress."E-Mail";
                    "Fax No." := ShipToAddress."Fax No.";
                    Priority := 0;
                end;

            "Receiver Type"::Location:
                begin
                    SalesHeader.TestField("Location Code");
                    Location.Get(SalesHeader."Location Code");
                    "Receiver No." := SalesHeader."Location Code";
                    Name := Location.Name;
                    "Name 2" := Location."Name 2";
                    Address := Location.Address;
                    "Address 2" := Location."Address 2";
                    City := Location.City;
                    "Post Code" := Location."Post Code";
                    County := Location.County;
                    "Country Code" := Location."Country/Region Code";
                    Contact := Location.Contact;
                    "Language Code" := '';
                    "E-mail" := Location."E-Mail";
                    "Fax No." := Location."Fax No.";
                    Priority := 0;
                    "Location Code" := SalesHeader."Location Code";
                end;

            "Receiver Type"::"Shipping Agent":
                begin

                    SalesHeader.TestField("Shipping Agent Code");
                    ShippingAgent.Get(SalesHeader."Shipping Agent Code");

                    if ShippingAgent."Vendor No." = '' then
                        ShippingAgent.FieldError("Vendor No.", Text0002)
                    else
                        Vendor.Get(ShippingAgent."Vendor No.");

                    "Receiver No." := Vendor."No.";
                    Name := Vendor.Name;
                    "Name 2" := Vendor."Name 2";
                    Address := Vendor.Address;
                    "Address 2" := Vendor."Address 2";
                    City := Vendor.City;
                    "Post Code" := Vendor."Post Code";
                    County := Vendor.County;
                    "Country Code" := Vendor."Country/Region Code";
                    Contact := Vendor.Contact;
                    "Language Code" := Vendor."Language Code";
                    "E-mail" := Vendor."E-Mail";
                    "Fax No." := Vendor."Fax No.";
                    Priority := Vendor.Priority;
                    "Shipping Agent Code" := SalesHeader."Shipping Agent Code";
                end;


        end;
    end;

    procedure GetFieldFromPurchInvoiceHeader()
    var
        PurchInvoiceHeader: Record "Purch. Inv. Header";
    begin
        //GetFieldFromPurchInvoiceHeader


        TestField("Ref. No.");
        PurchInvoiceHeader.Get("Ref. No.");
        case "Receiver Type" of

            "Receiver Type"::"Buy/Sell":
                begin
                    "Receiver No." := PurchInvoiceHeader."Buy-from Vendor No.";
                    Name := PurchInvoiceHeader."Buy-from Vendor Name";
                    "Name 2" := PurchInvoiceHeader."Buy-from Vendor Name 2";
                    Address := PurchInvoiceHeader."Buy-from Address";
                    "Address 2" := PurchInvoiceHeader."Buy-from Address 2";
                    City := PurchInvoiceHeader."Buy-from City";
                    "Post Code" := PurchInvoiceHeader."Buy-from Post Code";
                    County := PurchInvoiceHeader."Buy-from County";
                    "Country Code" := PurchInvoiceHeader."Buy-from Country/Region Code";
                    Contact := PurchInvoiceHeader."Buy-from Contact";
                    "Language Code" := PurchInvoiceHeader."Language Code";
                    "E-mail" := '';
                    "Fax No." := '';
                    Priority := 0;
                end;

            "Receiver Type"::"Pay/Bill":
                begin
                    "Receiver No." := PurchInvoiceHeader."Pay-to Vendor No.";
                    Name := PurchInvoiceHeader."Pay-to Name";
                    "Name 2" := PurchInvoiceHeader."Pay-to Name 2";
                    Address := PurchInvoiceHeader."Pay-to Address";
                    "Address 2" := PurchInvoiceHeader."Pay-to Address 2";
                    City := PurchInvoiceHeader."Pay-to City";
                    "Post Code" := PurchInvoiceHeader."Pay-to Post Code";
                    County := PurchInvoiceHeader."Pay-to County";
                    "Country Code" := PurchInvoiceHeader."Pay-to Country/Region Code";
                    Contact := PurchInvoiceHeader."Pay-to Contact";
                    "Language Code" := PurchInvoiceHeader."Language Code";
                    "E-mail" := '';
                    "Fax No." := '';
                    Priority := 0;
                end;

            "Receiver Type"::Shipment:
                begin
                    "Receiver No." := PurchInvoiceHeader."Ship-to Code";
                    Name := PurchInvoiceHeader."Ship-to Name";
                    "Name 2" := PurchInvoiceHeader."Ship-to Name 2";
                    Address := PurchInvoiceHeader."Ship-to Address";
                    "Address 2" := PurchInvoiceHeader."Ship-to Address 2";
                    City := PurchInvoiceHeader."Ship-to City";
                    "Post Code" := PurchInvoiceHeader."Ship-to Post Code";
                    County := PurchInvoiceHeader."Ship-to County";
                    "Country Code" := PurchInvoiceHeader."Ship-to Country/Region Code";
                    Contact := PurchInvoiceHeader."Ship-to Contact";
                    "Language Code" := PurchInvoiceHeader."Language Code";
                    "E-mail" := '';
                    "Fax No." := '';
                    Priority := 0;
                end;

            "Receiver Type"::Location:
                begin
                    PurchInvoiceHeader.TestField("Location Code");
                    Location.Get(PurchInvoiceHeader."Location Code");
                    "Receiver No." := PurchInvoiceHeader."Location Code";
                    Name := Location.Name;
                    "Name 2" := Location."Name 2";
                    Address := Location.Address;
                    "Address 2" := Location."Address 2";
                    City := Location.City;
                    "Post Code" := Location."Post Code";
                    County := Location.County;
                    "Country Code" := Location."Country/Region Code";
                    Contact := Location.Contact;
                    "Language Code" := '';
                    "E-mail" := Location."E-Mail";
                    "Fax No." := Location."Fax No.";
                    Priority := 0;
                end;
        end;
    end;

    procedure GetFieldFromSalesInvoiceHeader()
    var
        SalesInvoiceHeader: Record "Sales Invoice Header";
    begin
        //GetFieldFromSalesInvoiceHeader

        TestField("Ref. No.");
        SalesInvoiceHeader.Get("Ref. No.");
        case "Receiver Type" of

            "Receiver Type"::"Buy/Sell":
                begin
                    "Receiver No." := SalesInvoiceHeader."Sell-to Customer No.";
                    Name := SalesInvoiceHeader."Sell-to Customer Name";
                    "Name 2" := SalesInvoiceHeader."Sell-to Customer Name 2";
                    Address := SalesInvoiceHeader."Sell-to Address";
                    "Address 2" := SalesInvoiceHeader."Sell-to Address 2";
                    City := SalesInvoiceHeader."Sell-to City";
                    "Post Code" := SalesInvoiceHeader."Sell-to Post Code";
                    County := SalesInvoiceHeader."Sell-to County";
                    "Country Code" := SalesInvoiceHeader."Sell-to Country/Region Code";
                    Contact := SalesInvoiceHeader."Sell-to Contact";
                    "Language Code" := SalesInvoiceHeader."Language Code";
                    "E-mail" := '';
                    "Fax No." := '';
                    Priority := 0;
                end;


            "Receiver Type"::"Pay/Bill":
                begin
                    "Receiver No." := SalesInvoiceHeader."Bill-to Customer No.";
                    Name := SalesInvoiceHeader."Bill-to Name";
                    "Name 2" := SalesInvoiceHeader."Bill-to Name 2";
                    Address := SalesInvoiceHeader."Bill-to Address";
                    "Address 2" := SalesInvoiceHeader."Bill-to Address 2";
                    City := SalesInvoiceHeader."Bill-to City";
                    "Post Code" := SalesInvoiceHeader."Bill-to Post Code";
                    County := SalesInvoiceHeader."Bill-to County";
                    "Country Code" := SalesInvoiceHeader."Bill-to Country/Region Code";
                    Contact := SalesInvoiceHeader."Bill-to Contact";
                    "Language Code" := SalesInvoiceHeader."Language Code";
                    "E-mail" := '';
                    "Fax No." := '';
                    Priority := 0;
                end;

            "Receiver Type"::Shipment:
                begin
                    "Receiver No." := SalesInvoiceHeader."Ship-to Code";
                    Name := SalesInvoiceHeader."Ship-to Name";
                    "Name 2" := SalesInvoiceHeader."Ship-to Name 2";
                    Address := SalesInvoiceHeader."Ship-to Address";
                    "Address 2" := SalesInvoiceHeader."Ship-to Address 2";
                    City := SalesInvoiceHeader."Ship-to City";
                    "Post Code" := SalesInvoiceHeader."Ship-to Post Code";
                    County := SalesInvoiceHeader."Ship-to County";
                    "Country Code" := SalesInvoiceHeader."Ship-to Country/Region Code";
                    Contact := SalesInvoiceHeader."Ship-to Contact";
                    "E-mail" := '';
                    "Fax No." := '';
                    Priority := 0;
                end;

            "Receiver Type"::Location:
                begin
                    SalesInvoiceHeader.TestField("Location Code");
                    Location.Get(SalesInvoiceHeader."Location Code");
                    "Receiver No." := SalesInvoiceHeader."Location Code";
                    Name := Location.Name;
                    "Name 2" := Location."Name 2";
                    Address := Location.Address;
                    "Address 2" := Location."Address 2";
                    City := Location.City;
                    "Post Code" := Location."Post Code";
                    County := Location.County;
                    "Country Code" := Location."Country/Region Code";
                    Contact := Location.Contact;
                    "Language Code" := '';
                    "E-mail" := Location."E-Mail";
                    "Fax No." := Location."Fax No.";
                    Priority := 0;
                end;
        end;
    end;

    procedure GetFieldFromPurchReptHeader()
    var
        PurchReceipt: Record "Purch. Rcpt. Header";
    begin
        //GetFieldFromPurchRecHeader

        TestField("Ref. No.");
        PurchReceipt.Get("Ref. No.");
        case "Receiver Type" of

            "Receiver Type"::"Buy/Sell":
                begin
                    "Receiver No." := PurchReceipt."Buy-from Vendor No.";
                    Name := PurchReceipt."Buy-from Vendor Name";
                    "Name 2" := PurchReceipt."Buy-from Vendor Name 2";
                    Address := PurchReceipt."Buy-from Address";
                    "Address 2" := PurchReceipt."Buy-from Address 2";
                    City := PurchReceipt."Buy-from City";
                    "Post Code" := PurchReceipt."Buy-from Post Code";
                    County := PurchReceipt."Buy-from County";
                    "Country Code" := PurchReceipt."Buy-from Country/Region Code";
                    Contact := PurchReceipt."Buy-from Contact";
                    "Language Code" := PurchReceipt."Language Code";
                    "E-mail" := '';
                    "Fax No." := '';
                    Priority := 0;
                end;

            "Receiver Type"::"Pay/Bill":
                begin
                    "Receiver No." := PurchReceipt."Pay-to Vendor No.";
                    Name := PurchReceipt."Pay-to Name";
                    "Name 2" := PurchReceipt."Pay-to Name 2";
                    Address := PurchReceipt."Pay-to Address";
                    "Address 2" := PurchReceipt."Pay-to Address 2";
                    City := PurchReceipt."Pay-to City";
                    "Post Code" := PurchReceipt."Pay-to Post Code";
                    County := PurchReceipt."Pay-to County";
                    "Country Code" := PurchReceipt."Pay-to Country/Region Code";
                    Contact := PurchReceipt."Pay-to Contact";
                    "Language Code" := PurchReceipt."Language Code";
                    "E-mail" := '';
                    "Fax No." := '';
                    Priority := 0;
                end;

            "Receiver Type"::Shipment:
                begin
                    "Receiver No." := PurchReceipt."Ship-to Code";
                    Name := PurchReceipt."Ship-to Name";
                    "Name 2" := PurchReceipt."Ship-to Name 2";
                    Address := PurchReceipt."Ship-to Address";
                    "Address 2" := PurchReceipt."Ship-to Address 2";
                    City := PurchReceipt."Ship-to City";
                    "Post Code" := PurchReceipt."Ship-to Post Code";
                    County := PurchReceipt."Ship-to County";
                    "Country Code" := PurchReceipt."Ship-to Country/Region Code";
                    Contact := PurchReceipt."Ship-to Contact";
                    "Language Code" := PurchReceipt."Language Code";
                    "E-mail" := '';
                    "Fax No." := '';
                    Priority := 0;
                end;

            "Receiver Type"::Location:
                begin
                    PurchReceipt.TestField("Location Code");
                    Location.Get(PurchReceipt."Location Code");
                    "Receiver No." := PurchReceipt."Location Code";
                    Name := Location.Name;
                    "Name 2" := Location."Name 2";
                    Address := Location.Address;
                    "Address 2" := Location."Address 2";
                    City := Location.City;
                    "Post Code" := Location."Post Code";
                    County := Location.County;
                    "Country Code" := Location."Country/Region Code";
                    Contact := Location.Contact;
                    "Language Code" := '';
                    "E-mail" := Location."E-Mail";
                    "Fax No." := Location."Fax No.";
                    Priority := 0;
                end;

        end;
    end;

    procedure GetFieldFromSalesShpmHeader()
    var
        SalesShipment: Record "Sales Shipment Header";
    begin
        //GetFieldFromSalesShpmHeader

        TestField("Ref. No.");
        SalesShipment.Get("Ref. No.");
        case "Receiver Type" of

            "Receiver Type"::"Buy/Sell":
                begin
                    "Receiver No." := SalesShipment."Sell-to Customer No.";
                    Name := SalesShipment."Sell-to Customer Name";
                    "Name 2" := SalesShipment."Sell-to Customer Name 2";
                    Address := SalesShipment."Sell-to Address";
                    "Address 2" := SalesShipment."Sell-to Address 2";
                    City := SalesShipment."Sell-to City";
                    "Post Code" := SalesShipment."Sell-to Post Code";
                    County := SalesShipment."Sell-to County";
                    "Country Code" := SalesShipment."Sell-to Country/Region Code";
                    Contact := SalesShipment."Sell-to Contact";
                    "Language Code" := SalesShipment."Language Code";
                    "E-mail" := '';
                    "Fax No." := '';
                    Priority := 0;
                end;


            "Receiver Type"::"Pay/Bill":
                begin
                    "Receiver No." := SalesShipment."Bill-to Customer No.";
                    Name := SalesShipment."Bill-to Name";
                    "Name 2" := SalesShipment."Bill-to Name 2";
                    Address := SalesShipment."Bill-to Address";
                    "Address 2" := SalesShipment."Bill-to Address 2";
                    City := SalesShipment."Bill-to City";
                    "Post Code" := SalesShipment."Bill-to Post Code";
                    County := SalesShipment."Bill-to County";
                    "Country Code" := SalesShipment."Bill-to Country/Region Code";
                    Contact := SalesShipment."Bill-to Contact";
                    "Language Code" := SalesShipment."Language Code";
                    "E-mail" := '';
                    "Fax No." := '';
                    Priority := 0;
                end;

            "Receiver Type"::Shipment:
                begin
                    "Receiver No." := SalesShipment."Ship-to Code";
                    Name := SalesShipment."Ship-to Name";
                    "Name 2" := SalesShipment."Ship-to Name 2";
                    Address := SalesShipment."Ship-to Address";
                    "Address 2" := SalesShipment."Ship-to Address 2";
                    City := SalesShipment."Ship-to City";
                    "Post Code" := SalesShipment."Ship-to Post Code";
                    County := SalesShipment."Ship-to County";
                    "Country Code" := SalesShipment."Ship-to Country/Region Code";
                    Contact := SalesShipment."Ship-to Contact";
                    "E-mail" := '';
                    "Fax No." := '';
                    Priority := 0;
                end;

            "Receiver Type"::Location:
                begin
                    SalesShipment.TestField("Location Code");
                    Location.Get(SalesShipment."Location Code");
                    "Receiver No." := SalesShipment."Location Code";
                    Name := Location.Name;
                    "Name 2" := Location."Name 2";
                    Address := Location.Address;
                    "Address 2" := Location."Address 2";
                    City := Location.City;
                    "Post Code" := Location."Post Code";
                    County := Location.County;
                    "Country Code" := Location."Country/Region Code";
                    Contact := Location.Contact;
                    "Language Code" := '';
                    "E-mail" := Location."E-Mail";
                    "Fax No." := Location."Fax No.";
                    Priority := 0;
                end;

        end;
    end;

    procedure GetFieldFromPurchCrMemoHeader()
    var
        PurchCrMemo: Record "Purch. Cr. Memo Hdr.";
    begin
        //GetFieldFromPurchCrMemoHeader

        TestField("Ref. No.");
        PurchCrMemo.Get("Ref. No.");
        case "Receiver Type" of

            "Receiver Type"::"Buy/Sell":
                begin
                    "Receiver No." := PurchCrMemo."Buy-from Vendor No.";
                    Name := PurchCrMemo."Buy-from Vendor Name";
                    "Name 2" := PurchCrMemo."Buy-from Vendor Name 2";
                    Address := PurchCrMemo."Buy-from Address";
                    "Address 2" := PurchCrMemo."Buy-from Address 2";
                    City := PurchCrMemo."Buy-from City";
                    "Post Code" := PurchCrMemo."Buy-from Post Code";
                    County := PurchCrMemo."Buy-from County";
                    "Country Code" := PurchCrMemo."Buy-from Country/Region Code";
                    Contact := PurchCrMemo."Buy-from Contact";
                    "Language Code" := PurchCrMemo."Language Code";
                    "E-mail" := '';
                    "Fax No." := '';
                    Priority := 0;
                end;

            "Receiver Type"::"Pay/Bill":
                begin
                    "Receiver No." := PurchCrMemo."Pay-to Vendor No.";
                    Name := PurchCrMemo."Pay-to Name";
                    "Name 2" := PurchCrMemo."Pay-to Name 2";
                    Address := PurchCrMemo."Pay-to Address";
                    "Address 2" := PurchCrMemo."Pay-to Address 2";
                    City := PurchCrMemo."Pay-to City";
                    "Post Code" := PurchCrMemo."Pay-to Post Code";
                    County := PurchCrMemo."Pay-to County";
                    "Country Code" := PurchCrMemo."Pay-to Country/Region Code";
                    Contact := PurchCrMemo."Pay-to Contact";
                    "Language Code" := PurchCrMemo."Language Code";
                    "E-mail" := '';
                    "Fax No." := '';
                    Priority := 0;
                end;

            "Receiver Type"::Shipment:
                begin
                    "Receiver No." := PurchCrMemo."Ship-to Code";
                    Name := PurchCrMemo."Ship-to Name";
                    "Name 2" := PurchCrMemo."Ship-to Name 2";
                    Address := PurchCrMemo."Ship-to Address";
                    "Address 2" := PurchCrMemo."Ship-to Address 2";
                    City := PurchCrMemo."Ship-to City";
                    "Post Code" := PurchCrMemo."Ship-to Post Code";
                    County := PurchCrMemo."Ship-to County";
                    "Country Code" := PurchCrMemo."Ship-to Country/Region Code";
                    Contact := PurchCrMemo."Ship-to Contact";
                    "Language Code" := PurchCrMemo."Language Code";
                    "E-mail" := '';
                    "Fax No." := '';
                    Priority := 0;
                end;

            "Receiver Type"::Location:
                begin
                    PurchCrMemo.TestField("Location Code");
                    Location.Get(PurchCrMemo."Location Code");
                    "Receiver No." := PurchCrMemo."Location Code";
                    Name := Location.Name;
                    "Name 2" := Location."Name 2";
                    Address := Location.Address;
                    "Address 2" := Location."Address 2";
                    City := Location.City;
                    "Post Code" := Location."Post Code";
                    County := Location.County;
                    "Country Code" := Location."Country/Region Code";
                    Contact := Location.Contact;
                    "Language Code" := '';
                    "E-mail" := Location."E-Mail";
                    "Fax No." := Location."Fax No.";
                    Priority := 0;
                end;

        end;
    end;

    procedure GetFieldFromSalesCrMemoHeader()
    var
        SalesCrMemo: Record "Sales Cr.Memo Header";
    begin
        //GetFieldFromSalesCrMemo

        TestField("Ref. No.");
        SalesCrMemo.Get("Ref. No.");
        case "Receiver Type" of

            "Receiver Type"::"Buy/Sell":
                begin
                    "Receiver No." := SalesCrMemo."Sell-to Customer No.";
                    Name := SalesCrMemo."Sell-to Customer Name";
                    "Name 2" := SalesCrMemo."Sell-to Customer Name 2";
                    Address := SalesCrMemo."Sell-to Address";
                    "Address 2" := SalesCrMemo."Sell-to Address 2";
                    City := SalesCrMemo."Sell-to City";
                    "Post Code" := SalesCrMemo."Sell-to Post Code";
                    County := SalesCrMemo."Sell-to County";
                    "Country Code" := SalesCrMemo."Sell-to Country/Region Code";
                    Contact := SalesCrMemo."Sell-to Contact";
                    "Language Code" := SalesCrMemo."Language Code";
                    "E-mail" := '';
                    "Fax No." := '';
                    Priority := 0;
                end;


            "Receiver Type"::"Pay/Bill":
                begin
                    "Receiver No." := SalesCrMemo."Bill-to Customer No.";
                    Name := SalesCrMemo."Bill-to Name";
                    "Name 2" := SalesCrMemo."Bill-to Name 2";
                    Address := SalesCrMemo."Bill-to Address";
                    "Address 2" := SalesCrMemo."Bill-to Address 2";
                    City := SalesCrMemo."Bill-to City";
                    "Post Code" := SalesCrMemo."Bill-to Post Code";
                    County := SalesCrMemo."Bill-to County";
                    "Country Code" := SalesCrMemo."Bill-to Country/Region Code";
                    Contact := SalesCrMemo."Bill-to Contact";
                    "Language Code" := SalesCrMemo."Language Code";
                    "E-mail" := '';
                    "Fax No." := '';
                    Priority := 0;
                end;

            "Receiver Type"::Shipment:
                begin
                    "Receiver No." := SalesCrMemo."Ship-to Code";
                    Name := SalesCrMemo."Ship-to Name";
                    "Name 2" := SalesCrMemo."Ship-to Name 2";
                    Address := SalesCrMemo."Ship-to Address";
                    "Address 2" := SalesCrMemo."Ship-to Address 2";
                    City := SalesCrMemo."Ship-to City";
                    "Post Code" := SalesCrMemo."Ship-to Post Code";
                    County := SalesCrMemo."Ship-to County";
                    "Country Code" := SalesCrMemo."Ship-to Country/Region Code";
                    Contact := SalesCrMemo."Ship-to Contact";
                    "E-mail" := '';
                    "Fax No." := '';
                    Priority := 0;
                end;

            "Receiver Type"::Location:
                begin
                    SalesCrMemo.TestField("Location Code");
                    Location.Get(SalesCrMemo."Location Code");
                    "Receiver No." := SalesCrMemo."Location Code";
                    Name := Location.Name;
                    "Name 2" := Location."Name 2";
                    Address := Location.Address;
                    "Address 2" := Location."Address 2";
                    City := Location.City;
                    "Post Code" := Location."Post Code";
                    County := Location.County;
                    "Country Code" := Location."Country/Region Code";
                    Contact := Location.Contact;
                    "Language Code" := '';
                    "E-mail" := Location."E-Mail";
                    "Fax No." := Location."Fax No.";
                    Priority := 0;
                end;

        end;
    end;

    procedure GetLocation()
    var
        Location: Record Location;
    begin
        //
        // GetLocation
        //

        Clear(Location);
        if Location.Get("Location Code") then begin
            "Receiver No." := Location.Code;
            Name := Location.Name;
            "Name 2" := Location."Name 2";
            Address := Location.Address;
            "Address 2" := Location."Address 2";
            City := Location.City;
            "Post Code" := Location."Post Code";
            County := Location.County;
            "Country Code" := Location."Country/Region Code";
            Contact := Location.Contact;
            "E-mail" := Location."E-Mail";
            "Fax No." := Location."Fax No.";
            "Language Code" := '';
        end;
    end;

    procedure GetShippingAgentCode()
    var
        ShippingAgent: Record "Shipping Agent";
        Vendor: Record Vendor;
    begin
        //
        // GetShippingAgentCode
        //

        Clear(ShippingAgent);
        if ShippingAgent.Get("Shipping Agent Code") then
            if (ShippingAgent."Vendor No." <> '') then
                if Vendor.Get(ShippingAgent."Vendor No.") then begin
                    "Receiver No." := Vendor."No.";
                    Name := Vendor.Name;
                    "Name 2" := Vendor."Name 2";
                    Address := Vendor.Address;
                    "Address 2" := Vendor."Address 2";
                    City := Vendor.City;
                    "Post Code" := Vendor."Post Code";
                    County := Vendor.County;
                    "Country Code" := Vendor."Country/Region Code";
                    Contact := Vendor.Contact;
                    "E-mail" := Vendor."E-Mail";
                    "Fax No." := Vendor."Fax No.";
                    "Language Code" := Vendor."Language Code";
                end;
    end;
}

