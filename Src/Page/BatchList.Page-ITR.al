page 50007 "Batch List (INT)"
{
    Caption = 'Batches';
    PageType = List;
    SourceTable = Batch;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Code"; Rec.Code)
                {
                }
                field(Name; Rec.Name)
                {
                }
                field("Sum of Prift Accounts"; Rec."Sum of Prift Accounts")
                {
                }
                field("Sum of Cost Accounts"; Rec."Sum of Cost Accounts")
                {
                }
            }
        }
    }

    actions
    {
    }
}

