page 50001 "Print Document (INT)"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Documents;
    SourceTable = "Print Document";

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("Document No."; Rec."Document No.")
                {
                    ToolTip = 'Specifies the value of the Document No. field.', Comment = '%';
                }
                field("Document Type"; Rec."Document Type")
                {
                    ToolTip = 'Specifies the value of the Document Type field.', Comment = '%';
                }
                field("Print of"; Rec."Print of")
                {
                    ToolTip = 'Specifies the value of the Print of field.', Comment = '%';
                }
                field("Ref. Type"; Rec."Ref. Type")
                {
                    ToolTip = 'Specifies the value of the Ref. Type field.', Comment = '%';
                }
                field("Ref. No."; Rec."Ref. No.")
                {
                    ToolTip = 'Specifies the value of the Ref. No. field.', Comment = '%';
                }
                field("Receiver Type"; Rec."Receiver Type")
                {
                    ToolTip = 'Specifies the value of the Receiver Type field.', Comment = '%';
                }
                field("Receiver No."; Rec."Receiver No.")
                {
                    ToolTip = 'Specifies the value of the Receiver No. field.', Comment = '%';
                }
                field("No. Series"; Rec."No. Series")
                {
                    ToolTip = 'Specifies the value of the No. Series field.', Comment = '%';
                }
                field("Document Date"; Rec."Document Date")
                {
                    ToolTip = 'Specifies the value of the Document Date field.', Comment = '%';
                }
                field(Name; Rec.Name)
                {
                    ToolTip = 'Specifies the value of the Name field.', Comment = '%';
                }
                field("Name 2"; Rec."Name 2")
                {
                    ToolTip = 'Specifies the value of the Name 2 field.', Comment = '%';
                }
                field(Address; Rec.Address)
                {
                    ToolTip = 'Specifies the value of the Address field.', Comment = '%';
                }
                field("Address 2"; Rec."Address 2")
                {
                    ToolTip = 'Specifies the value of the Address 2 field.', Comment = '%';
                }
                field(City; Rec.City)
                {
                    ToolTip = 'Specifies the value of the City field.', Comment = '%';
                }
                field("Post Code"; Rec."Post Code")
                {
                    ToolTip = 'Specifies the value of the Post Code field.', Comment = '%';
                }
                field(County; Rec.County)
                {
                    ToolTip = 'Specifies the value of the County field.', Comment = '%';
                }
                field("Country Code"; Rec."Country Code")
                {
                    ToolTip = 'Specifies the value of the Country Code field.', Comment = '%';
                }
                field(Contact; Rec.Contact)
                {
                    ToolTip = 'Specifies the value of the Contact field.', Comment = '%';
                }
                field("E-mail"; Rec."E-mail")
                {
                    ToolTip = 'Specifies the value of the E-mail field.', Comment = '%';
                }
                field("Fax No."; Rec."Fax No.")
                {
                    ToolTip = 'Specifies the value of the Fax No. field.', Comment = '%';
                }
                field(Priority; Rec.Priority)
                {
                    ToolTip = 'Specifies the value of the Priority field.', Comment = '%';
                }
                field("Language Code"; Rec."Language Code")
                {
                    ToolTip = 'Specifies the value of the Language Code field.', Comment = '%';
                }
                field("No. Printed"; Rec."No. Printed")
                {
                    ToolTip = 'Specifies the value of the No. Printed field.', Comment = '%';
                }
                field("Business Partner Role No."; Rec."Business Partner Role No.")
                {
                    ToolTip = 'Specifies the value of the Business Partner Role No. field.', Comment = '%';
                }
                field("Shipping Agent Code"; Rec."Shipping Agent Code")
                {
                    ToolTip = 'Specifies the value of the Shipping Agent Code field.', Comment = '%';
                }
                field("Location Code"; Rec."Location Code")
                {
                    ToolTip = 'Specifies the value of the Location Code field.', Comment = '%';
                }
            }
            part(DocumentText; "Document Text Subform (INT)")
            {
                CaptionML = ENU = 'Document Texte';
                ApplicationArea = All;
                SubPageLink = "No." = field("Document No.");
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(Print)
            {
                ApplicationArea = All;
                Image = Print;
                CaptionML = ENU = 'Print', DEU = 'Drucken';
                trigger OnAction()
                var
                    DocumentType: Record "Document Type";
                begin
                    DocumentType.Get(Rec."Document Type");
                    Rec.SetRecFilter();
                    Report.RunModal(DocumentType."Report ID", true, true, Rec);
                end;
            }
            action(Email)
            {
                ApplicationArea = All;
                Image = Email;
                CaptionML = ENU = 'Email', DEU = 'E-Mail';
                trigger OnAction()
                var
                    DocMgt: Codeunit "Document Management (INT)";
                begin
                    DocMgt.EmailPrintDocument(Rec);
                end;
            }
        }
        area(Promoted)
        {
            actionref(PrintProm; Print)
            {

            }
            actionref(MailProm; Email)
            {

            }

        }
    }

    var
        myInt: Integer;
}