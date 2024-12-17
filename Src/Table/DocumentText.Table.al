table 50005 "Document Text"
{

    CaptionML = ENU = 'Document Text', DEU = 'Belegtext';

    fields
    {
        field(1; "No."; Code[20])
        {
        }
        field(2; "Document Text"; Text[50])
        {
            CaptionML = ENU = 'Document Text', DEU = 'Belegtext';
        }
        field(3; "Line No."; Integer)
        {
            CaptionML = ENU = 'Line No.', DEU = 'Zeilennr.';
        }
    }

    keys
    {
        key(Key1; "No.", "Line No.")
        {
        }
    }

    fieldgroups
    {
    }
}

