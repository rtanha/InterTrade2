tableextension 50007 "Company Information Ext (INT)" extends "Company Information"
{
    fields
    {
        // Add changes to table fields here
        field(50000; "US Account (INT)"; Text[30])
        {
            CaptionML = ENU = 'US$ Account (INT)', DEU = 'US$ Konto';
            DataClassification = CustomerContent;
        }
        field(50001; "AGB Standard Text (INT)"; Code[10])
        {
            CaptionML = ENU = 'Terms and Conditions (INT)', DEU = 'AGB Standard Text';
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

}