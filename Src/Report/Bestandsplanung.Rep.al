report 50013 Bestandsplanung
{
    DefaultLayout = RDLC;
    RDLCLayout = './Src\Layout\Bestandsplanung.rdlc';
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem(Item; Item)
        {
            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.";
            column(COMPANYNAME; CompanyName)
            {
            }
            column(Filters; Filters)
            {
            }
            column(No_Item; Item."No.")
            {
            }
            column(Description_Item; Item.Description)
            {
            }
            column(Description2_Item; Item."Description 2")
            {
            }
            dataitem("Integer"; "Integer")
            {
                DataItemTableView = SORTING(Number);
                column(Location_Code; Location.Code)
                {
                }
                column(Item_Inventory; Round(Item.Inventory, 0.01))
                {
                }
                column(Item_Qty_On_Sales_Order; Round(Item."Qty. on Sales Order", 0.01))
                {
                }
                column(Item_Qty_On_Purch_Order; Round(Item."Qty. on Purch. Order", 0.01))
                {
                }
                column(Item_Sales_Qty; Item2."Sales (Qty.)")
                {
                }
                column(Reichweite; Round(Rechweite, 0.01))
                {
                }
                column(Bestellzeitpunkt; Bestellzeitpunkt)
                {
                }
                column(Beschaffungszeit; Beschaffungszeit)
                {
                }
                column(Lager_Reichweite; LagerReichweite)
                {
                }

                trigger OnAfterGetRecord()
                begin

                    if Location.Next = 0 then
                        CurrReport.Break;
                    if Integer.Number = 1 then
                        Location.Next(-1);
                    Item.SetFilter("Location Filter", '%1', Location.Code);
                    Item.CalcFields(Item.Inventory, Item."Qty. on Sales Order", Item."Qty. on Purch. Order", "Sales (Qty.)");
                    Item2.CopyFilters(Item);
                    Item2 := Item;
                    Item2.SetFilter("Location Filter", '%1', Location.Code);
                    Item2.SetFilter(Item2."Date Filter", '%1..%2', CalcDate('-3M', WorkDate), WorkDate);
                    Item2.CalcFields(Inventory, Item2."Sales (Qty.)");

                    if (Item2.Inventory = 0) and (Item2."Sales (Qty.)" = 0) and (Item."Qty. on Purch. Order" = 0) and
                       (Item."Qty. on Sales Order" = 0) then
                        CurrReport.Skip;
                    Beschaffungszeit := BeschaffungszeitInMonat(Format(Item."Lead Time Calculation"));
                    if Item2."Sales (Qty.)" = 0 then begin
                        LagerReichweite := 0;
                        Rechweite := 0;
                    end else begin
                        LagerReichweite := (Item.Inventory - Item."Qty. on Sales Order") / (Item2."Sales (Qty.)" / 3);
                        Rechweite := ((Item.Inventory - Item."Qty. on Sales Order") + Item."Qty. on Purch. Order") / (Item2."Sales (Qty.)" / 3);
                    end;
                    if LagerReichweite < 0 then
                        LagerReichweite := 0;
                    if Rechweite < 0 then
                        Rechweite := 0;
                    if Rechweite = 0 then
                        Bestellzeitpunkt := 0
                    else
                        Bestellzeitpunkt := Rechweite - Beschaffungszeit;
                    summeDurchschnitt := summeDurchschnitt + (Item2."Sales (Qty.)" / 3);
                    summeReichweite := summeReichweite + Rechweite;
                end;

                trigger OnPreDataItem()
                begin

                    Location.Find('-');
                    Integer.SetFilter(Number, '1..%1', Location.Count);
                    summeDurchschnitt := 0;
                    summeReichweite := 0;
                end;
            }

            trigger OnAfterGetRecord()
            begin

                Item.SetRange("Location Filter");
                Item.CalcFields(Item.Inventory, Item."Qty. on Sales Order", Item."Qty. on Purch. Order", "Sales (Qty.)");
                //Item2.setfilter("Location Filter",'%1',Location.Code);
                //Item.SETFILTER("Date Filter",'%1..%2',CALCDATE('-3M',TODAY),TODAY);
                //item2 := Item;
                //Item2.CALCFIELDS(Item2."Sales (Qty.)");
                if (Item.Inventory = 0) and (Item."Qty. on Purch. Order" = 0) and //AND (Item."Sales (Qty.)" = 0)
                   (Item."Qty. on Sales Order" = 0) then
                    CurrReport.Skip;
            end;

            trigger OnPreDataItem()
            begin
                Filters := Item.GetFilters;
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
        Lagerbestand: Decimal;
        MengeImAuftrag: Decimal;
        Verbrauch: Decimal;
        Verbrauchmonatlich: Decimal;
        Artikelposten: Record "Item Ledger Entry";
        Location: Record Location;
        Item2: Record Item;
        LagerReichweite: Decimal;
        Rechweite: Decimal;
        Bestellzeitpunkt: Decimal;
        Beschaffungszeit: Decimal;
        summeDurchschnitt: Decimal;
        summeReichweite: Decimal;
        Filters: Text;

    local procedure BeschaffungszeitInMonat(Beschaffungszeit: Text[30]): Decimal
    var
        Bezeichnung: Char;
        Tage: Integer;
        Wert: Integer;
        i: Integer;
        Multiplicator: Integer;
    begin

        if Beschaffungszeit = '' then
            exit(0);
        i := StrLen(Beschaffungszeit);
        Bezeichnung := Beschaffungszeit[i];
        case Bezeichnung of
            'T':
                Multiplicator := 1;
            'W':
                Multiplicator := 7;
            'M':
                Multiplicator := 30;
            'Q':
                Multiplicator := 90;
            'J':
                Multiplicator := 365;
        end;
        Evaluate(Tage, CopyStr(Beschaffungszeit, 1, i - 1));
        exit(Round(Tage / 30, 0.01));
    end;
}

