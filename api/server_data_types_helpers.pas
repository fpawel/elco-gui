unit server_data_types_helpers;

interface

uses server_data_types;

type


    TNullFloat64Helper = record helper for TNullFloat64
        function GetStr: string;
        property Str: string read GetStr;
    end;

    TNullInt64Helper = record helper for TNullInt64
        function GetStr: string;
        property Str: string read GetStr;
    end;

implementation

uses sysutils, dateutils;

function TNullFloat64Helper.GetStr: string;
begin
    if Valid then
        result := floattostr(Float64)
    else
        result := '';
end;

function TNullInt64Helper.GetStr: string;
begin
    if Valid then
        result := IntToStr(Int64)
    else
        result := '';
end;

end.
