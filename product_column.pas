﻿unit product_column;

interface

uses dbutils, classes, server_data_types, server_data_types_helpers,
    Vcl.graphics;

type
    TProductColumn = (pcPlace, pcSerial, pcProductID, pcFirmware,

      pcFon20, pcSens20, pcKSens20,

      pcFon20_2, pci24, pci35, pci26, pci17,

      pcD13, pcD24, pcD35, pcD26, pcD17,

      pcNotMeasured,

      pcFonMinus20, pcSensMinus20, pcKSensMinus20,

      pcFon50, pcSens50, pcKSens50,

       pcProdType,
      pcPointsMethod, pcNote);

type
    TValidProductValue = (vpvValid, vpvInvalid, vpvNotCheck);

    RProductValue = record
        Value: string;
        Valid: TValidProductValue;
    end;

    TProductColumns = TArray<TProductColumn>;
    TProductColumnsSet = set of TProductColumn;

const
    product_column_name: array [TProductColumn] of string = (

      '№', 'Зав.№', 'ID', 'прошивка',

      'ФОН20',  'Ч20', 'Kч20',

      'ФОН20.2', 'ПГС2', 'ПГС3', 'ПГС2.2', 'ПГС1',

      'D.ПГС1', 'D.ПГС2', 'D.ПГС3', 'D.ПГС2.2', 'D.ПГС1.2',


      'неизм.',

      'ФОН-20', 'Ч-20', 'Kч-20',

      'ФОН50', 'Ч50', 'Kч50',

       'исполнение', 'т.расчёт',
      'примечание');

function ProdVal(AValue: String): RProductValue;
function OkProdVal(AValue: String): RProductValue;
function BadProdVal(AValue: String): RProductValue;

function ProdColumnAlignment(pc: TProductColumn): TAlignment;

function GetProductColumnValue(product: TProductInfo; column: TProductColumn)
  : RProductValue;

function GetProductColumns(prods: TArray<TProductInfo>; cols: TProductColumnsSet)
  : TProductColumns;

function ProductColumnWidth(column: TProductColumn; canvas: TCanvas;
  prods: TArray<TProductInfo>): integer;

implementation

uses System.SysUtils;

function ff(v: TNullFloat64): string;
begin
    if v.Valid = true then
        Result := floattostr(v.Float64)
    else
        Result := '';
end;

function Chk2(v: TNullFloat64; a, b: boolean): RProductValue;
begin
    Result.Value := '';
    Result.Valid := vpvNotCheck;
    if v.Valid = false then
        exit;
    Result.Value := floattostr(v.Float64);

    if v.Valid = true then
    begin
        if a AND b then
            Result.Valid := vpvValid
        else
            Result.Valid := vpvInvalid;
    end;

end;

function Chk3(v: TNullFloat64; a, b, c: boolean): RProductValue;
begin
    Result.Value := '';
    Result.Valid := vpvNotCheck;
    if v.Valid = false then
        exit;
    Result.Value := floattostr(v.Float64);

    if v.Valid = true then
    begin
        if a AND b AND c then
            Result.Valid := vpvValid
        else
            Result.Valid := vpvInvalid;
    end;

end;

function Chk(v: TNullFloat64; c: boolean): RProductValue;
begin
    Result.Value := '';
    Result.Valid := vpvNotCheck;
    if v.Valid = false then
        exit;
    Result.Value := floattostr(v.Float64);

    if c then
        Result.Valid := vpvValid
    else
        Result.Valid := vpvInvalid;

end;

function GetProductColumnValue(product: TProductInfo; column: TProductColumn)
  : RProductValue;
