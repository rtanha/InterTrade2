tableextension 50013 "Vendor Ext (INT)" extends Vendor
{
    fields
    {
        // Add changes to table fields here
        field(50002; "Place of Shipment Method (INT)"; Text[50])
        {
            CaptionML = ENU = 'Place of Shipment Method (INT)', DEU = 'Lieferbedingungsort';
            DataClassification = CustomerContent;
        }
        field(50003; "Invoice eMail (INT)"; Text[80])
        {
            CaptionML = ENU = 'Invoice eMail (INT)', DEU = 'Rechnung E-Mail Adresse';
            DataClassification = CustomerContent;
        }
        field(50005; "Transaction Type (INT)"; Code[10])
        {
            CaptionML = ENU = 'Transaction Type (INT)', DEU = 'Art des Geschäftes';
            DataClassification = CustomerContent;
            TableRelation = "Transaction Type";
        }

        field(50006; "T. Specification Code (INT)"; Code[10])
        {
            CaptionML = ENU = 'Transaction Specification Code (INT)', DEU = 'Verfahren';
            DataClassification = ToBeClassified;
            TableRelation = "Transaction Specification";
        }
        field(50007; "Transport Method (INT)"; Code[10])
        {
            CaptionML = ENU = 'Transport Method (INT)', DEU = 'Verkehrszweig';
            DataClassification = CustomerContent;
            TableRelation = "Transport Method";
        }


    }

    keys
    {
        // Add changes to keys here
    }

    fieldgroups
    {
        // Add changes to field groups here
    }

    var
        myInt: Integer;
}