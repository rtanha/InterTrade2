pageextension 50027 "MXMessage Def. (Int)" extends "CHGMXCMessage Def. Card"
{
    layout
    {
        // Add changes to page layout here
        addlast(Content)
        {

            field("Export Directly"; Rec."Export Directly")
            {
                ApplicationArea = All;
                ToolTip = 'ohne Warteschlage die Dtei exportieren.', Comment = '%';
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