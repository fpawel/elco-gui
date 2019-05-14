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

implementation

uses sysutils, dateutils;

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
