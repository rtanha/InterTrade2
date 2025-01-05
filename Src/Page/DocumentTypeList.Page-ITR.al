page 50000 "Document Type View (INT)"
{
    ApplicationArea = All;
    Caption = 'Document Type List';
    PageType = List;
    SourceTable = "Document Type";
    UsageCategory = Administration;
    CardPageId = 50009;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Code"; Rec."Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Code field.', Comment = '%';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Description field.', Comment = '%';
                }
                field("Description 2"; Rec."Description 2")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Description 2 field.', Comment = '%';
                }
                field("Sales Document Type"; Rec."Sales Document Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Sales Document Type field.', Comment = '%';
                }
                field("Purch. Document Type"; Rec."Purch. Document Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Purch. Document Type field.', Comment = '%';
                }
                field("Nos."; Rec."Nos.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Nos. field.', Comment = '%';
                }
                field("Page ID"; Rec."Page ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Page ID field.', Comment = '%';
                }
                field("Report ID"; Rec."Report ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Report ID field.', Comment = '%';
                }
                field("Business Partner Type Code"; Rec."Business Partner Type Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Business Partner Type Code field.', Comment = '%';
                }
                field("Receiver Type"; Rec."Receiver Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Receiver Type field.', Comment = '%';
                }
                field("No. of Records"; Rec."No. of Records")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No. of Records field.', Comment = '%';
                }
                field("Copy To Posted Documents"; Rec."Copy To Posted Documents")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Copy To Posted Documents field.', Comment = '%';
                }
                field("Copy To Posted Shpt./Rcpt."; Rec."Copy To Posted Shpt./Rcpt.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Copy To Posted Shpt./Rcpt. field.', Comment = '%';
                }
                field("Document Usage"; Rec."Document Usage")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Document Usage field.', Comment = '%';
                }
                field("Pdf Name"; Rec."Pdf Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Pdf Name field.', Comment = '%';
                }
                field("FTP Adresse"; Rec."FTP Adresse")
                {
                    ToolTip = 'Specifies the value of the FTP Adresse field.', Comment = '%';
                }
                field("FTP User"; Rec."FTP User")
                {
                    ToolTip = 'Specifies the value of the FTP User field.', Comment = '%';
                }
                field("FTP Kennwort"; Rec."FTP Kennwort")
                {
                    ToolTip = 'Specifies the value of the FTP Kennwort field.', Comment = '%';
                }
                field("Lagerort 1"; Rec."Lagerort 1")
                {
                    ToolTip = 'Specifies the value of the Lagerort 1 field.', Comment = '%';
                }
                field("Lagerort 1 Export-Wert"; Rec."Lagerort 1 Export-Wert")
                {
                    ToolTip = 'Specifies the value of the Lagerort 1 Export-Wert field.', Comment = '%';
                }
                field("Lagerort 2"; Rec."Lagerort 2")
                {
                    ToolTip = 'Specifies the value of the Lagerort 2 field.', Comment = '%';
                }
                field("Lagerort 2 Export-Wert"; Rec."Lagerort 2 Export-Wert")
                {
                    ToolTip = 'Specifies the value of the Lagerort 2 Export-Wert field.', Comment = '%';
                }
                field("Lagerort 3"; Rec."Lagerort 3")
                {
                    ToolTip = 'Specifies the value of the Lagerort 3 field.', Comment = '%';
                }
                field("Lagerort 3 Export-Wert"; Rec."Lagerort 3 Export-Wert")
                {
                    ToolTip = 'Specifies the value of the Lagerort 3 Export-Wert field.', Comment = '%';
                }
            }
        }
    }

    actions
    {
    }
}

