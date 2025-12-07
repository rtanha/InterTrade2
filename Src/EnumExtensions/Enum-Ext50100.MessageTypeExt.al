enumextension 50000 MessageTypeExt extends "CHGMXCMessage Type"
{
    value(50100; Shipment)
    {
        Caption = 'Shipment';
        Implementation = "CHGMXCMessage Management" = MessageManagement;
    }
}
