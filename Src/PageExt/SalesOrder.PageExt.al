pageextension 50001 "Sales Order Ext (INT)" extends "Sales Order"
{
    layout
    {
        // Add changes to page layout here
        addafter("Shipment Method")
        {

            field("Shipment Method City (INT)"; Rec."Shipment Method City (INT)")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Place of Shipment Method (INT) field.', Comment = '%';
            }
        }
        addlast("Shipping and Billing")
        {

            field("Delivery Time From (INT)"; Rec."Delivery Time From (INT)")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Delivery Time From (INT) field.', Comment = '%';
            }
            field("Delivery Time To (INT)"; Rec."Delivery Time To (INT)")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Delivery Time To (INT) field.', Comment = '%';
            }
            field("Container No. (INT)"; Rec."Container No. (INT)")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Container No. (INT) field.', Comment = '%';
            }
            field("Shipping (INT)"; Rec."Shipping (INT)")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Shipping (INT) field.', Comment = '%';
            }
        }
    }

    actions
    {
        // Add changes to page actions here
        addlast("&Print")
        {

            action(PrintDocument)
            {
                ApplicationArea = All;
                CaptionML = ENU = 'Print Document', DEU = 'Druckbelege';
                Image = PrintDocument;
                Ellipsis = true;
                Promoted = true;
                PromotedCategory = Category11;
                ShortcutKey = 'Ctrl+Alt+D';
                trigger OnAction()
                var
                    PrintDocument: Record "Print Document";
                    DocMgt: Codeunit "Document Management (INT)";
                begin
                    Clear(DocMgt);
                    // DocMgt.TestCalcFields(Rec);
                    PrintDocument.INIT;
                    PrintDocument."Ref. Type" := Rec."Document Type";
                    PrintDocument."Ref. No." := Rec."No.";
                    PrintDocument."Print of" := PrintDocument."Print of"::"Sales Document";
                    DocMgt.PrintDocumentsText(PrintDocument);
                end;
            }
        }

    }


}