pageextension 50016 "Purchase Invoice INT" extends "Purchase Invoice"
{
    layout
    {
        // Add changes to page layout here
        addafter("Shipment Method Code")
        {

            field("Shipment Method City (INT)"; Rec."Shipment Method City (INT)")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Place of Shipment Method (INT) field.', Comment = '%';
            }
        }
        addlast("Shipping and Payment")
        {

            field("Container No. (INT)"; Rec."Container No. (INT)")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Container No. (INT) field.', Comment = '%';
            }
            field("Shipping (INT)"; Rec."Shipping (INT)")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Contact Shipping (INT) field.', Comment = '%';
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