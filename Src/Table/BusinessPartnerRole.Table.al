table 50002 "Business Partner Role"
{
    CaptionML = ENU = 'Business Partner Role', DEU = 'Geschäftspartnerrole';
    LookupPageID = "Bus. Partner Roles (INT)";

    fields
    {
        field(1; Type; Option)
        {
            CaptionML = ENU = 'Type', DEU = 'Art';
            OptionCaptionML = ENU = ' ,Customer,Vendor', DEU = ' ,Debitor,Kreditor';
            OptionMembers = " ",Customer,Vendor;
        }
        field(2; "No."; Code[20])
        {
            CaptionML = ENU = 'No.', DEU = 'Nr.';
            NotBlank = true;
            TableRelation = IF (Type = CONST(Customer)) Customer."No."
            ELSE IF (Type = CONST(Vendor)) Vendor."No.";

            trigger OnValidate()
            begin

                case Type of
                    Type::Customer:
                        begin
                            Cust.Get("No.");
                            Name := Cust.Name;
                            "Search Name" := Cust."Search Name";
                            "Name 2" := Cust."Name 2";
                            Address := Cust.Address;
                            "Address 2" := Cust."Address 2";
                            City := Cust.City;
                            Contact := Cust.Contact;
                        end;
                    Type::Vendor:
                        begin
                            Vend.Get("No.");
                            Name := Vend.Name;
                            "Search Name" := Vend."Search Name";
                            "Name 2" := Vend."Name 2";
                            Address := Vend.Address;
                            "Address 2" := Vend."Address 2";
                            City := Vend.City;
                            Contact := Vend.Contact;
                        end;
                end;
            end;
        }
        field(3; "Business Partner Type"; Code[20])
        {
            CaptionML = ENU = 'Business Partner Type', DEU = 'Geschäftspartnertype';
            NotBlank = true;
            TableRelation = "Business Partner Type";
        }
        field(4; Name; Text[50])
        {
            CaptionML = ENU = 'Name', DEU = 'Name';
        }
        field(5; "Search Name"; Code[30])
        {
            CaptionML = ENU = 'Search Name', DEU = 'Suchname';
        }
        field(7; "Name 2"; Text[50])
        {
            CaptionML = ENU = 'Name 2', DEU = 'Name 2';
        }
        field(8; Address; Text[50])
        {
            CaptionML = ENU = 'Address', DEU = 'Adresse';
        }
        field(9; "Address 2"; Text[50])
        {
            CaptionML = ENU = 'Address 2', DEU = 'Adresse 2';
        }
        field(10; City; Text[50])
        {
            CaptionML = ENU = 'City', DEU = 'Ort';
        }
        field(11; Contact; Text[30])
        {
            CaptionML = ENU = 'Contact', DEU = 'Kotakt';
        }
    }

    keys
    {
        key(Key1; Type, "No.", "Business Partner Type")
        {
        }
        key(Key2; "Business Partner Type", "Search Name")
        {
        }
    }

    fieldgroups
    {
    }

    var
        Cust: Record Customer;
        Vend: Record Vendor;
}

