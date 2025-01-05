pageextension 50009 "Item List Ext (INT)" extends "Item List"
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        // Add changes to page actions here
        addlast(processing)
        {
            action(ExportItems)
            {
                Caption = 'Export to Excel';
                Image = Excel;
                ApplicationArea = All;
                trigger OnAction()
                begin
                    Report.RunModal(50018, true, false, Rec);
                end;
            }
        }
    }

    procedure GetItemFilter(): Text
    begin
        Exit(Rec.GetView());
    end;
}