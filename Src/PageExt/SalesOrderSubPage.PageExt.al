pageextension 50003 "Sales Order Subform Ext" extends "Sales Order Subform"
{
    layout
    {
        // Add changes to page layout here
        addlast(Control1)
        {

            field("Batch No. (INT)"; Rec."Batch No. (INT)")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Batch No. (INT) field.', Comment = '%';
            }
            field("Lot No. (INT)"; Rec."Lot No. (INT)")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Lot No. field.', Comment = '%';
            }
            field("Country of Origin (INT)"; Rec."Country of Origin (INT)")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Country of Origin (INT) field.', Comment = '%';
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