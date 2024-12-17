tableextension 50000 "Shipping Agent Ext (INT)" extends "Shipping Agent"
{
    fields
    {
        // Add changes to table fields here
        field(50000; "Vendor No."; Code[20])
        {
            CaptionML = ENU = 'Vendor No.', DEU = 'Kreditorennr.';
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

    var
        myInt: Integer;
}