page 50009 "Document Type Card (INT)"
{
    PageType = Document;
    ApplicationArea = All;
    UsageCategory = Tasks;
    SourceTable = "Document Type";
    Caption = 'Document Type Card';

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'Allgemein';
                field("Code"; Rec."Code")
                {
                    ToolTip = 'Specifies the value of the Code field.', Comment = '%';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.', Comment = '%';
                }
                field("Description 2"; Rec."Description 2")
                {
                    ToolTip = 'Specifies the value of the Description 2 field.', Comment = '%';
                }
                field("Document Usage"; Rec."Document Usage")
                {
                    ToolTip = 'Specifies the value of the Document Usage field.', Comment = '%';
                }
                field("Business Partner Type Code"; Rec."Business Partner Type Code")
                {
                    ToolTip = 'Specifies the value of the Business Partner Type Code field.', Comment = '%';
                }
                field("Nos."; Rec."Nos.")
                {
                    ToolTip = 'Specifies the value of the Nos. field.', Comment = '%';
                }
                field("Page ID"; Rec."Page ID")
                {
                    ToolTip = 'Specifies the value of the Page ID field.', Comment = '%';
                }
                field("Report ID"; Rec."Report ID")
                {
                    ToolTip = 'Specifies the value of the Report ID field.', Comment = '%';
                }
                field("Sales Document Type"; Rec."Sales Document Type")
                {
                    ToolTip = 'Specifies the value of the Sales Document Type field.', Comment = '%';
                }
                field("Receiver Type"; Rec."Receiver Type")
                {
                    ToolTip = 'Specifies the value of the Receiver Type field.', Comment = '%';
                }
                field("Purch. Document Type"; Rec."Purch. Document Type")
                {
                    ToolTip = 'Specifies the value of the Purch. Document Type field.', Comment = '%';
                }
            }
            group(Export)
            {
                Caption = 'Export:';
                field("Pdf Name"; Rec."Pdf Name")
                {
                    ToolTip = 'Specifies the value of the Pdf Name field.', Comment = '%';
                }
                field("Send Type"; Rec."Send Type")
                {
                    ToolTip = 'Specifies the value of the Send Type field.', Comment = '%';
                }
                field("Email Receiver"; Rec."Email Receiver")
                {
                    ToolTip = 'Specifies the value of the Email Receiver field.', Comment = '%';
                }
                field("Ship. Lines File Name"; Rec."Ship. Lines File Name")
                {
                    ToolTip = 'Specifies the value of the Lieferzeilen Export Dateiname field.', Comment = '%';
                }
                field("Item Export File Name"; Rec."Item Export File Name")
                {
                    ToolTip = 'Specifies the value of the Artikel Export Dateiname field.', Comment = '%';
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
                field("Email Title"; Rec."Email Title")
                {
                    ToolTip = 'Specifies the value of the Email Betreff field.', Comment = '%';
                }
                field("FTP Adresse"; Rec."FTP Adresse")
                {
                    ToolTip = 'Specifies the value of the FTP Adresse field.', Comment = '%';
                }
                field("FTP Kennwort"; Rec."FTP Kennwort")
                {
                    ToolTip = 'Specifies the value of the FTP Kennwort field.', Comment = '%';
                }
                field("FTP User"; Rec."FTP User")
                {
                    ToolTip = 'Specifies the value of the FTP User field.', Comment = '%';
                }
            }
            group("Email Body")
            {
                Caption = 'Email Body';
                field(EmailBody; EmailBodyText)
                {
                    ApplicationArea = All;
                    // Importance = Additional;
                    MultiLine = true;
                    // ShowCaption = false;
                    ExtendedDatatype = RichContent;
                    Caption = 'Message';
                    ToolTip = 'Specifies the content of the email.';

                    trigger OnValidate()
                    begin
                        Rec.SetEmailBody(EmailBodyText);
                    end;
                }
            }
        }

    }
    actions
    {
        area(Processing)
        {
            action(ActionName)
            {

                trigger OnAction()
                begin

                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        EmailBodyText := Rec.GetEmailBody()
    end;

    var
        EmailBodyText: Text;
}