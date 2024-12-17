table 50008 "Customer Item No."
{
    CaptionML = ENU = 'Customer item No.', DEU = 'Debitorenartikelnr.';
    DrillDownPageID = "Customer Item Nos (INT)";
    LookupPageID = "Customer Item Nos (INT)";

    fields
    {
        field(1; "Item No."; Code[20])
        {
            CaptionML = ENU = 'Item No.', DEU = 'Artikelnr.';
            NotBlank = true;
            TableRelation = Item;
        }
        field(2; "Customer No."; Code[20])
        {
            CaptionML = ENU = 'Customer No.', DEU = 'Debitorennr.';
            NotBlank = true;
            TableRelation = Customer;
        }
        field(3; "Customer Item No."; Code[20])
        {
            CaptionML = ENU = 'Customer Item No.', DEU = 'Debitorenartikelnr';
        }
        field(4; "Item Description"; Text[30])
        {
            CalcFormula = Lookup(Item.Description WHERE("No." = FIELD("Item No.")));
            CaptionML = ENU = 'Item Description', DEU = 'Artikelbeschreibung';
            Editable = false;
            FieldClass = FlowField;
        }
        field(5; "Customer Name"; Text[30])
        {
            CalcFormula = Lookup(Customer.Name WHERE("No." = FIELD("Customer No.")));
            CaptionML = ENU = 'Customer Name', DEU = 'Debitorenname';
            Editable = false;
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "Item No.", "Customer No.")
        {
        }
    }

    fieldgroups
    {
    }
}