begin
    Result.Valid := vpvNotCheck;
    Result.Value := '';
    if (product.ProductID = 0) AND (column <> pcPlace) then
        exit;

    with product do
        case column of
            pcPlace:
                exit(ProdVal(inttostr((Place div 8) + 1) + '.' +
                  inttostr((Place mod 8) + 1)));

            pcProductID:
                exit(ProdVal(inttostr(product.ProductID)));

            pcFirmware:
                ;

            pcSerial:
                if Serial.Valid = true then
                    Result.Value := inttostr(Serial.Int64);

            pcProdType:
                if ProductTypeName.Valid = true then
                    Result.Value := ProductTypeName.Str;
            pcFon20:
                Result := Chk2(IFPlus20, OkMinFon20, OkMaxFon20);
            pcFon20_2:
                Result := Chk2(I13, OkMinFon20r, OkMaxFon20r);
            pcSens20:
                Result := Chk2(ISPlus20, OkMinKSens20, OkMaxKSens20);
            pcKSens20:
                Result := Chk2(KSens20, OkMinKSens20, OkMaxKSens20);

            pcFonMinus20:
                Result.Value := ff(IFMinus20);
            pcSensMinus20:
                Result.Value := ff(ISMinus20);

            pcKSensMinus20:
                Result.Value := ff(KSensMinus20);

            pcFon50:
                Result := Chk(IFPlus50, OkDFon50);
            pcSens50:
                Result := Chk2(ISPlus50, OkMinKSens50, OkMaxKSens50);
            pcKSens50:
                Result := Chk2(KSens50, OkMinKSens50, OkMaxKSens50);

            pci24:
                Result := Chk(I24, OKMaxD24);
            pci35:
                Result := Chk(I35, OKMaxD35);
            pci26:
                Result := Chk(I26, OKMaxD26);
            pci17:
                Result := Chk(I17, OKMaxD17);

            pcD13:
                Result := Chk(D13, OKMaxD13);

            pcD24:
                Result := Chk(D24, OKMaxD24);
            pcD35:
                Result := Chk(D35, OKMaxD35);
            pcD26:
                Result := Chk(D26, OKMaxD26);
            pcD17:
                Result := Chk(D17, OKMaxD17);



            pcNotMeasured:
                Result := Chk(NotMeasured, OKDNotMeasured);

            pcPointsMethod:
                Result.Value := PointsMethod.GetStr;

            pcNote:
                Result.Value := NoteProduct.Str;
        else
            assert(false, 'uncmown case: ' + inttostr(integer(column)));
        end;

end;

function GetProductColumns(prods: TArray<TProductInfo>; cols: TProductColumnsSet)
  : TProductColumns;
var
    p: TProductInfo;
    c: TProductColumn;
begin
    // [pcCol0, pcSerial]
    for c := Low(TProductColumn) to High(TProductColumn) do
    begin
        for p in prods do
        begin
            if (c in cols) OR (GetProductColumnValue(p, c).Value <> '') or
              ((c = pcFirmware) AND p.HasFirmware) then
            begin
                SetLength(Result, Length(Result) + 1);
                Result[Length(Result) - 1] := c;
                break;
            end;
        end;
    end;
end;

function ProdVal(AValue: String): RProductValue;
begin
    with Result do
    begin
        Value := AValue;
        Valid := vpvNotCheck;
    end;
end;

function ProdColumnAlignment(pc: TProductColumn): TAlignment;
begin
    case pc of
        pcSerial:
            exit(taLeftJustify);
        pcProdType:
            exit(taCenter);
    else
        exit(taRightJustify);
    end;
end;

function OkProdVal(AValue: String): RProductValue;
begin
    with Result do
    begin
        Value := AValue;
        Valid := vpvValid;
    end;
end;

function BadProdVal(AValue: String): RProductValue;
begin
    with Result do
    begin
        Value := AValue;
        Valid := vpvInvalid;
    end;
end;

function ProductColumnWidth(column: TProductColumn; canvas: TCanvas;
  prods: TArray<TProductInfo>): integer;
var
    p: TProductInfo;
    w: integer;
begin

    case column of
        pcFirmware:
            Result := 30;
    else
        Result := 60;
    end;

    w := canvas.TextWidth(product_column_name[column]);
    if Result < w + 30 then
        Result := w + 30;
    for p in prods do
    begin
        w := canvas.TextWidth(GetProductColumnValue(p, column).Value);
        if Result < w + 30 then
            Result := w + 30;
    end;
end;

end.
