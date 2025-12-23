pageextension 50008 "Customer Card Ext (INT)" extends "Customer Card"
{
    layout
    {
        // Add changes to page layout here
        addafter("Shipping Time")
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
            field("Place of Shipment Method (INT)"; Rec."Place of Shipment Method (INT)")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Place of Shipment Method (INT) field.', Comment = '%';
            }
        }
        addafter("IC Partner Code")
        {

            field("Invoice eMail (INT)"; Rec."Invoice eMail (INT)")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Invoice eMail (INT) field.', Comment = '%';
            }
        }
        addafter("VAT Registration No.")
        {

            field("Transaction Type (INT)"; Rec."Transaction Type (INT)")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Transaction Type (INT) field.', Comment = '%';
            }
            field("T. Specification Code (INT)"; Rec."T. Specification Code (INT)")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the T. Specification Code (INT) field.', Comment = '%';
            }
            field("Transport Method (INT)"; Rec."Transport Method (INT)")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Transport Method (INT) field.', Comment = '%';
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