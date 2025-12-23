report 50017 "Export Items to Excel"
{
    ProcessingOnly = true;
    Caption = 'Export Item to Excel';
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem(Item; Item)
        {
            RequestFilterFields = "No.";
            dataitem("Item Unit of Measure"; "Item Unit of Measure")
            {
                DataItemLink = "Item No." = FIELD("No.");
                DataItemTableView = SORTING("Item No.", Code);

                trigger OnAfterGetRecord()
                begin
                    ExcelBuffer.AddColumn("Item Unit of Measure".Code, false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
                    ExcelBuffer.AddColumn("Item Unit of Measure"."Qty. per Unit of Measure", false, '', false, false, false, '', ExcelBuffer."Cell Type"::Number);
                end;
            }

            trigger OnAfterGetRecord()
            var
                Country: Record "Country/Region";
            begin
                ExcelBuffer.NewRow;
                ExcelBuffer.AddColumn("No.", false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn(Description, false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn("Description 2", false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn("Base Unit of Measure", false, '', false, false, false, '', ExcelBuffer."Cell Type"::Number);
                ExcelBuffer.AddColumn(Item."Sales Unit of Measure", false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn(Item."Purch. Unit of Measure", false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn(Item."Gross Weight", false, '', false, false, false, '', ExcelBuffer."Cell Type"::Number);
                ExcelBuffer.AddColumn(Item."Net Weight", false, '', false, false, false, '', ExcelBuffer."Cell Type"::Number);
                ExcelBuffer.AddColumn(Item."Tariff No.", false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
                if Item."Country/Region of Origin Code" <> '' then
                    Country.Get(Item."Country/Region of Origin Code")
                else
                    Country.Init;
                ExcelBuffer.AddColumn(Country.Name, false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
            end;


            trigger OnPreDataItem()
            begin
                // ExcelBuffer.CreateNewBook('Artikelliste');

                ExcelBuffer.NewRow;
                ExcelBuffer.AddColumn('Artikelnr.', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn('Beschreibung', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn('Beschreibung 2', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn('Basis Einheit', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn('VK Einheit', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn('EK Einheit', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn('Brutto Gewicht', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn('Netto Gewicht', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn('Zoll Tarifnr.', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn('Ursprungsland', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn('Einheit 1', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn('Menge Pro Einheit 1', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn('Einheit 2', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn('Menge Pro Einheit 2', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn('Einheit 3', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn('Menge Pro Einheit 3', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn('Einheit 4', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn('Menge Pro Einheit 4', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn('Einheit 5', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn('Menge Pro Einheit 5', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
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

    trigger OnPostReport()
    var
        TempBloob: Codeunit "Temp Blob";
        OutStr: OutStream;
        InStream: InStream;
        FileName: Text;
    begin
        ExcelBuffer.WriteSheet('Artikelliste', CompanyName, UserId);
        // ExcelBuffer.CreateBook();
        TempBloob.CreateOutStream(OutStr);
        ExcelBuffer.SaveToStream(OutStr, false);
        TempBloob.CreateInStream(InStream);
        FileName := 'Artikelliste.xls';
        DownloadFromStream(InStream, 'Export', '', '', FileName);

        // ExcelBuffer.OpenExcel();
        // ExcelBuffer.CreateBookAndOpenExcel('Artikelliste','Report',CompanyName,UserId);
    end;

    var
        ExcelBuffer: Record "Excel Buffer" temporary;
}

