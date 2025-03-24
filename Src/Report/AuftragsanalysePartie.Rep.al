report 50015 "Auftragsanalyse Partie"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Src\Layout\Auftragsanalyse Partie.rdlc';
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("G/L Entry"; "G/L Entry")
        {
            DataItemTableView = SORTING("G/L Account No.", "Posting Date") WHERE("Batch No. (INT)" = FILTER(<> ''));
            RequestFilterFields = "Posting Date", "G/L Account No.", "Document Type", "Document No.", "Batch No. (INT)";
            column(Company; CompanyName)
            {
            }
            column(PostingDate_GLEntry; "G/L Entry"."Posting Date")
            {
            }
            column(DocumentType_GLEntry; "G/L Entry"."Document Type")
            {
            }
            column(DocumentNo_GLEntry; "G/L Entry"."Document No.")
            {
            }
            column(Description_GLEntry; "G/L Entry".Description)
            {
            }
            column(Amount_GLEntry; -"G/L Entry".Amount)
            {
            }
            column(Batch_No; "G/L Entry"."Batch No. (INT)")
            {
            }
            column(Account_No; "G/L Entry"."G/L Account No.")
            {
            }
            column(Source_Code; "G/L Entry"."Source Code")
            {
            }
            column(SourceNo; "G/L Entry"."Source No.")
            {
            }
            column("Filter"; Filter)
            {
            }

            trigger OnAfterGetRecord()
            begin
                if (CopyStr("G/L Entry"."G/L Account No.", 1, 1) <> '4') and (CopyStr("G/L Entry"."G/L Account No.", 1, 1) <> '5') then
                    CurrReport.Skip;
                SourceNo := "G/L Entry"."Source No.";
                if "G/L Entry"."Source Type" = "G/L Entry"."Source Type"::Customer then begin
                    customer.Get("G/L Entry"."Source No.");
                    SourceName := customer.Name;
                end;
                if "G/L Entry"."Source Type" = "G/L Entry"."Source Type"::Vendor then begin
                    Vendor.Get("G/L Entry"."Source No.");
                    SourceName := Vendor.Name;
                end;
            end;

            trigger OnPreDataItem()
            begin
                Filter := "G/L Entry".GetFilters;
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
        SourceNo: Code[20];
        SourceName: Text[50];
        customer: Record Customer;
        Vendor: Record Vendor;
        "Filter": Text;

    trigger OnPreReport()
    var
        DocumentMgt: Codeunit "Document Management (INT)";
    begin
        DocumentMgt.CopyBatchNoToGLEntry();
    end;
}

