tableextension 50015 "Sales Receivables Setup (INT)" extends "Sales & Receivables Setup"
{
    fields
    {
        field(50000; "Automatische Partienr. (INT)"; Boolean)
        {
            CaptionML = ENU = 'Automatc Batchno. (INT)', DEU = 'Automatisch Partienr.';
            DataClassification = ToBeClassified;
        }
    }

}