enum 50001 "Receiver Type (INT)"
{
    Extensible = true;

    value(0; "Buy/Sell") { Caption = 'Buy/sell'; }
    value(1; "Pay/Bill") { Caption = 'Pay/Bill'; }
    value(2; Shipment) { Caption = 'Shipment'; }
    value(3; Location) { Caption = 'Location'; }
    value(4; "Shipping Agent") { Caption = 'Shipping Agent'; }
}