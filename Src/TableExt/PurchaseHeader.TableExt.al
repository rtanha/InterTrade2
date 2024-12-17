tableextension 50014 "Purchase Header (INT)" extends "Purchase Header"
{
    fields
    {
        // Add changes to table fields here
        field(50000; "Shipping Agent Code (INT)"; Code[10])
        {
            CaptionML = ENU = 'Shipping Agent Code (INT)', DEU = 'Zustellercode';
            DataClassification = CustomerContent;
            TableRelation = "Shipping Agent";
        }
        field(50001; "Container No. (INT)"; Text[50])
        {
            CaptionML = ENU = 'Container No. (INT)', DEU = 'Containernr.';
            DataClassification = CustomerContent;
        }
        field(50002; "Shipping (INT)"; Code[10])
        {
            CaptionML = ENU = 'Contract Shipping (INT)', DEU = 'Verschiffung';
            DataClassification = CustomerContent;
            TableRelation = "Sea Route";
        }
        field(50003; "Shipment Method City (INT)"; Text[50])
        {
            CaptionML = ENU = 'Place of Shipment Method (INT)', DEU = 'Lieferbedingungsort';
            DataClassification = CustomerContent;
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