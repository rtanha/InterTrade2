tableextension 50011 "Ship To Adress (INT)" extends "Ship-to Address"
{
    fields
    {
        // Add changes to table fields here
        field(50000; "Delivery Time From (INT)"; Time)
        {
            CaptionML = ENU = 'Delivery Time From (INT)', DEU = 'Lieferzeit von';
            DataClassification = ToBeClassified;
        }
        field(50001; "Delivery Time To (INT)"; Time)
        {
            CaptionML = ENU = 'Delivery Time To (INT)', DEU = 'Lieferzeit bis';
            DataClassification = CustomerContent;
        }
        field(50002; "Place of Shipment Method (INT)"; Text[50])
        {
            CaptionML = ENU = 'Place of Shipment Method (INT)', DEU = 'Lieferbedingungsort';
            DataClassification = ToBeClassified;
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