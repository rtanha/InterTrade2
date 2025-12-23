query 50010 Wertposten
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
                    column(Quantity; Quantity)
                    {
                    }
                    dataitem(Value_Entry; "Value Entry")
                    {
                        DataItemLink = "Item Ledger Entry No." = Item_Ledger_Entry."Entry No.";
                        SqlJoinType = InnerJoin;
                        DataItemTableFilter = "Item Ledger Entry Type" = FILTER(Purchase), "Entry Type" = FILTER("Direct Cost"), "Invoiced Quantity" = FILTER(0);
                        column(Entry_No; "Entry No.")
                        {
                        }
                        column(Item_Charge_No; "Item Charge No.")
                        {
                        }
                        column(Description; Description)
                        {
                        }
                        column(Cost_Amount_Non_Invtbl; "Cost Amount (Non-Invtbl.)")
                        {
                        }
                    }
                }
            }
        }
    }
}

