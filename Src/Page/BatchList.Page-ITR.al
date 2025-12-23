page 50007 "Batch List (INT)"
{
    CaptionML = ENU = 'Batche List', DEU = 'Partie Übersicht';
    PageType = List;
    SourceTable = Batch;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Code"; Rec."Code")
                {
                    ToolTip = 'Specifies the value of the Code field.', Comment = '%';
                }
                field(Name; Rec.Name)
                {
                    ToolTip = 'Specifies the value of the Name field.', Comment = '%';
                }
                field("Sum of Cost Accounts"; Rec."Sum of Cost Accounts")
                {
                    ToolTip = 'Specifies the value of the Sum of Cost Accounts field.', Comment = '%';
                }
                field("Sum of Prift Accounts"; Rec."Sum of Prift Accounts")
                {
                    ToolTip = 'Specifies the value of the Sum of Prift Accounts field.', Comment = '%';
                }
            }
        }
    }

    actions
    {
    }
}

