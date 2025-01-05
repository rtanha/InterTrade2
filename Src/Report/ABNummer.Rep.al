report 50012 "A/B Nummer"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Src\Layout\AB Nummer.rdlc';
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Item Ledger Entry"; "Item Ledger Entry")
        {
            RequestFilterFields = "Item No.", "Posting Date", "Entry Type";
            column(ItemNo_ItemLedgerEntry; "Item Ledger Entry"."Item No.")
            {
            }
            column(PostingDate_ItemLedgerEntry; "Item Ledger Entry"."Posting Date")
            {
            }
            column(EntryType_ItemLedgerEntry; "Item Ledger Entry"."Entry Type")
            {
            }
            column(DocumentNo_ItemLedgerEntry; "Item Ledger Entry"."Document No.")
            {
            }
            column(Description_ItemLedgerEntry; "Item Ledger Entry".Description)
            {
            }
            column(LocationCode_ItemLedgerEntry; "Item Ledger Entry"."Location Code")
            {
            }
            column(Quantity_ItemLedgerEntry; "Item Ledger Entry".Quantity)
            {
            }
            column(Customer_No; Customer."No.")
            {
            }
            column(Customer_Name; Customer.Name)
            {
            }
            column(Vendor_No; Vendor."No.")
            {
            }
            column(Vendor_Name; Vendor.Name)
            {
            }
            column(Purch_DocType; PurchHdr."Document Type")
            {
            }
            column(Sales_DocType; SalesHdr."Document Type")
            {
            }
            column(Sales_No; ShipLine."Order No.")
            {
            }
            column(Purch_No; ReceiptLine."Order No.")
            {
            }

            trigger OnAfterGetRecord()
            begin
                ShipLine.Init;
                Customer.Init;
                Vendor.Init;
                ReceiptLine.Init;
                if "Item Ledger Entry"."Entry Type" = "Item Ledger Entry"."Entry Type"::Sale then
                    if ShipLine.Get("Item Ledger Entry"."Document No.", "Item Ledger Entry"."Document Line No.") then begin
                        if not Customer.Get(ShipLine."Sell-to Customer No.") then
                            Customer.Init;
                    end else
                        ShipLine.Init;
                if "Item Ledger Entry"."Entry Type" = "Item Ledger Entry"."Entry Type"::Purchase then
                    if ReceiptLine.Get("Item Ledger Entry"."Document No.", "Item Ledger Entry"."Document Line No.") then begin
                        if not Vendor.Get(ReceiptLine."Buy-from Vendor No.") then
                            Vendor.Init;
                    end else
                        ReceiptLine.Init;
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        SalesHdr: Record "Sales Header";
        PurchHdr: Record "Purchase Header";
        ShipLine: Record "Sales Shipment Line";
        ReceiptLine: Record "Purch. Rcpt. Line";
        Customer: Record Customer;
        Vendor: Record Vendor;
        "Cust./Vend. Name": Text[50];
        "Cust./Vend. No": Code[20];
}

