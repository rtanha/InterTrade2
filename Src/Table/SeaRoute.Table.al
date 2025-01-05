table 50006 "Sea Route"
{
    DataPerCompany = false;
    DrillDownPageID = "Sea Routes (INT)";
    LookupPageID = "Sea Routes (INT)";
    CaptionML = ENU = 'Sea Route', DEU = 'Shiffreise';

    fields
    {
        field(1; "No."; Code[10])
        {
        }
        field(2; Name; Text[50])
        {
        }
        field(3; "Port 1"; Text[30])
        {
            CaptionML = ENU = 'Port 1', DEU = 'Hafen 1';
        }
        field(4; "Port 2"; Text[30])
        {
            CaptionML = ENU = 'Port 2', DEU = 'Hafen 2';
        }
        field(5; "Port 3"; Text[30])
        {
            CaptionML = ENU = 'Port 3', DEU = 'Hafen 3';
        }
        field(6; "ETD 1"; Date)
        {
        }
        field(7; "ETA 2"; Date)
        {
        }
        field(8; "ETD 2"; Date)
        {
        }
        field(9; "ETA 3"; Date)
        {
        }
        field(10; "Route-No."; Code[20])
        {
            CaptionML = ENU = 'Route-No.', DEU = 'Reise-Nr.';
        }
        field(11; "Shipping Agent"; Code[10])
        {
            CaptionML = ENU = 'Shipping Agent', DEU = 'Zusteller';
            TableRelation = "Shipping Agent";
        }
        field(12; Comment; Text[80])
        {
            CaptionML = ENU = 'Comment', DEU = 'Bemerkung';
        }
        field(13; "Ship Code"; Code[10])
        {
            CaptionML = ENU = 'Ship Code', DEU = 'Shiffskürzel';
        }
    }

    keys
    {
        key(Key1; "No.")
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "No.", Name, "Port 1", "ETD 1", "Route-No.", "Shipping Agent")
        {
        }
    }
}

