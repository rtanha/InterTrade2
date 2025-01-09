pageextension 50017 "Sales Invoice INT" extends "Sales Invoice"
{
    layout
    {
        // Add changes to page layout here
        addafter("Shipment Method")
        {

            field("Shipment Method City (INT)"; Rec."Shipment Method City (INT)")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Place of Shipment Method (INT) field.', Comment = '%';
            }
        }
        addlast("Shipping and Billing")
        {

            field("Delivery Time From (INT)"; Rec."Delivery Time From (INT)")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Delivery Time From (INT) field.', Comment = '%';
            }
            field("Delivery Time To (INT)"; Rec."Delivery Time To (INT)")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Delivery Time To (INT) field.', Comment = '%';
            }
            field("Container No. (INT)"; Rec."Container No. (INT)")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Container No. (INT) field.', Comment = '%';
            }
            field("Shipping (INT)"; Rec."Shipping (INT)")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Shipping (INT) field.', Comment = '%';
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