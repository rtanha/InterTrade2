page 50008 "Customer Item Nos (INT)"
{
    PageType = List;
    SourceTable = "Customer Item No.";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Customer No."; Rec."Customer No.")
                {
                    Visible = false;
                }
                field("Item No."; Rec."Item No.")
                {
                }
                field("Customer Item No."; Rec."Customer Item No.")
                {
                }
                field("Item Description"; Rec."Item Description")
                {
                }
                field("Customer Name"; Rec."Customer Name")
                {
                }
            }
        }
        area(factboxes)
        {
            part(Control1107700009; "Customer Statistics FactBox")
            {
                SubPageLink = "No." = FIELD("Customer No.");
            }
            part(Control1107700008; "Item Invoicing FactBox")
            {
                SubPageLink = "No." = FIELD("Item No.");
            }
        }
    }

    actions
    {
    }
}

