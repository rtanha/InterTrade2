tableextension 50026 "Message Entry" extends "CHGMXCMessage Entry"
{
    fields
    {
        field(50000; "File Content"; Blob)
        {
            Caption = 'File Content';
            DataClassification = AccountData;
            Access = Internal;
        }
    }

    /// <summary>
    /// Checks wheter file content is available for the current record
    /// </summary>
    /// <returns>Returns wheter file content is available for the current record</returns>
    procedure HasContent(): Boolean
    begin
        exit("File Content".HasValue());
    end;

    /// <summary>
    /// Returns the file content in the TempBlob.
    /// </summary>
    /// <param name="TempBlob">VAR Codeunit "Temp Blob" as Container for the file content.</param>
    /// <returns>Return wheter file content is available</returns>
    procedure GetContent(var TempBlob: Codeunit "Temp Blob"): Boolean
    var
        Result: Boolean;
    begin
        Result := false;
        if HasContent() then begin
            TempBlob.FromRecord(Rec, FieldNo("File Content"));
            Result := true;
        end;
        exit(Result);
    end;

    /// <summary>
    /// Saves the file content.
    /// </summary>
    /// <param name="TempBlob">VAR Codeunit "Temp Blob" as Container for the file content.</param>
    /// <returns>Returns wheter saving file content was successful</returns>
    procedure SetContent(var TempBlob: Codeunit "Temp Blob"): Boolean
    var
        MessageEntry: Record "CHGMXCMessage Entry";
        CurrRecordRef: RecordRef;
        Result: Boolean;
        outstream: OutStream;
        Instream: InStream;
    begin
        Result := false;
        if TempBlob.HasValue() then begin
            CurrRecordRef.GetTable(Rec);
            TempBlob.ToRecordRef(CurrRecordRef, FieldNo("File Content"));
            CurrRecordRef.SetTable(MessageEntry);
            "File Content" := MessageEntry."File Content";
            Modify();
            Result := true;
        end;
        exit(Result);
    end;


}
