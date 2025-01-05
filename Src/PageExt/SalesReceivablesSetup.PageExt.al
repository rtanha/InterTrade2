pageextension 50007 "Sales Rec. Setup Ext (INT)" extends "Sales & Receivables Setup"
{
    layout
    {
        // Add changes to page layout here
        addlast(General)
        {

            field("Automatische Partienr. (INT)"; Rec."Automatische Partienr. (INT)")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Automatische Partienr. (INT) field.', Comment = '%';
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