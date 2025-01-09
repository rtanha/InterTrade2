pageextension 50012 "Sales Shipment Lines INT" extends "Sales Shipment Lines"
{
    layout
    {
        // Add changes to page layout here
        addlast(Control1)
        {

            field("Order No."; Rec."Order No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Order No. field.', Comment = '%';
            }
            field("Order Line No."; Rec."Order Line No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Order Line No. field.', Comment = '%';
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