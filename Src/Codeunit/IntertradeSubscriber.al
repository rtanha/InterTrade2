codeunit 50001 "Intertrade subscriber (INT)"
{
    trigger OnRun()
    begin

    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Header", OnAfterValidateEvent, "Sell-to Customer No.", false, false)]
    local procedure OnAfterValidateSalesHeaderSellToCustomerNO(var xRec: Record "Sales Header"; var Rec: Record "Sales Header"; CurrFieldNo: Integer)
    var
        Cust: Record Customer;
    begin
        IF Cust.GET(Rec."Sell-to Customer No.") then begin
            Rec."Delivery Time From (INT)" := Cust."Delivery Time From (INT)";
            Rec."Delivery Time To (INT)" := Cust."Delivery Time To (INT)";
            Rec."Shipment Method City (INT)" := Cust."Place of Shipment Method (INT)";
            rec."Transaction Type" := Cust."Transaction Type (INT)";
            Rec."Transaction Specification" := Cust."T. Specification Code (INT)";
            Rec."Transport Method" := Cust."Transport Method (INT)";
        end;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Header", OnAfterValidateEvent, "Ship-to Code", false, false)]
    local procedure OnAfterValidateSalesHeaderShipToCode(var xRec: Record "Sales Header"; var Rec: Record "Sales Header"; CurrFieldNo: Integer)
    var
        Cust: Record Customer;
        ShipToAdress: Record "Ship-to Address";
    begin
        IF Rec."Ship-to Code" <> '' then begin
            ShipToAdress.Get(Rec."Sell-to Customer No.", Rec."Ship-to Code");
            Rec."Delivery Time From (INT)" := ShipToAdress."Delivery Time From (INT)";
            Rec."Delivery Time To (INT)" := ShipToAdress."Delivery Time To (INT)";
            Rec."Shipment Method City (INT)" := ShipToAdress."Place of Shipment Method (INT)";
        end else begin
            IF Rec."Sell-to Customer No." <> '' then begin
                Cust.GET(Rec."Sell-to Customer No.");
                Rec."Delivery Time From (INT)" := Cust."Delivery Time From (INT)";
                Rec."Delivery Time To (INT)" := Cust."Delivery Time To (INT)";
                Rec."Shipment Method City (INT)" := Cust."Place of Shipment Method (INT)";
            end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Release Sales Document", OnAfterReleaseSalesDoc, '', false, false)]
    local procedure OnAfterReleaseSalesDocument(var SalesHeader: Record "Sales Header"; PreviewMode: Boolean)
    var
        DocMgt: Codeunit "Document Management (INT)";
        SalesSetup: Record "Sales & Receivables Setup";
    begin
        IF Not PreviewMode then begin
            IF SalesHeader.IsTemporary then
                exit;
            IF SalesHeader."Document Type" = SalesHeader."Document Type"::Order then begin
                SalesSetup.GET();
                IF SalesSetup."Automatische Partienr. (INT)" then begin
                    DocMgt.CreateNewBatch(SalesHeader);
                end;
            end;

        end;
    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Release Sales Document", OnBeforeReleaseSalesDoc, '', false, false)]
    local procedure "Release Sales Document_OnBeforeReleaseSalesDoc"(var SalesHeader: Record "Sales Header"; PreviewMode: Boolean; SkipWhseRequestOperations: Boolean)

    VAR
        Batch: Record Batch;
        SalesLine: Record "Sales Line";
        SalesRecSetup: Record "Sales & Receivables Setup";
    BEGIN
        SalesRecSetup.Get();
        IF SalesRecSetup."Automatische Partienr. (INT)" then begin
            Batch.Code := SalesHeader."No.";
            Batch.Name := STRSUBSTNO('Auftrag %1', SalesHeader."No.");
            IF Batch.INSERT(TRUE) THEN;
            SalesLine.SETRANGE("Document Type", SalesHeader."Document Type");
            SalesLine.SETRANGE("Document No.", SalesHeader."No.");
            SalesLine.SETRANGE(Type, SalesLine.Type::"G/L Account");
            IF SalesLine.FINDFIRST THEN
                REPEAT
                    SalesLine."Batch No. (INT)" := SalesHeader."No.";
                    SalesLine.MODIFY;
                UNTIL SalesLine.NEXT = 0;
        end;
    END;

    [EventSubscriber(ObjectType::Codeunit, codeunit::"Sales Post Invoice Events", OnAfterPrepareInvoicePostingBuffer, '', false, false)]
    local procedure "Invoice Posting Buffer_OnAfterPrepareSales"(var InvoicePostingBuffer: Record "Invoice Posting Buffer" temporary; var SalesLine: Record "Sales Line")
    begin
        InvoicePostingBuffer."Batch No. (INT)" := SalesLine."Batch No. (INT)";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", OnBeforeSalesInvLineInsert, '', false, false)]
    local procedure "Sales-Post_OnBeforeSalesInvLineInsert"(var SalesInvLine: Record "Sales Invoice Line"; SalesInvHeader: Record "Sales Invoice Header"; SalesLine: Record "Sales Line"; CommitIsSuppressed: Boolean; var IsHandled: Boolean; PostingSalesLine: Record "Sales Line"; SalesShipmentHeader: Record "Sales Shipment Header"; SalesHeader: Record "Sales Header"; var ReturnReceiptHeader: Record "Return Receipt Header")
    begin
        SalesInvLine."Batch No. (INT)" := Salesline."Batch No. (INT)";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", OnBeforeSalesCrMemoLineInsert, '', false, false)]
    local procedure "Sales-Post_OnBeforeSalesCrMemoLineInsert"(var SalesCrMemoLine: Record "Sales Cr.Memo Line"; SalesCrMemoHeader: Record "Sales Cr.Memo Header"; SalesLine: Record "Sales Line"; CommitIsSuppressed: Boolean; var IsHandled: Boolean; var SalesHeader: Record "Sales Header"; var SalesShptHeader: Record "Sales Shipment Header"; var ReturnRcptHeader: Record "Return Receipt Header"; var PostingSalesLine: Record "Sales Line")
    begin
        SalesCrMemoLine."Batch No. (INT)" := SalesLine."Batch No. (INT)";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales Post Invoice Events", OnPostLinesOnBeforeGenJnlLinePost, '', false, false)]
    local procedure "Sales Post Invoice Events_OnPostLinesOnBeforeGenJnlLinePost"(var GenJnlLine: Record "Gen. Journal Line"; SalesHeader: Record "Sales Header"; TempInvoicePostingBuffer: Record "Invoice Posting Buffer" temporary; var GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line"; PreviewMode: Boolean; SuppressCommit: Boolean)
    begin
        genJnlLine."Batch No. (INT)" := TempInvoicePostingBuffer."Batch No. (INT)";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch. Post Invoice Events", OnPostLinesOnBeforeGenJnlLinePost, '', false, false)]
    local procedure "Purch. Post Invoice Events_OnPostLinesOnBeforeGenJnlLinePost"(var GenJnlLine: Record "Gen. Journal Line"; PurchHeader: Record "Purchase Header"; TempInvoicePostingBuffer: Record "Invoice Posting Buffer" temporary; var GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line"; PreviewMode: Boolean; SuppressCommit: Boolean)
    begin
        genJnlLine."Batch No. (INT)" := TempInvoicePostingBuffer."Batch No. (INT)";
    end;

    [EventSubscriber(ObjectType::Table, Database::"G/L Entry", OnAfterCopyGLEntryFromGenJnlLine, '', false, false)]
    local procedure "G/L Entry_OnAfterCopyGLEntryFromGenJnlLine"(var GLEntry: Record "G/L Entry"; var GenJournalLine: Record "Gen. Journal Line")
    begin
        GlEntry."Batch No. (INT)" := GenJournalLine."Batch No. (INT)";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch. Post Invoice Events", OnAfterPrepareInvoicePostingBuffer, '', false, false)]
    local procedure "Purch. Post Invoice Events_OnAfterPrepareInvoicePostingBuffer"(var PurchaseLine: Record "Purchase Line"; var InvoicePostingBuffer: Record "Invoice Posting Buffer" temporary)
    begin
        InvoicePostingBuffer."Batch No. (INT)" := PurchaseLine."Batch No. (INT)";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", OnBeforePurchInvLineInsert, '', false, false)]
    local procedure "Purch.-Post_OnBeforePurchInvLineInsert"(var PurchInvLine: Record "Purch. Inv. Line"; var PurchInvHeader: Record "Purch. Inv. Header"; var PurchaseLine: Record "Purchase Line"; CommitIsSupressed: Boolean; var xPurchaseLine: Record "Purchase Line")
    begin
        PurchInvLine."Batch No. (INT)" := PurchaseLine."Batch No. (INT)";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", OnBeforePurchCrMemoLineInsert, '', false, false)]
    local procedure "Purch.-Post_OnBeforePurchCrMemoLineInsert"(var PurchCrMemoLine: Record "Purch. Cr. Memo Line"; var PurchCrMemoHdr: Record "Purch. Cr. Memo Hdr."; var PurchLine: Record "Purchase Line"; CommitIsSupressed: Boolean; var xPurchaseLine: Record "Purchase Line")
    begin
        PurchCrMemoLine."Batch No. (INT)" := PurchLine."Batch No. (INT)";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Release Purchase Document", OnBeforeReleasePurchaseDoc, '', false, false)]
    local procedure "Release Purchase Document_OnBeforeReleasePurchaseDoc"(var PurchaseHeader: Record "Purchase Header"; PreviewMode: Boolean; var SkipCheckReleaseRestrictions: Boolean; var IsHandled: Boolean; SkipWhseRequestOperations: Boolean)
    VAR
        Batch: Record Batch;
        PurchLine: Record "Purchase Line";
        SalesRecSetup: Record "Sales & Receivables Setup";
    BEGIN
        SalesRecSetup.Get();
        IF SalesRecSetup."Automatische Partienr. (INT)" then begin
            PurchLine.SETRANGE("Document Type", PurchaseHeader."Document Type");
            PurchLine.SETRANGE("Document No.", PurchaseHeader."No.");
            PurchLine.SETRANGE(Type, PurchLine.Type::"G/L Account");
            IF PurchLine.FINDFIRST THEN
                REPEAT
                    PurchLine.TestField("Batch No. (INT)");
                UNTIL PurchLine.NEXT = 0;
        end;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Invoice Posting Buffer", OnBuildPrimaryKeyAfterDeferralCode, '', false, false)]
    local procedure "Invoice Posting Buffer_OnBuildPrimaryKeyAfterDeferralCode"(var GroupID: Text; InvoicePostingBuffer: Record "Invoice Posting Buffer" temporary)
    var
        InvPostingBuffer: Record "Invoice Posting Buffer";
        SalesSetup: Record "Sales & Receivables Setup";
    begin
        SalesSetup.Get();
        IF SalesSetup."Automatische Partienr. (INT)" then
            GroupID += InvPostingBuffer.PadField(InvoicePostingBuffer."Batch No. (INT)", MaxStrLen(InvoicePostingBuffer."Batch No. (INT)"));
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Line", OnAfterValidateEvent, "No.", false, false)]
    local procedure OnAfterValidateSalesLineItemNo(var xRec: Record "Sales Line"; var Rec: Record "Sales Line")
    var
        Item: Record Item;
    begin
        IF Rec.Type = Rec.Type::Item then begin
            IF Item.Get(Rec."No.") then
                Rec."Country of Origin (INT)" := Item."Country/Region of Origin Code";
        end;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Line", OnAfterValidateEvent, "No.", false, false)]
    local procedure OnAfterValidatePurchaseLineItemNo(var xRec: Record "Purchase Line"; var Rec: Record "Purchase Line")
    var
        Item: Record Item;
    begin
        IF Rec.Type = Rec.Type::Item then begin
            IF Item.Get(Rec."No.") then
                Rec."Country of Origin (INT)" := Item."Country/Region of Origin Code";
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Document-Mailing", OnBeforeGetToAddressFromCustomer, '', false, false)]
    local procedure "Document-Mailing_OnBeforeGetToAddressFromCustomer"(BillToCustomerNo: Code[20]; var ToAddress: Text[250]; var IsHandled: Boolean)
    var
        Customer: Record Customer;
    begin
        if Customer.Get(BillToCustomerNo) then
            if Customer."Invoice eMail (INT)" <> '' then begin
                ToAddress := Customer."Invoice eMail (INT)";
                IsHandled := true;
            end;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Header", OnAfterValidateEvent, "Sell-to Customer No.", false, false)]
    local procedure OnAfterValidateSalesHeaderSellToCustomer(var xRec: Record "Sales Header"; var Rec: Record "Sales Header")
    var
        Cust: Record Customer;
    begin
        Cust.Get(Rec."Sell-to Customer No.");
        Rec."Shipment Method City (INT)" := Cust."Place of Shipment Method (INT)";
        Rec."Transaction Type" := Cust."Transaction Type (INT)";
    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Header", OnAfterValidateEvent, "Buy-From Vendor No.", false, false)]
    local procedure OnAfterValidatePurchHeaderBuyFromVendorNo(var xRec: Record "Purchase Header"; var Rec: Record "Purchase Header")
    var
        Vend: Record Vendor;
    begin
        Vend.Get(Rec."Buy-from Vendor No.");
        Rec."Shipment Method City (INT)" := Vend."Place of Shipment Method (INT)";
        Rec."Transaction Type" := Vend."Transaction Type (INT)";
    end;

    [EventSubscriber(ObjectType::Table, Database::"Report Selections", OnGetEmailAddressOnAfterGetEmailAddressForCust, '', false, false)]
    local procedure "Report Selections_OnGetEmailAddressOnAfterGetEmailAddressForCust"(ReportUsage: Enum "Report Selection Usage"; RecordVariant: Variant; var TempBodyReportSelections: Record "Report Selections" temporary; var EmailAddress: Text[250]; CustNo: Code[20])
    var
        Customer: Record Customer;
    begin
        if Customer.Get(CustNo) then
            if Customer."Invoice eMail (INT)" <> '' then
                EmailAddress := Customer."Invoice eMail (INT)";
    end;

    [EventSubscriber(ObjectType::Table, Database::"Report Selections", OnBeforeGetEmailAddress, '', false, false)]
    local procedure "Report Selections_OnBeforeGetEmailAddress"(ReportUsage: Option; RecordVariant: Variant; var TempBodyReportSelections: Record "Report Selections" temporary; var EmailAddress: Text[250]; var IsHandled: Boolean; CustNo: Code[20])
    var
        Customer: Record Customer;
    begin
        if Customer.Get(CustNo) then
            if Customer."Invoice eMail (INT)" <> '' then begin
                EmailAddress := Customer."Invoice eMail (INT)";
                IsHandled := true;
            end;
    end;

}