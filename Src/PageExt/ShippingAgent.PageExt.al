pageextension 50000 "Shipping Agents (INT)" extends "Shipping Agents"
{
    layout
    {
        // Add changes to page layout here
        addlast(Control1)
        {
            field("Vendor No."; Rec."Vendor No.")
            {
                Caption = 'Vendor No.';
                ApplicationArea = all;
                ToolTip = 'Specifies the value of the Vendor No. field.';
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