query 50002 "Lot Count in Salesorder"
{

    elements
    {
        dataitem(Reservation_Entry;"Reservation Entry")
        {
            DataItemTableFilter = "Source Type"=FILTER(37);
            filter(Item_No;"Item No.")
            {
            }
            filter(Location_Code;"Location Code")
            {
            }
            filter(Lot_No;"Lot No.")
            {
            }
            column(Sum_Quantity;"Quantity (Base)")
            {
                Method = Sum;
            }
        }
    }
}

