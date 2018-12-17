unit config_helpers;

interface

uses server_data_types;

type
    TPropertyValueType = (VtInt, VtFloat, VtString, VtComportName,
      VtBaud, VtBool, VtNullFloat);

    TConfigSectionHelper = class helper for TConfigSection
    function HasError: boolean;
    end;

    TConfigPropertyHelper = class helper for TConfigProperty
        function GetBool: boolean;
        procedure SetBool(v: boolean);
        function GetHasError: boolean;
        function GetPropertyValueType: TPropertyValueType;
        procedure SetStr(str: string);

        property ValueType: TPropertyValueType read GetPropertyValueType;
        property HasError: boolean read GetHasError;
        property Bool: boolean read GetBool write SetBool;

    end;

implementation

uses sysutils, stringutils;

function TConfigSectionHelper.HasError: boolean;
var
    i: integer;
begin
    for i := 0 to length(self.FProperties) - 1 do
        if FProperties[i].HasError then
            Exit(true);
    Exit(false);
end;

function TConfigPropertyHelper.GetPropertyValueType: TPropertyValueType;
begin
    Exit(TPropertyValueType(FValueType));
end;

function TConfigPropertyHelper.GetBool: boolean;
begin
    if FValueType <> integer(VtBool) then
        raise Exception.Create('not bool: ' + IntToStr(FValueType));
    if LowerCase(FValue) = 'true' then
        Exit(true);
    if LowerCase(FValue) = 'false' then
        Exit(false);
    raise Exception.Create('not bool string: ' + FValue);
end;

procedure TConfigPropertyHelper.SetBool(v: boolean);
begin
    if self.FValueType <> integer(VtBool) then
        raise Exception.Create('not bool: ' + IntToStr(FValueType));
    if v then
        FValue := 'true'
    else
        FValue := 'false';
    FError := '';
end;

function TConfigPropertyHelper.GetHasError: boolean;
begin
    result := FError <> '';
end;

procedure TConfigPropertyHelper.SetStr(str: string);
var
    v: double;
    i, vInt: integer;
    ok, v_bool: boolean;
begin
    FError := '';
    str := str_validate_decimal_separator(str).Trim;
    FValue := str;
    if str = '' then
    begin
        if ValueType = VtNullFloat then
            FError := ''
        else
            FError := 'нет значения';
        Exit;
    end;

    if length(FList) > 0 then
    begin
        ok := false;
        for i := 0 to length(FList) - 1 do
        begin
            if FList[i] = str then
                ok := true;
        end;
        if not ok then
        begin
            FError := 'значение должно быть из списка: ' + FList[0];
            for i := 1 to length(FList) - 1 do
                FError := FError + '; ' + FList[i];
            Exit;
        end;
    end;

    ok := true;
    if (ValueType = VtInt) or (ValueType = VtBaud) then
    begin
        ok := TryStrToInt(str, vInt);
        v := vInt;
        if not ok then
            FError := 'не правильный синтаксис целого числа';
    end
    else if ValueType in [VtFloat, VtNullFloat] then
    begin
        ok := TryStrToFloat(str, v);
        if not ok then
            FError := 'не правильный синтаксис числа c плавающей точкой';
    end
    else if ValueType = VtBool then
    begin
        ok := TryStrToBool(str, v_bool);
        if not ok then
            FError := 'не правильный синтаксис логического значения';
    end;

    if ok then
    begin
        if FMin.FValid and (v < FMin.FFloat64) then
            FError := 'меньше ' + floattostr(FMin.FFloat64)
        else if FMax.FValid and (v > FMax.FFloat64) then
            FError := 'больше ' + floattostr(FMax.FFloat64);
    end;

end;


end.
