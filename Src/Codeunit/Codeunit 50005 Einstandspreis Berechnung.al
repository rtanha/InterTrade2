codeunit 50005 "Einstandspreis Berechnung"
{

    trigger OnRun()
    begin

    end;

    var
        ChargeQuery: Query "Chargennr.";
        CostAmountQuery: Query "Einstandsbetrag Artikel";
        CostChargeQuery: Query "Einstandsbetrag Zu/Abschlag";

    procedure Einstandspreisberechnen(SalesInvLine: Record "Sales Invoice Line"; var Quantity: Decimal; var CostAmount: Decimal; var "Charge (item)": Decimal; var LotNo: Code[20]): Decimal
    var
        Chargennr: Code[20];
        Anzahl: Integer;
        GesamtMenge: Decimal;
        Amount: Decimal;
        ZuAbschlag: Decimal;
        Ohnecharge: Boolean;
        Charge: Code[20];
    begin
        Anzahl := 0;
        ZuAbschlag := 0;
        Charge := '';
        Ohnecharge := FALSE;
        ChargeQuery.SETRANGE(Document_No, SalesInvLine."Document No.");
        ChargeQuery.SETRANGE(Line_No, SalesInvLine."Line No.");
        ChargeQuery.OPEN;
        WHILE ChargeQuery.READ DO
            Anzahl += 1;
        ChargeQuery.OPEN;
        IF ChargeQuery.READ THEN
            IF Anzahl = 1 THEN
                Chargennr := ChargeQuery.Lot_No
            ELSE
                Chargennr := '';
        //ChargeQuery.CLOSE;
        CostAmountQuery.SETRANGE(ItemFilter, SalesInvLine."No.");
        //CostAmountQuery.SETFILTER(PostingDateFilter,'..%1',SalesInvLine."Posting Date");
        IF Chargennr <> '' THEN
            CostAmountQuery.SETRANGE(LotFilter, Chargennr);
        CostAmountQuery.OPEN;
        IF CostAmountQuery.READ THEN BEGIN
            GesamtMenge := CostAmountQuery.Sum_Invoiced_Quantity;
            Amount := CostAmountQuery.Cost_Amount_Actual;
        END;
        WHILE CostAmountQuery.READ DO BEGIN
            GesamtMenge += CostAmountQuery.Sum_Invoiced_Quantity;
            Amount += CostAmountQuery.Cost_Amount_Actual;
        END;
        CostChargeQuery.SETRANGE(ItemFilter, SalesInvLine."No.");
        //CostChargeQuery.SETFILTER(PostingDateFilter,'..%1',SalesInvLine."Posting Date");
        IF Chargennr <> '' THEN
            CostChargeQuery.SETRANGE(LotFilter, Chargennr);
        CostChargeQuery.OPEN;
        WHILE CostChargeQuery.READ DO
            ZuAbschlag += CostChargeQuery.Cost_Amount_Actual;
        Quantity := GesamtMenge;
        CostAmount := Amount;
        "Charge (item)" := ZuAbschlag;
        LotNo := Chargennr;
        IF Quantity <> 0 THEN
            "Charge (item)" := ROUND((ZuAbschlag / Quantity) * SalesInvLine."Quantity (Base)", 0.01);
        IF Quantity = 0 THEN
            EXIT(0);
        EXIT((CostAmount / Quantity) * SalesInvLine."Quantity (Base)");
    end;

    procedure VerkaufZuAbschlag(InvoiceNo: Code[20]; InvoiceLineNo: Integer): Decimal
    var
        ZuAbschlag: Decimal;
        Query50006: Query "Chargennr.";
    begin
        Query50006.SETFILTER(Rechnungsnr, '%1', InvoiceNo);
        IF InvoiceLineNo <> 0 THEN
            Query50006.SETFILTER(Zeilennr, '%1', InvoiceLineNo);
        Query50006.OPEN;
        WHILE Query50006.READ DO
            ZuAbschlag += Query50006.Cost_Amount_Non_Invtbl;
        Query50006.CLOSE;

        EXIT(ZuAbschlag);
    end;

    procedure GETShipmentLine(var SalesShipmentLine: Record "Sales Shipment Line"; InvoiceNo: Code[20]; InvoiceLineNo: Integer)
    var
        Query50006: Query "Chargennr.";
    begin
        Query50006.SETFILTER(Rechnungsnr, '%1', InvoiceNo);
        Query50006.SETFILTER(Zeilennr, '%1', InvoiceLineNo);
        Query50006.OPEN;
        IF Query50006.READ THEN
            IF SalesShipmentLine.GET(Query50006.Lieferscheinnr, Query50006.Lieferschein_Zeilennr) THEN;
        Query50006.CLOSE;
    end;

    procedure GetSalesAmountActual(InvoiceNo: Code[20]; InvoiceLineNo: Integer): Decimal
    var
        Query50006: Query "Chargennr.";
        SalesAmount: Decimal;
    begin
        Query50006.SETFILTER(Rechnungsnr, '%1', InvoiceNo);
        IF InvoiceLineNo <> 0 THEN
            Query50006.SETFILTER(Zeilennr, '%1', InvoiceLineNo);
        Query50006.OPEN;
        WHILE Query50006.READ DO
            SalesAmount += Query50006.Sales_Amount_Actual;
        Query50006.CLOSE;
        EXIT(SalesAmount);
    end;
}

