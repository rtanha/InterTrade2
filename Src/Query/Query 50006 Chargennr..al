query 50006 "Chargennr."
{

    elements
    {
        dataitem(Sales_Invoice_Line; "Sales Invoice Line")
        {
            DataItemTableFilter = Type = FILTER(Item);
            filter(Document_No; "Document No.")
            {
            }
            filter(Line_No; "Line No.")
            {
            }
            column(Rechnungsnr; "Document No.")
            {
            }
            column(Zeilennr; "Line No.")
            {
            }
            dataitem(Sales_Shipment_Line; "Sales Shipment Line")
            {
                DataItemLink = "Order No." = Sales_Invoice_Line."Order No.", "Order Line No." = Sales_Invoice_Line."Order Line No.";
                column(Lieferscheinnr; "Document No.")
                {
                }
                column(Artikelnr; "No.")
                {
                }
                column(Lieferschein_Zeilennr; "Line No.")
                {
                }
                dataitem(Item_Ledger_Entry; "Item Ledger Entry")
                {
                    DataItemLink = "Document No." = Sales_Shipment_Line."Document No.", "Document Line No." = Sales_Shipment_Line."Line No.", "Posting Date" = Sales_Shipment_Line."Posting Date";
                    column(Lot_No; "Lot No.")
                    {
                    }
                    column(Cost_Amount_Non_Invtbl; "Cost Amount (Non-Invtbl.)")
                    {
                    }
                    column(Sales_Amount_Actual; "Sales Amount (Actual)")
                    {
                    }
                }
            }
        }
    }
}

