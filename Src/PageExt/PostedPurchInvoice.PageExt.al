pageextension 50022 "Posted Purch. Inv." extends "Posted Purchase Invoice"
{
    layout
    {
        // Add changes to page layout here
        addlast("Shipping and Payment")
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