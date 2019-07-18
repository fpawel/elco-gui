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

    TGoDateTimeHelper = record helper for TGoDateTime
        function DateTime: TDateTime;
    end;



implementation

uses sysutils, dateutils;

function TGoDateTimeHelper.DateTime: TDateTime;
begin
    exit( EncodeDateTime(Year, Month, Day, Hour, Minute, Second, Millisecond) );
end;

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
