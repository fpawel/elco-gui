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

function is_main_temperature(X: Double): Boolean;

implementation

uses sysutils, dateutils;

const
    main_temperatures: array [0 .. 7] of Double = (-40, -20, 0, 20, 30,
      40, 45, 50);

function is_main_temperature(X: Double): Boolean;
var
    t: Double;
begin
    for t in main_temperatures do
        if t = X then
            exit(true);
    exit(false);
end;

function TGoDateTimeHelper.DateTime: TDateTime;
begin
    exit(EncodeDateTime(Year, Month, Day, Hour, Minute, Second, Millisecond));
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
