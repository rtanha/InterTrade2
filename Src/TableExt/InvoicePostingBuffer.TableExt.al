tableextension 50024 "Inv. Post. Buffer (INT)" extends "Invoice Post. Buffer"
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

    //     keys
    //     {
    //         // Add changes to keys here
    //         key()
    //     }

    //     fieldgroups
    //     {
    //         // Add changes to field groups here
    //     }
}