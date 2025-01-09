pageextension 50013 "Purch. Receipt Lines INT" extends "Purch. Receipt Lines"
{
    layout
    {
        // Add changes to page layout here
        modify("Order No.")
        {
            Visible = true;
        }
        modify("Order Line No.")
        {
            Visible = true;
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}