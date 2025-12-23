report 50014 Auftragsanalyse
{
    DefaultLayout = RDLC;
    ApplicationArea = all;
    RDLCLayout = './Src\Layout\Auftragsanalyse.rdlc';
    UsageCategory = ReportsAndAnalysis;

    dataset
    {

        dataitem("Sales Invoice Header"; "Sales Invoice Header")
        {
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "No.";
            column(DocumentNo_SalesHeader; "Sales Invoice Header"."No.")
            {
            }
            column(OrderNo; "Sales Invoice Header"."Order No.")
            {
            }
            column(SalesToCustomerNo; "Sales Invoice Header"."Sell-to Customer No.")
            {
            }
            column(CustomerName; Customer.Name)
            {
            }
            column(Menge; Menge)
            {
            }
            column(Gutschrift; CreditMemoAmount)
            {
            }
            column(PrintDetail; MitDetail)
            {
            }
            column(UserID; UserId)
            {
            }
            column(Companyname; CompanyName)
            {
            }
            column(Today; Today)
            {
            }
            column(FarbeZeigen; FarbeZeigen)
            {
            }
            dataitem("Sales Invoice Line"; "Sales Invoice Line")
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemTableView = SORTING("Document No.", "Line No.") WHERE(Type = CONST(Item), "No." = FILTER(<> ''));
                column(LineNo; "Sales Invoice Line"."Line No.")
                {
                }
                column(ItemNo; Item."No.")
                {
                }
                column(Quantity_SalesLine; "Sales Invoice Line".Quantity)
                {
                }
                column(UoMeasure_SalesLine; "Sales Invoice Line"."Unit of Measure Code")
                {
                }
                column(LotNo; LotNo)
                {
                }
                column(EinstandspreisZeile; EinstandspreisZeile)
                {
                }
                column(MengeZeile; MengeZeile)
                {
                }
                column(CostAmountZeile; CostAmountZeile)
                {
                }
                column(ZuAbschlagEKLines; ZuAbschlagEKLines)
                {
                }
                column(EinstandspreisAusartikel; EinstandspreisAusArtikel)
                {
                }
                column(SummeVKZeile; VKUmsatzLines)
                {
                }
                column(ZuAbschlagVKLines; ZuAbschlagVKLines)
                {
                }
                column(BruttoGewicht; BruttoG)
                {
                }
                column(AnzPGCTK; AnzPGCTK)
                {
                }
                column(AnzPGCTR; AnzPGCTR)
                {
                }
                column(ANZPGCFR; AnzPGCFR)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    /*
                    IF NOT MitDetail THEN
                      CurrReport.SKIP;
                    */
                    EinstandspreisZeile := 0;
                    VKUmsatzLines := 0;
                    ZuAbschlagVKLines := 0;
                    AnzPGCTK := 0;
                    AnzPGCTR := 0;
                    AnzPGCFR := 0;
                    BruttoG := 0;
                    Counter += 1;

                    EinstandspreisAusArtikel := false;
                    Item.Get("No.");
                    AmountCost := EinstandspreisBerechnung.Einstandspreisberechnen("Sales Invoice Line", MengeZeile, CostAmountZeile, ZuAbschlagEKLines, LotNo);
                    if AmountCost = 0 then begin
                        AmountCost := ItemUnitCost("No.") * "Quantity (Base)";
                        EinstandspreisAusArtikel := true;
                        FarbeZeigen := true;
                    end;
                    EinstandspreisZeile := AmountCost;
                    if Type <> Type::"Charge (Item)" then begin
                        VKUmsatzLines := EinstandspreisBerechnung.GetSalesAmountActual("Document No.", "Line No.");
                        ZuAbschlagVKLines := EinstandspreisBerechnung.VerkaufZuAbschlag("Document No.", "Line No.");
                    end;
                    if Type = Type::Item then begin
                        if "Item Category Code" = 'FRISCH' then
                            AnzPGCFR := CalcQuantity("Sales Invoice Line");
                        if "Item Category Code" = 'TK' then
                            AnzPGCTK := CalcQuantity("Sales Invoice Line");
                        if "Item Category Code" = 'TR' then
                            AnzPGCTR := CalcQuantity("Sales Invoice Line");
                    end;
                    BruttoG := ("Gross Weight" * Quantity);

                end;

                trigger OnPreDataItem()
                begin
                    Counter := 1;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                Customer.Get("Sell-to Customer No.");
                CreditMemoAmount := GutschriftPrüfen("Sales Invoice Header"."No.");
                FarbeZeigen := false;

            end;
        }

    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                field(MitDetail; MitDetail)
                {
                    Caption = 'Show Quantity and Weight';
                    ApplicationArea = All;
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        Menge: Decimal;
        CostAmount: Decimal;
        EinstandspreisBerechnung: Codeunit "Einstandspreis Berechnung";
        LotNo: Code[20];
        Item: Record Item;
        Customer: Record Customer;
        SalesInvoiceLine: Record "Sales Invoice Line";
        CurrExchRate: Record "Currency Exchange Rate";
        BruttoG: Decimal;
        CreditMemoAmount: Decimal;
        EinstandspreisZeile: Decimal;
        MengeZeile: Decimal;
        ZuAbschlagEKLines: Decimal;
        CostAmountZeile: Decimal;
        AmountCost: Decimal;
        MitDetail: Boolean;
        VKUmsatzLines: Decimal;
        ZuAbschlagVKLines: Decimal;
        EinstandspreisAusArtikel: Boolean;
        AnzPGCTK: Decimal;
        AnzPGCTR: Decimal;
        AnzPGCFR: Decimal;
        Counter: Integer;
        SalesShipmentLine: Record "Sales Shipment Line";
        ValueEntryQuery: Query Wertposten;
        EntryNo_ValueEntry: Integer;
        ItemChargeNo_ValueEntry: Code[20];
        Description_ValueEntry: Text[50];
        "CostAmountNon-Invtbl": Decimal;
        FarbeZeigen: Boolean;

    procedure "GutschriftPrüfen"("RechnNr.": Code[20]): Decimal
    var
        GBetrag: Decimal;
        Gutschriftskopf: Record "Sales Cr.Memo Header";
        Gutschriftszeile: Record "Sales Cr.Memo Line";
    begin
        Gutschriftskopf.SetFilter("Applies-to Doc. Type", '%1', Gutschriftskopf."Applies-to Doc. Type"::Invoice);
        Gutschriftskopf.SetFilter("Applies-to Doc. No.", '%1', "RechnNr.");
        GBetrag := 0;
        if Gutschriftskopf.Find('-') then begin
            Gutschriftszeile.SetRange(Gutschriftszeile."Document No.", Gutschriftskopf."No.");
            if Gutschriftszeile.Find('-') then
                repeat
                    if Gutschriftskopf."Currency Code" = '' then
                        GBetrag := GBetrag + Gutschriftszeile.Amount
                    else
                        GBetrag := GBetrag +
                                   CurrExchRate.ExchangeAmtFCYToLCY(
                                                                    Gutschriftskopf."Posting Date",
                                                                    Gutschriftskopf."Currency Code",
                                                                    Gutschriftszeile.Amount,
                                                                    Gutschriftskopf."Currency Factor")
              until Gutschriftszeile.Next = 0;
        end;
        exit(GBetrag);
    end;

    local procedure ItemUnitCost(itemNo: Code[20]): Decimal
    begin
        Item.Get(itemNo);
        exit(Item."Unit Cost");
    end;

    local procedure CalcQuantity(SalesInvoiceLine: Record "Sales Invoice Line"): Decimal
    var
        Item: Record Item;
        ItemUnitofMeasure: Record "Item Unit of Measure";
    begin
        Item.Get(SalesInvoiceLine."No.");
        ItemUnitofMeasure.Get(Item."No.", Item."Sales Unit of Measure");
        //UnitOfMeasure := Item."Sales Unit of Measure";
        exit(Round((SalesInvoiceLine.Quantity * SalesInvoiceLine."Qty. per Unit of Measure") / ItemUnitofMeasure."Qty. per Unit of Measure", 0.01));
    end;

}

