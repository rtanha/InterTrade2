pageextension 50014 "Sales Invoice List INT" extends "Sales Invoice List"
{
    layout
    {
        // Add changes to page layout here
        addlast(Control1)
        {

            field("Container No. (INT)"; Rec."Container No. (INT)")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Container No. (INT) field.', Comment = '%';
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}