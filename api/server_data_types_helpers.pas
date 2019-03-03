unit server_data_types_helpers;

interface

uses server_data_types;

type
    

    TNullFloat64Helper = class helper for TNullFloat64
        function GetStr: string;
        property Str: string read GetStr;
    end;

    TNullStringHelper = class helper for TNullString
        function GetStr: string;
        property Str: string read GetStr;
    end;

    TNullInt64Helper = class helper for TNullInt64
        function GetStr: string;
        property Str: string read GetStr;
    end;

    TJournalEntryHelper = class helper for TJournalEntry
        function GetIsErrorLevel: Boolean;
        property IsErrorLevel: Boolean read GetIsErrorLevel;
    end;


implementation

uses sysutils, dateutils;

function TJournalEntryHelper.GetIsErrorLevel: Boolean;
begin
    result := (flevel = 'error') or (flevel = 'fatal') or (flevel = 'panic');
end;

function TNullFloat64Helper.GetStr: string;
begin
    if FValid then
        result := floattostr(FFloat64)
    else
        result := '';
end;

function TNullStringHelper.GetStr: string;
begin
    if FValid then
        result := FString
    else
        result := '';
end;

function TNullInt64Helper.GetStr: string;
begin
    if FValid then
        result := IntToStr(FInt64)
    else
        result := '';
end;

end.
