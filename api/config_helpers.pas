unit config_helpers;

interface

uses server_data_types;

type
    TPropertyValueType = (VtInt, VtFloat, VtString, VtComportName, VtBaud,
      VtBool, VtNullFloat);

    TConfigSectionHelper = record helper for TConfigSection
        function HasError: boolean;
    end;

    TConfigPropertyHelper = record helper for TConfigProperty
        function GetBool: boolean;
        procedure SetBool(v: boolean);
        function GetHasError: boolean;
        function GetPropertyValueType: TPropertyValueType;
        procedure SetStr(str: string);

        property ValueTypeProp: TPropertyValueType read GetPropertyValueType;
        property HasError: boolean read GetHasError;
        property Bool: boolean read GetBool write SetBool;

    end;

implementation

uses sysutils, stringutils;

function TConfigSectionHelper.HasError: boolean;
var
    i: integer;
begin
    for i := 0 to length(self.Properties) - 1 do
        if Properties[i].HasError then
            Exit(true);
    Exit(false);
end;

function TConfigPropertyHelper.GetPropertyValueType: TPropertyValueType;
begin
    Exit(TPropertyValueType(ValueType));
end;

function TConfigPropertyHelper.GetBool: boolean;
begin
    if ValueTypeProp <> VtBool then
        raise Exception.Create('not bool: ' + IntToStr(integer(ValueType)));
    if LowerCase(Value) = 'true' then
        Exit(true);
    if LowerCase(Value) = 'false' then
        Exit(false);
    raise Exception.Create('not bool string: ' + Value);
end;

procedure TConfigPropertyHelper.SetBool(v: boolean);
begin
    if self.ValueTypeProp <> VtBool then
        raise Exception.Create('not bool: ' + IntToStr(integer(ValueType)));
    if v then
        Value := 'true'
    else
        Value := 'false';
    Error := '';
end;

function TConfigPropertyHelper.GetHasError: boolean;
begin
    result := Error <> '';
end;

procedure TConfigPropertyHelper.SetStr(str: string);
var
    v: double;
    i, vInt: integer;
    ok, v_bool: boolean;
begin
    Error := '';
    str := str.Trim;

    if ValueTypeProp in[ VtFloat, VtNullFloat] then
        str := str_validate_decimal_separator(str);

    Value := str;
    if str = '' then
    begin
        if ValueTypeProp = VtNullFloat then
            Error := ''
        else
            Error := 'нет значения';
        Exit;
    end;

    if length(List) > 0 then
    begin
        ok := false;
        for i := 0 to length(List) - 1 do
        begin
            if List[i] = str then
                ok := true;
        end;
        if not ok then
        begin
            Error := 'значение должно быть из списка: ' + List[0];
            for i := 1 to length(List) - 1 do
                Error := Error + '; ' + List[i];
            Exit;
        end;
    end;

    ok := true;
    if (ValueTypeProp = VtInt) or (ValueTypeProp = VtBaud) then
    begin
        ok := TryStrToInt(str, vInt);
        v := vInt;
        if not ok then
            Error := 'не правильный синтаксис целого числа';
    end
    else if ValueTypeProp in [VtFloat, VtNullFloat] then
    begin
        ok := TryStrToFloat(str, v);
        if not ok then
            Error := 'не правильный синтаксис числа c плавающей точкой';
    end
    else if ValueTypeProp = VtBool then
    begin
        ok := TryStrToBool(str, v_bool);
        if not ok then
            Error := 'не правильный синтаксис логического значения';
    end;

    if ok then
    begin
        if Min.Valid and (v < Min.Float64) then
            Error := 'меньше ' + floattostr(Min.Float64)
        else if Max.Valid and (v > Max.Float64) then
            Error := 'больше ' + floattostr(Max.Float64);
    end;

end;

end.
