table 50001 "Business Partner Type"
{
    CaptionML = ENU = 'Business Partner Type', DEU = 'Geschäftspartnertype';
    LookupPageID = "Bus. Patner Type List (INT)";

    fields
    {
        field(1; "Code"; Code[20])
        {
        }
        field(2; Description; Text[30])
        {
            CaptionML = ENU = 'Description', DEU = 'Beschreibung';
        }
    }

    keys
    {
        key(Key1; "Code")
        {
        }
    }

    fieldgroups
    {
    }
}

