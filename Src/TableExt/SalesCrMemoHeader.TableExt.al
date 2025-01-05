tableextension 50019 "Sales Cr.Memo Header Ext INT" extends "Sales Cr.Memo Header"
{
    fields
    {
        // Add changes to table fields here
        field(50000; "Shipment Method City (INT)"; Text[50])
        {
            CaptionML = ENU = 'Place of Shipment Method (INT)', DEU = 'Lieferbedingungsort';
            DataClassification = CustomerContent;
        }
        field(50001; "Container No. (INT)"; Text[50])
        {
            CaptionML = ENU = 'Container No. (INT)', DEU = 'Containernr.';
            DataClassification = CustomerContent;
        }
        field(50002; "Shipping (INT)"; Code[10])
        {
            CaptionML = ENU = 'Shipping (INT)', DEU = 'Verschiffung';
            DataClassification = CustomerContent;
            TableRelation = "Sea Route";
        }
        field(50010; "Delivery Time From (INT)"; Time)
        {
            CaptionML = ENU = 'Delivery Time From (INT)', DEU = 'Lieferzeit von';
            DataClassification = CustomerContent;
        }
        field(50011; "Delivery Time To (INT)"; Time)
        {
            CaptionML = ENU = 'Delivery Time To (INT)', DEU = 'Lieferzeit bis';
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