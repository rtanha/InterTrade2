enum 50003 "Document Type Purchase (INT)"
{
    Extensible = true;
    AssignmentCompatibility = true;

    Value(0; " ") { Caption = ''; }
    value(1; "Quote") { Caption = 'Quote'; }
    value(2; "Order") { Caption = 'Order'; }
    value(3; "Invoice") { Caption = 'Invoice'; }
    value(4; "Credit Memo") { Caption = 'Credit Memo'; }
    value(5; "Blanket Order") { Caption = 'Blanket Order'; }
    value(6; "Return Order") { Caption = 'Return Order'; }
}