pageextension 50005 "Purch. Inv Subform EXT INT" extends "Purch. Invoice Subform"
{
    layout
    {
        addlast(PurchDetailLine)
        {

            field("Batch No. (INT)"; Rec."Batch No. (INT)")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Batch No. (INT) field.', Comment = '%';
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