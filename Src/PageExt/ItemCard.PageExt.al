pageextension 50018 "Item Card Ext (INT)" extends "Item Card"
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        // Add changes to page actions here
        addlast(Entries)
        {
            action("History (INT)")
            {
                Caption = 'Einkauf/Verkauf History';
                Image = History;
                ApplicationArea = All;
                trigger OnAction()
                begin
                    OpenItemLegPage(Rec);
                end;

            }
        }
    }

    var
        myInt: Integer;

    procedure OpenItemLegPage(Item: Record Item)
    var
        ItemLegEntry: Record "Item Ledger Entry";
        ItemLegEntryTemp: Record "Item Ledger Entry" temporary;
        ABNumber: Code[20];
        Cust: Code[20];
        CustName: Text[50];
        Vend: Code[20];
        VendName: Text[50];
        ABLineNo: Integer;
        ShipLine: Record "Sales Shipment Line";
        Customer: Record Customer;
        ReceiptLine: Record "Purch. Rcpt. Line";
        Vendor: Record Vendor;
    begin

        ItemLegEntry.SETRANGE("Item No.", Item."No.");
        //ItemLegEntry.SETFILTER("Entry Type",'%1|%2',ItemLegEntry."Entry Type"::Sale,ItemLegEntry."Entry Type"::Purchase);
        IF ItemLegEntry.FINDFIRST THEN
            REPEAT
                ItemLegEntryTemp := ItemLegEntry;
                ItemLegEntryTemp.INSERT;
                ABNumber := '';
                Cust := '';
                CustName := '';
                Vend := '';
                VendName := '';
                ABLineNo := 0;
                IF ItemLegEntry."Entry Type" = ItemLegEntry."Entry Type"::Sale THEN
                    IF ShipLine.GET(ItemLegEntry."Document No.", ItemLegEntry."Document Line No.") THEN BEGIN
                        ABNumber := ShipLine."Order No.";
                        ABLineNo := ShipLine."Order Line No.";
                        IF Customer.GET(ShipLine."Sell-to Customer No.") THEN BEGIN
                            Cust := Customer."No.";
                            CustName := Customer.Name;
                        END;
                    END;
                IF ItemLegEntry."Entry Type" = ItemLegEntry."Entry Type"::Purchase THEN
                    IF ReceiptLine.GET(ItemLegEntry."Document No.", ItemLegEntry."Document Line No.") THEN BEGIN
                        ABNumber := ReceiptLine."Order No.";
                        ABLineNo := ReceiptLine."Order Line No.";
                        IF Vendor.GET(ReceiptLine."Buy-from Vendor No.") THEN BEGIN
                            Vend := Vendor."No.";
                            VendName := VendName;
                        END;
                    END;
                ItemLegEntryTemp."Order No." := ABNumber;
                ItemLegEntryTemp."Order Line No." := ABLineNo;
                ItemLegEntryTemp.MODIFY;
            UNTIL ItemLegEntry.NEXT = 0;
        PAGE.RUNMODAL(Page::"Item Led. Entry History (INT)", ItemLegEntryTemp);

    end;
}