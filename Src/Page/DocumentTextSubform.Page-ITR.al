page 50002 "Document Text Subform (INT)"
{

    AutoSplitKey = true;
    PageType = ListPart;
    SourceTable = "Document Text";
    ApplicationArea = All;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Line No."; Rec."Line No.")
                {
                    ApplicationArea = All;
                    Visible = false;
                    ToolTip = 'Specifies the value of the Line No. field.', Comment = '%';
                }
                field("Document Text"; Rec."Document Text")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Document Text field.', Comment = '%';
                }
            }
        }
    }

    actions
    {
    }
}

