pageextension 50002 "Purchase Order Ext (INT)" extends "Purchase Order"
{
    layout
    {
        // Add changes to page layout here
        addafter("Shipment Method Code")
        {

            field("Shipment Method City (INT)"; Rec."Shipment Method City (INT)")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Place of Shipment Method (INT) field.', Comment = '%';
            }
        }
        addlast("Shipping and Payment")
        {

            field("Container No. (INT)"; Rec."Container No. (INT)")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Container No. (INT) field.', Comment = '%';
            }
            field("Shipping (INT)"; Rec."Shipping (INT)")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Contact Shipping (INT) field.', Comment = '%';
            }
        }
    }

    actions
    {
        // Add changes to page actions here
        addlast(Print)
        {
            action(PrintDocument)
            {
                ApplicationArea = All;
                CaptionML = ENU = 'Print Document', DEU = 'Druckbelege';
                Image = PrintDocument;
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
                    PrintDocument."Print of" := PrintDocument."Print of"::"Purchase Document";
                    DocMgt.PrintDocumentsText(PrintDocument);
                end;
            }
        }

    }

    var
        myInt: Integer;
}