page 50010 "Item Led. Entry History (INT)"
{
    // version Intertrade

    CaptionML = DEU = 'Artikelposten',
                ENU = 'Item Ledger Entries';
    DataCaptionExpression = GetCaption;
    DataCaptionFields = "Item No.";
    Editable = false;
    PageType = List;
    SourceTable = "Item Ledger Entry";
    SourceTableTemporary = true;
    ApplicationArea = All;


    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field(PostingDate; Rec."Posting Date")
                {
                }
                field(EntryType; Rec."Entry Type")
                {
                }
                field(DocumentType; Rec."Document Type")
                {
                }
                field(DocumentNo; Rec."Document No.")
                {
                }
                field(DocumentLineNo; Rec."Document Line No.")
                {
                    Visible = false;
                }
                field(CountryRegionCode; Rec."Country/Region Code")
                {
                }
                field(ItemNo; Rec."Item No.")
                {
                }
                field(VariantCode; Rec."Variant Code")
                {
                    Visible = false;
                }
                field(Description; Rec.Description)
                {
                }
                field(ReturnReasonCode; Rec."Return Reason Code")
                {
                    Visible = false;
                }
                field(GlobalDimension1Code; Rec."Global Dimension 1 Code")
                {
                    Visible = false;
                }
                field(GlobalDimension2Code; Rec."Global Dimension 2 Code")
                {
                    Visible = false;
                }
                field(ExpirationDate; Rec."Expiration Date")
                {
                    Visible = false;
                }
                field(SerialNo; Rec."Serial No.")
                {
                    Visible = false;
                }
                field(LotNo; Rec."Lot No.")
                {
                    Visible = false;
                }
                field(LocationCode; Rec."Location Code")
                {
                }
                field(UnitOfMeasureCode; Rec."Unit of Measure Code")
                {
                }
                field(Quantity; Rec.Quantity)
                {
                }
                field(InvoicedQuantity; Rec."Invoiced Quantity")
                {
                    Visible = true;
                }
                field(RemainingQuantity; Rec."Remaining Quantity")
                {
                    Visible = true;
                }
                field(ShippedQtyNotReturned; Rec."Shipped Qty. Not Returned")
                {
                    Visible = false;
                }
                field(ReservedQuantity; Rec."Reserved Quantity")
                {
                    Visible = false;
                }
                field(QtyPerUnitOfMeasure; Rec."Qty. per Unit of Measure")
                {
                    Visible = false;
                }
                field(SalesAmountExpected; Rec."Sales Amount (Expected)")
                {
                    Visible = false;
                }
                field(SalesAmountActual; Rec."Sales Amount (Actual)")
                {
                }
                field(CostAmountExpected; Rec."Cost Amount (Expected)")
                {
                    Visible = false;
                }
                field(CostAmountActual; Rec."Cost Amount (Actual)")
                {
                }
                field(CostAmountNonInvtbl; Rec."Cost Amount (Non-Invtbl.)")
                {
                }
                field(CostAmountExpectedACY; Rec."Cost Amount (Expected) (ACY)")
                {
                    Visible = false;
                }
                field(CostAmountActualACY; Rec."Cost Amount (Actual) (ACY)")
                {
                    Visible = false;
                }
                field(CostAmountNonInvtblACY; Rec."Cost Amount (Non-Invtbl.)(ACY)")
                {
                    Visible = false;
                }
                field(CompletelyInvoiced; Rec."Completely Invoiced")
                {
                    Visible = false;
                }
                field(Open; Rec.Open)
                {
                }
                field(DropShipment; Rec."Drop Shipment")
                {
                    Visible = false;
                }
                field(AssembleToOrder; Rec."Assemble to Order")
                {
                    Visible = false;
                }
                field(AppliedEntryToAdjust; Rec."Applied Entry to Adjust")
                {
                    Visible = false;
                }
                field(EntryNo; Rec."Entry No.")
                {
                }
                field(OrderNo; Rec."Order No.")
                {
                    CaptionML = DEU = 'A/B Nummer',
                                ENU = 'A/B Number';
                }
                field(OrderLineNo; Rec."Order Line No.")
                {
                    CaptionML = DEU = 'A/B Zeilennr.',
                                ENU = 'A/B Line No.';
                }
                field(SourceNo; Rec."Source No.")
                {
                    CaptionML = DEU = 'Deb./Kred. Nr.',
                                ENU = 'Cust./Vend. No.';
                }
                field(SalesPrice; "Sales Price")
                {
                }
            }
        }
        area(factboxes)
        {
            systempart(Control1900383207; Links)
            {
                Visible = false;
            }
            systempart(Control1905767507; Notes)
            {
                Visible = false;
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(Entry)
            {
                CaptionML = DEU = '&Posten',
                            ENU = 'Ent&ry';
                Image = Entry;
                action(Dimensions)
                {
                    AccessByPermission = TableData Dimension = R;
                    CaptionML = DEU = 'Dimensionen',
                                ENU = 'Dimensions';
                    Image = Dimensions;
                    ShortCutKey = 'Shift+Ctrl+D';

                    trigger OnAction()
                    begin
                        Rec.ShowDimensions;
                    end;
                }
                action(ValueEntries)
                {
                    CaptionML = DEU = '&Wertposten',
                                ENU = '&Value Entries';
                    Image = ValueLedger;
                    RunObject = Page "Value Entries";
                    RunPageLink = "Item Ledger Entry No." = field("Entry No.");
                    RunPageView = sorting("Item Ledger Entry No.");
                    ShortCutKey = 'Ctrl+F7';
                }
            }
        }
        area(processing)
        {
            group(Functions)
            {
                CaptionML = DEU = 'Fun&ktion',
                            ENU = 'F&unctions';
                Image = "Action";
                action(OrderTracking)
                {
                    CaptionML = DEU = '&Bedarfsverursacher',
                                ENU = 'Order &Tracking';
                    Image = OrderTracking;

                    trigger OnAction()
                    var
                        TrackingForm: Page "Order Tracking";
                    begin
                        TrackingForm.SetItemLedgEntry(Rec);
                        TrackingForm.RunModal;
                    end;
                }
            }
            action(Navigate)
            {
                CaptionML = DEU = '&Navigate',
                            ENU = '&Navigate';
                Image = Navigate;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    Navigate.SetDoc(Rec."Posting Date", Rec."Document No.");
                    Navigate.Run;
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        if Item.Get(Rec."Item No.") then begin
            ItemUnitofMeasure.Get(Rec."Item No.", Item."Sales Unit of Measure");
            Rec.Quantity := Round(Rec.Quantity / ItemUnitofMeasure."Qty. per Unit of Measure", 0.01);
            Rec."Invoiced Quantity" := Round(Rec."Invoiced Quantity" / ItemUnitofMeasure."Qty. per Unit of Measure", 0.01);
            Rec."Remaining Quantity" := Round(Rec."Remaining Quantity" / ItemUnitofMeasure."Qty. per Unit of Measure", 0.01);
            Rec."Unit of Measure Code" := Item."Sales Unit of Measure";
            Rec."Qty. per Unit of Measure" := ItemUnitofMeasure."Qty. per Unit of Measure";
        end;
        Rec.CalcFields("Sales Amount (Expected)", "Sales Amount (Actual)");
        if Rec."Sales Amount (Actual)" <> 0 then
            "Sales Price" := -Round(Rec."Sales Amount (Actual)" / Rec.Quantity, 0.01)
        else if Rec."Sales Amount (Expected)" <> 0 then
            "Sales Price" := -Round(Rec."Sales Amount (Expected)" / Rec.Quantity, 0.01)
        else
            "Sales Price" := 0;
    end;

    var
        Navigate: Page Navigate;
        ItemLedgEntry: Record "Item Ledger Entry";
        Item: Record Item;
        ItemUnitofMeasure: Record "Item Unit of Measure";
        "Sales Price": Decimal;

    procedure GetCaption(): Text
    var
        GLSetup: Record "General Ledger Setup";
        ObjTransl: Record "Object Translation";
        Item: Record Item;
        ProdOrder: Record "Production Order";
        Cust: Record Customer;
        Vend: Record Vendor;
        Dimension: Record Dimension;
        DimValue: Record "Dimension Value";
        SourceTableName: Text;
        SourceFilter: Text[200];
        Description: Text[100];
    begin
        Description := '';

        case true of
            Rec.GetFilter("Item No.") <> '':
                begin
                    SourceTableName := ObjTransl.TranslateObject(ObjTransl."Object Type"::Table, 27);
                    SourceFilter := Rec.GetFilter("Item No.");
                    if MaxStrLen(Item."No.") >= StrLen(SourceFilter) then
                        if Item.Get(SourceFilter) then
                            Description := Item.Description;
                end;
            (Rec.GetFilter("Order No.") <> '') and (Rec."Order Type" = Rec."Order Type"::Production):
                begin
                    SourceTableName := ObjTransl.TranslateObject(ObjTransl."Object Type"::Table, 5405);
                    SourceFilter := Rec.GetFilter("Order No.");
                    if MaxStrLen(ProdOrder."No.") >= StrLen(SourceFilter) then
                        if ProdOrder.Get(ProdOrder.Status::Released, SourceFilter) or
                              ProdOrder.Get(ProdOrder.Status::Finished, SourceFilter)
                        then begin
                            SourceTableName := StrSubstNo('%1 %2', ProdOrder.Status, SourceTableName);
                            Description := ProdOrder.Description;
                        end;
                end;
            Rec.GetFilter(Rec."Source No.") <> '':
                case Rec."Source Type" of
                    Rec."Source Type"::Customer:
                        begin
                            SourceTableName :=
                                ObjTransl.TranslateObject(ObjTransl."Object Type"::Table, 18);
                            SourceFilter := Rec.GetFilter("Source No.");
                            if MaxStrLen(Cust."No.") >= StrLen(SourceFilter) then
                                if Cust.Get(SourceFilter) then
                                    Description := Cust.Name;
                        end;
                    Rec."Source Type"::Vendor:
                        begin
                            SourceTableName :=
                                ObjTransl.TranslateObject(ObjTransl."Object Type"::Table, 23);
                            SourceFilter := Rec.GetFilter("Source No.");
                            if MaxStrLen(Vend."No.") >= StrLen(SourceFilter) then
                                if Vend.Get(SourceFilter) then
                                    Description := Vend.Name;
                        end;
                end;
            Rec.GetFilter("Global Dimension 1 Code") <> '':
                begin
                    GLSetup.Get;
                    Dimension.Code := GLSetup."Global Dimension 1 Code";
                    SourceFilter := Rec.GetFilter("Global Dimension 1 Code");
                    SourceTableName := Dimension.GetMLName(GlobalLanguage);
                    if MaxStrLen(DimValue.Code) >= StrLen(SourceFilter) then
                        if DimValue.Get(GLSetup."Global Dimension 1 Code", SourceFilter) then
                            Description := DimValue.Name;
                end;
            Rec.GetFilter("Global Dimension 2 Code") <> '':
                begin
                    GLSetup.Get;
                    Dimension.Code := GLSetup."Global Dimension 2 Code";
                    SourceFilter := Rec.GetFilter("Global Dimension 2 Code");
                    SourceTableName := Dimension.GetMLName(GlobalLanguage);
                    if MaxStrLen(DimValue.Code) >= StrLen(SourceFilter) then
                        if DimValue.Get(GLSetup."Global Dimension 2 Code", SourceFilter) then
                            Description := DimValue.Name;
                end;
            Rec.GetFilter("Document Type") <> '':
                begin
                    SourceTableName := Rec.GetFilter("Document Type");
                    SourceFilter := Rec.GetFilter("Document No.");
                    Description := Rec.GetFilter("Document Line No.");
                end;
        end;
        exit(StrSubstNo('%1 %2 %3', SourceTableName, SourceFilter, Description));
    end;
}

