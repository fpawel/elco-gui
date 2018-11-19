unit dbutils;

interface

uses FireDAC.Comp.Client;

type

    SQLFloat = record
        Value: double;
        ValueSet: boolean;
        function Str: string;
    end;

    SQLInt = record
        Value: integer;
        ValueSet: boolean;
        function Str: string;

    end;

    SQLBool = record
        Value: boolean;
        ValueSet: boolean;
    end;

function NewSQLFloat(q: TFDQuery; field_name: string): SQLFloat;
function NewSQLBool(q: TFDQuery; field_name: string): SQLBool;
function NewSQLInt(q: TFDQuery; field_name: string): SQLInt;

implementation

uses System.SysUtils, System.Variants;

function NewSQLFloat(q: TFDQuery; field_name: string): SQLFloat;
begin
    Result.ValueSet := q.FieldValues[field_name] <> System.Variants.Null;
    if Result.ValueSet then
        Result.Value := q.FieldValues[field_name]
    else
        Result.Value := 0;
end;

function NewSQLBool(q: TFDQuery; field_name: string): SQLBool;
begin
    Result.ValueSet := q.FieldValues[field_name] <> System.Variants.Null;
    if Result.ValueSet then
        Result.Value := q.FieldValues[field_name]
    else
        Result.Value := false;
end;

function NewSQLInt(q: TFDQuery; field_name: string): SQLInt;
begin
    Result.ValueSet := q.FieldValues[field_name] <> System.Variants.Null;
    if Result.ValueSet then
        Result.Value := q.FieldValues[field_name]
    else
        Result.Value := 0;
end;

function SQLInt.Str: string;
begin
    if ValueSet then
        exit(inttostr(Value))
    else
        exit('');
end;

function SQLFloat.Str: string;
begin
    if ValueSet then
        exit(floattostr(Value))
    else
        exit('');
end;

end.
