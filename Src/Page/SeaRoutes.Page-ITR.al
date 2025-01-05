page 50006 "Sea Routes (INT)"
{
    CaptionML = ENU = 'Sea Route', DEU = 'Shiffreise';
    DataCaptionFields = "No.", Name;
    PageType = List;
    SourceTable = "Sea Route";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                }
                field(Name; Rec.Name)
                {
                }
                field("Port 1"; Rec."Port 1")
                {
                }
                field("Port 2"; Rec."Port 2")
                {
                }
                field("Port 3"; Rec."Port 3")
                {
                }
                field("ETD 1"; Rec."ETD 1")
                {
                }
                field("ETA 2"; Rec."ETA 2")
                {
                }
                field("ETD 2"; Rec."ETD 2")
                {
                }
                field("ETA 3"; Rec."ETA 3")
                {
                }
                field("Route-No."; Rec."Route-No.")
                {
                }
                field("Shipping Agent"; Rec."Shipping Agent")
                {
                }
                field(Comment; Rec.Comment)
                {
                }
                field("Ship Code"; Rec."Ship Code")
                {
                }
            }
        }
        area(factboxes)
        {
            systempart(Control1107700017; Links)
            {
                Visible = true;
            }
            systempart(Control1107700016; Notes)
            {
                Visible = true;
            }
        }
    }

    actions
    {
    }
}

