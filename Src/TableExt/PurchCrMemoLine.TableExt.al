tableextension 50021 "Purch. Cr. Memo Line Ext INT" extends "Purch. Cr. Memo Line"
{
    fields
    {
        // Add changes to table fields here
        field(50005; "Country of Origin (INT)"; Code[10])
        {
            CaptionML = ENU = 'Country of Origin (INT)', DEU = 'Ursprungsland';
            DataClassification = CustomerContent;
            TableRelation = "Country/Region";
            Editable = false;
        }
        field(50020; "Batch No. (INT)"; Code[20])
        {
            CaptionML = ENU = 'Batch No. (INT)', DEU = 'Partienr.';
            DataClassification = ToBeClassified;
            Editable = false;

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