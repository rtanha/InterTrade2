page 50005 "Bus. Patner Type List (INT)"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Documents;
    SourceTable = "Business Partner Type";

    layout
    {
        area(Content)
        {
            field("Code"; Rec."Code")
            {
                ToolTip = 'Specifies the value of the Code field.', Comment = '%';
            }
            field(Description; Rec.Description)
            {
                ToolTip = 'Specifies the value of the Description field.', Comment = '%';
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {

                trigger OnAction()
                begin

                end;
            }
        }
    }

}