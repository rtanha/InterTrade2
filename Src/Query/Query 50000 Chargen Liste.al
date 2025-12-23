query 50000 "Chargen Liste"
{
    Caption = 'Lot List';

    elements
    {
        dataitem(Item;Item)
        {
            column(No;"No.")
            {
            }
            column(Description;Description)
            {
            }
            column(Description_2;"Description 2")
            {
            }
            dataitem(Item_Ledger_Entry;"Item Ledger Entry")
            {
                DataItemLink = "Item No."=Item."No.";
                SqlJoinType = InnerJoin;
                DataItemTableFilter = "Remaining Quantity"=FILTER(<>0),"Lot No."=FILTER(<>'');
                column(Location_Code;"Location Code")
                {
                }
                column(Lot_No;"Lot No.")
                {
                }
                column(Expiration_Date;"Expiration Date")
                {
                }
                column(Unit_of_Measure_Code;"Unit of Measure Code")
                {
                }
                column(Sum_Quantity;"Remaining Quantity")
                {
                    Method = Sum;
                }
                column(Qty_per_Unit_of_Measure;"Qty. per Unit of Measure")
                {
                }
            }
        }
    }
}

