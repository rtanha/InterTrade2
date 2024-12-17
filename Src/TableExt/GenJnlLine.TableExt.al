tableextension 50016 "Gen. Journal Line (INT)" extends "Gen. Journal Line"
{
    fields
    {
        // Add changes to table fields here
        field(50020; "Batch No. (INT)"; Code[20])
        {
            CaptionML = ENU = 'Batch No. (INT)', DEU = 'Partienr.';
            DataClassification = ToBeClassified;
            TableRelation = Batch;
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