tableextension 50001 "Sales Line Ext (INT)" extends "Sales Line"
{
    fields
    {
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
        field(50050; "Lot No. (INT)"; Code[50])
        {
            CaptionML = ENU = 'Lot No.', DEU = 'Chargennr.';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = Lookup("Reservation Entry"."Lot No." WHERE("Source Type" = FILTER(37), "Source ID" = FIELD("Document No."), "Source Ref. No." = FIELD("Line No.")));
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