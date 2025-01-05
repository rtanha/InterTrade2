query 50008 "Einstandsbetrag Zu/Abschlag"
{

    elements
    {
        dataitem(Item_Ledger_Entry;"Item Ledger Entry")
        {
            filter(ItemFilter;"Item No.")
            {
            }
            filter(LotFilter;"Lot No.")
            {
            }
            filter(PostingDateFilter;"Posting Date")
            {
            }
            column(Item_No;"Item No.")
            {
            }
            column(Lot_No;"Lot No.")
            {
            }
            column(Sum_Invoiced_Quantity;"Invoiced Quantity")
            {
                Method = Sum;
            }
            dataitem(Value_Entry;"Value Entry")
            {
                DataItemLink = "Item Ledger Entry No."=Item_Ledger_Entry."Entry No.";
                SqlJoinType = InnerJoin;
                DataItemTableFilter = "Item Ledger Entry Type"=FILTER(Purchase|"Positive Adjmt."|Transfer),"Invoiced Quantity"=FILTER(0);
                column(Cost_Amount_Actual;"Cost Amount (Actual)")
                {
                }
            }
        }
    }
}

