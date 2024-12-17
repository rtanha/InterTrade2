tableextension 50008 "Purchase Line Ext (INT)" extends "Purchase Line"
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
            TableRelation = Batch;
        }
        field(50050; "Lot No. (INT)"; Code[50])
        {
            CaptionML = ENU = 'Lot No. (INT)', DEU = 'Chargennr.';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = Lookup("Reservation Entry"."Lot No." WHERE("Source Type" = FILTER(39), "Source ID" = FIELD("Document No."), "Source Ref. No." = FIELD("Line No.")));
        }
    }
}