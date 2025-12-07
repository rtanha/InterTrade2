codeunit 50004 MessageManagement implements "CHGMXCMessage Management"
{
    Access = Internal;

    /// <summary>
    /// Returns whether the message entry can be exported or not.
    /// </summary>
    /// <param name="MXFileStorage">Current File Storage Entry</param>
    /// <param name="MXMessageEntry">Current Message Entry</param>
    /// <param name="MXPartner">Current MX Partner</param>
    /// <param name="MXMessageDef">Current Message Definition</param>
    /// <returns>Returns true if the message entry can be exported, otherwise it returns false.</returns>
    procedure CanExportFile(var MXFileStorage: Record "CHGMXCFile Storage"; var MXMessageEntry: Record "CHGMXCMessage Entry"; var MXPartner: Record CHGMXCPartner; var MXMessageDef: Record "CHGMXCMessage Def."): Boolean
    begin
        exit(true);
    end;

    /// <summary>
    /// Export File from Message Entry to File Storage
    /// </summary>
    /// <param name="MXFileStorage">File Storage should contain file data.</param>
    /// <param name="MXMessageEntry">Message Entry with the data which should be exported</param>
    /// <param name="MXPartner">MX Partner</param>
    /// <param name="MXMessageDef">Message Def. can contain information about how to export the data</param>
    procedure ExportFile(var MXFileStorage: Record "CHGMXCFile Storage"; var MXMessageEntry: Record "CHGMXCMessage Entry"; var MXPartner: Record CHGMXCPartner; var MXMessageDef: Record "CHGMXCMessage Def.")
    var
        TempBlob: Codeunit "Temp Blob";
        FileOutStream: OutStream;
    begin
        TempBlob.CreateOutStream(FileOutStream, TextEncoding::UTF8);
        // auf FileOutStream schreiben und MessageEntry."Entry No." muss im Datensatz angegeben werden
        MXFileStorage.SetContent(TempBlob);
    end;

    /// <summary>
    /// Returns whether the message entry can be imported or not.
    /// </summary>
    /// <param name="MXFileStorage">Current File Storage Entry</param>
    /// <param name="MXMessageEntry">Current Message Entry</param>
    /// <param name="MXPartner">Current MX Partner</param>
    /// <param name="MXMessageDef">Current Message Definition</param>
    /// <returns>Returns true if the message entry can be imported, otherwise it returns false.</returns>
    procedure CanImportFile(var MXFileStorage: Record "CHGMXCFile Storage"; var MXMessageEntry: Record "CHGMXCMessage Entry"; var MXPartner: Record CHGMXCPartner; var MXMessageDef: Record "CHGMXCMessage Def."): Boolean
    begin
        exit(true);
    end;

    /// <summary>
    /// ImportFile from File Storage to Message Entry related records
    /// </summary>
    /// <param name="MXFileStorage">Current File Storage Entry</param>
    /// <param name="MXMessageEntry">Current Message Entry</param>
    /// <param name="MXPartner">Current MX Partner</param>
    /// <param name="MXMessageDef">Current Message Definition</param>   
    procedure ImportFile(var MXFileStorage: Record "CHGMXCFile Storage"; var MXMessageEntry: Record "CHGMXCMessage Entry"; var MXPartner: Record CHGMXCPartner; var MXMessageDef: Record "CHGMXCMessage Def.")
    begin
    end;

    /// <summary>
    /// Returns whether the message entry can be processed or not.
    /// </summary>
    /// <param name="MXMessageEntry">Message entry with the data to process</param>
    /// <param name="MXPartner">Current MX Partner</param>
    /// <param name="MXMessageDef">Message Definition can contain information about how to process the data</param>
    /// <returns>Returns true if the message entry can be processed, otherwise it returns false.</returns>
    procedure CanProcessMessageEntry(var MXMessageEntry: Record "CHGMXCMessage Entry"; var MXPartner: Record CHGMXCPartner; var MXMessageDef: Record "CHGMXCMessage Def."): Boolean
    begin
    end;

    /// <summary>
    /// Processes the imported data from the message entry.
    /// </summary>
    /// <param name="MXMessageEntry">Message entry with the data to process</param>
    /// <param name="MXPartner">Current MX Partner</param>
    /// <param name="MXMessageDef">Message Definition can contain information about how to process the data</param>
    procedure ProcessMessageEntry(var MXMessageEntry: Record "CHGMXCMessage Entry"; var MXPartner: Record CHGMXCPartner; var MXMessageDef: Record "CHGMXCMessage Def.")
    begin
    end;

    /// <summary>
    /// Should show Message Card Page, but it actually does nothing, because this is the default implementation.
    /// </summary>
    /// <param name="MXMessageEntry">VAR Record "CHGMXCMessage Entry".</param>
    /// <param name="MXPartner">VAR Record CHGMXCPartner.</param>
    /// <param name="MXMessageDef">VAR Record "CHGMXCMessage Def.".</param>
    procedure ShowMessageCardPage(var MXMessageEntry: Record "CHGMXCMessage Entry"; var MXPartner: Record CHGMXCPartner; var MXMessageDef: Record "CHGMXCMessage Def.")
    var
    // EDIDocument: Record "CHGEDI Document";
    // PageManagement: Codeunit "Page Management";
    // EDIDocumentCounter: Integer;
    begin
        // EDIDocument.SetRange("Message Transfer Entry No.", MXMessageEntry."Entry No.");
        // EDIDocumentCounter := EDIDocument.Count();

        // if EDIDocumentCounter = 0 then
        //     exit;

        // if EDIDocumentCounter > 1 then
        //     Page.Run(Page::"CHGEDI Documents", EDIDocument);

        // if EDIDocumentCounter = 1 then begin
        //     EDIDocument.FindFirst();
        //     PageManagement.PageRun(EDIDocument);
        // end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::CHGMXCManagement, OnBeforeFileStorageInsert, '', false, false)]
    local procedure CHGMXCManagement_OnBeforeFileStorageInsert(var MXMessageEntry: Record "CHGMXCMessage Entry"; var MXFileStorage: Record "CHGMXCFile Storage")
    var
        TempBlob: Codeunit "Temp Blob";
    begin
        if MXMessageEntry."File Content".HasValue() then begin
            MXMessageEntry.GetContent(TempBlob);
            if TempBlob.HasValue() then
                MXFileStorage.SetContent(TempBlob);

        end;

    end;
}
