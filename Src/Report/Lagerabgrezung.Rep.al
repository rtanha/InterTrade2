report 50011 Lagerabgrezung
{
    DefaultLayout = RDLC;
    Caption = 'Lagerabgrenzung';
    RDLCLayout = './Src\Layout\Lagerabgrezung.rdlc';
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Item Ledger Entry"; "Item Ledger Entry")
        {
            RequestFilterFields = "Item No.", "Location Code", "Lot No.";

            trigger OnPreDataItem()
            begin
                CurrReport.Break;
            end;
        }
        dataitem(ChargeListQuery; "Integer")
        {
            column(COMPANYNAME; CompanyName)
            {
            }
            column(CurrReport_PAGENO; CurrReport.PageNo)
            {
            }
            column(Filters; Filters)
            {
            }
            column(Item_Inventory; Quantity2)
            {
            }
            column(ItemNo; ItemNo)
            {
            }
            column(ItemDescription; ItemDescription)
            {
            }
            column(ItemDescription2; ItemDescription2)
            {
            }
            column(Locationcode; LocationCode)
            {
            }
            column(LotNo; LotNo)
            {
            }
            column(UnitOfMeasure; UnitOfMeasure)
            {
            }
            column(ExpirationDate; ExpirationDate)
            {
            }
            column(SumQuantity; SumQuantity)
            {
            }
            dataitem("Integer"; "Integer")
            {
                DataItemTableView = WHERE(Number = CONST(1));
                column(sumSalesOrder; QuantitySalesOrder)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    if Reservierungberechnen.READ then
                        QuantitySalesOrder := Round(Reservierungberechnen.Sum_Quantity / ItemUnitOfMeasure."Qty. per Unit of Measure", 0.01);
                end;

                trigger OnPostDataItem()
                begin
                    Reservierungberechnen.CLOSE;
                end;

                trigger OnPreDataItem()
                begin
                    Reservierungberechnen.SETRANGE(Item_No, ItemNo);
                    Reservierungberechnen.SETRANGE(Location_Code, LocationCode);
                    Reservierungberechnen.SETRANGE(Lot_No, LotNo);
                    Reservierungberechnen.OPEN;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                if ChargeQuery.READ then begin
                    ItemNo := ChargeQuery.No;
                    ItemDescription := ChargeQuery.Description;
                    ItemDescription2 := ChargeQuery.Description_2;
                    LotNo := ChargeQuery.Lot_No;
                    UnitOfMeasure := ChargeQuery.Unit_of_Measure_Code;
                    ExpirationDate := ChargeQuery.Expiration_Date;
                    LocationCode := ChargeQuery.Location_Code;
                    Item.Get(ItemNo);
                    ItemUnitOfMeasure.Get(Item."No.", Item."Sales Unit of Measure");
                    Item.CalcFields(Inventory);
                    UnitOfMeasure := Item."Sales Unit of Measure";
                    SumQuantity := Round(ChargeQuery.Sum_Quantity / ItemUnitOfMeasure."Qty. per Unit of Measure", 0.01);
                    Quantity2 := Round(Item.Inventory / ItemUnitOfMeasure."Qty. per Unit of Measure", 0.01);
                end else
                    CurrReport.Break;
            end;

            trigger OnPostDataItem()
            begin
                ChargeQuery.CLOSE;
            end;

            trigger OnPreDataItem()
            begin
                Filters := "Item Ledger Entry".GetFilters;
                if "Item Ledger Entry".GetFilter("Item No.") <> '' then
                    ChargeQuery.SETRANGE(ChargeQuery.No, "Item Ledger Entry".GetRangeMin("Item No."), "Item Ledger Entry".GetRangeMax("Item No."));
                if "Item Ledger Entry".GetFilter("Location Code") <> '' then begin
                    ChargeQuery.SETRANGE(ChargeQuery.Location_Code, "Item Ledger Entry".GetRangeMin("Location Code"), "Item Ledger Entry".GetRangeMax("Location Code"));
                    Item.SetFilter("Location Filter", "Item Ledger Entry".GetFilter("Location Code"));
                end;
                if "Item Ledger Entry".GetFilter("Lot No.") <> '' then
                    ChargeQuery.SETRANGE(ChargeQuery.Lot_No, "Item Ledger Entry".GetRangeMin("Lot No."), "Item Ledger Entry".GetRangeMax("Lot No."));
                ChargeQuery.OPEN;
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
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
        ItemNo: Code[20];
        ItemDescription: Text[50];
        ItemDescription2: Text[50];
        LotNo: Code[20];
        UnitOfMeasure: Code[20];
        ExpirationDate: Date;
        SumQuantity: Decimal;
        ChargeQuery: Query "Chargen Liste";
        Filters: Text;
        Reservierungberechnen: Query "Lot Count in Salesorder";
        LocationCode: Code[20];
        QuantitySalesOrder: Decimal;
        Item: Record Item;
        ItemUnitOfMeasure: Record "Item Unit of Measure";
        Quantity2: Decimal;
}

