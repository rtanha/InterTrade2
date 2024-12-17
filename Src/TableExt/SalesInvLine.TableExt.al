tableextension 50005 "Sales Invoice Line Ext (INT)" extends "Sales Invoice Line"
{
    fields
    {
        // Add changes to table fields here
        field(50005; "Country of Origin (INT)"; Code[10])
        {
            CaptionML = ENU = 'Country of Origin (INT)', DEU = 'Ursprungsland';
            DataClassification = CustomerContent;
            TableRelation = "Country/Region";
        }
        field(50020; "Batch No. (INT)"; Code[20])
        {
            CaptionML = ENU = 'Batch No. (INT)', DEU = 'Partienr.';
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