unit server_data_types_helpers;

interface

uses server_data_types;

type
    TSQLFloatHelper = class helper for TSQLFloat
      function GetStr: string;
      property Str : string read GetStr;
    end;

    TSQLStringHelper = class helper for TSQLString
      function GetStr: string;
      property Str : string read GetStr;
    end;

    TSQLInt64Helper = class helper for TSQLInt64
      function GetStr: string;
      property Str : string read GetStr;
    end;




implementation

uses sysutils;

function TSQLFloatHelper.GetStr: string;
begin
    if FValid then
        result := floattostr(FFloat64)
    else
        result := '';
end;

function TSQLStringHelper.GetStr: string;
begin
    if FValid then
        result := FString
    else
        result := '';
end;

function TSQLInt64Helper.GetStr: string;
begin
    if FValid then
        result := inttostr(FInt64)
    else
        result := '';
end;

end.
