table 50007 Batch
{
    DrillDownPageID = "Batch List (INT)";
    LookupPageID = "Batch List (INT)";

    fields
    {
        field(1; "Code"; Code[20])
        {
        }
        field(2; Name; Text[50])
        {
            // Caption ='Name'; Comment= 'DEU="Name"';
            CaptionML = ENU = 'Name', DEU = 'Name';
        }
        field(3; "Sum of Prift Accounts"; Decimal)
        {
            CaptionML = ENU = 'Sum of Profit Accounts', DEU = 'Summe Umsatzkosten';
            CalcFormula = Sum("G/L Entry".Amount WHERE("Batch No. (INT)" = FIELD(Code),
                                                        "G/L Account No." = FILTER('4*')));
            // Caption = 'Sum of Profit Accounts';
            FieldClass = FlowField;
        }
        field(4; "Sum of Cost Accounts"; Decimal)
        {
            CalcFormula = Sum("G/L Entry".Amount WHERE("Batch No. (INT)" = FIELD(Code),
                                                        "G/L Account No." = FILTER('5*')));
            CaptionML = ENU = 'Sum of Cost Accounts', DEU = 'Summe Kostenkonten';
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "Code")
        {
        }
    }

    fieldgroups
    {
    }
}

