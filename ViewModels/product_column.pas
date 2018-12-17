unit product_column;

interface

uses dbutils, classes, server_data_types, server_data_types_helpers,
    Vcl.graphics;

type
    TProductColumn = (pcPlace, pcSerial, pcStend, pcFirmware, pcFon20,
      pcFon20_2, pcSens20, pcKSens20,

      pcFon50, pcSens50, pcKSens50,

      pcFonMinus20, pcSensMinus20,

      pci24, pci35, pci26, pci17, pcNotMeasured, pcProdType, pcNote);

type
    TValidProductValue = (vpvValid, vpvInvalid, vpvNotCheck);

    RProductValue = record
        Value: string;
        Valid: TValidProductValue;
    end;

    TProductColumns = TArray<TProductColumn>;
    TProductColumnsSet = set of TProductColumn;

const
    product_column_name: array [TProductColumn] of string = ('№', 'Зав.№',
      'показания', 'прошивка', 'ФОН.20', 'ФОН.20.2', 'Ч.20', 'Kч20', 'ФОН.50',
      'Ч.50', 'Kч50', 'ФОН.-20', 'Ч.-20', 'ПГС2', 'ПГС3', 'ПГС2.2', 'ПГС1',
      'неизм.', 'исполнение', 'примичание');

function ProdVal(AValue: String): RProductValue;
function OkProdVal(AValue: String): RProductValue;
function BadProdVal(AValue: String): RProductValue;

function ProdColumnAlignment(pc: TProductColumn): TAlignment;

function GetProductColumnValue(product: TProduct; column: TProductColumn)
  : RProductValue;

function GetProductColumns(prods: TArray<TProduct>; cols: TProductColumnsSet)
  : TProductColumns;

function ProductColumnWidth(column: TProductColumn; canvas: TCanvas;
  prods: TArray<TProduct>): integer;

implementation

uses System.SysUtils;

function ff(v: TNullFloat64): string;
begin
    if v.FValid then
        Result := floattostr(v.FFloat64)
    else
        Result := '';
end;

function Chk2(v: TNullFloat64; a, b: boolean): RProductValue;
begin
    Result.Value := '';
    Result.Valid := vpvNotCheck;
    if not v.FValid then
        exit;
    Result.Value := floattostr(v.FFloat64);

    if v.FValid then
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
    if not v.FValid then
        exit;
    Result.Value := floattostr(v.FFloat64);

    if v.FValid then
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
    if not v.FValid then
        exit;
    Result.Value := floattostr(v.FFloat64);

    if c then
        Result.Valid := vpvValid
    else
        Result.Valid := vpvInvalid;

end;

function GetProductColumnValue(product: TProduct; column: TProductColumn)
  : RProductValue;
begin
    Result.Valid := vpvNotCheck;
    Result.Value := '';
    with product do
        case column of
            pcPlace:
                exit(ProdVal(inttostr((FPlace div 8) + 1) + '.' +
                  inttostr((FPlace mod 8) + 1)));

            pcFirmware:
                ;

            pcSerial:
                if FSerial.FValid then
                    Result.Value := inttostr(FSerial.FInt64);

            pcStend:
                ;

            pcProdType:
                if FProductTypeName.FValid then
                    Result.Value := FProductTypeName.FString;
            pcFon20:
                Result := Chk2(FIFPlus20, FOkMinFon20, FOkMaxFon20);
            pcFon20_2:
                Result := Chk3(FI13, FOkDFon20, FOkMinFon20r, FOkMaxFon20r);
            pcSens20:
                Result := Chk2(FISPlus20, FOkMinKSens20, FOkMaxKSens20);
            pcKSens20:
                Result := Chk2(FKSens20, FOkMinKSens20, FOkMaxKSens20);

            pcFonMinus20:
                Result.Value := ff(FIFMinus20);
            pcSensMinus20:
                Result.Value := ff(FISMinus20);

            pcFon50:
                Result := Chk(FIFPlus50, FOkDFon50);
            pcSens50:
                Result := Chk2(FISPlus50, FOkMinKSens50, FOkMaxKSens50);
            pcKSens50:
                Result := Chk2(FKSens50, FOkMinKSens50, FOkMaxKSens50);

            pci24:
                Result.Value := ff(FI24);
            pci35:
                Result.Value := ff(FI35);
            pci26:
                Result.Value := ff(FI26);
            pci17:
                Result.Value := ff(FI17);
            pcNotMeasured:
                Result := Chk(FNotMeasured, FOKDNotMeasured);
            pcNote:
                Result.Value := FNote.Str;
        else
            assert(false, 'uncmown case: ' + inttostr(integer(column)));
        end;

end;

function GetProductColumns(prods: TArray<TProduct>; cols: TProductColumnsSet)
  : TProductColumns;
var
    p: TProduct;
    c: TProductColumn;
begin
    // [pcCol0, pcSerial]
    for c := Low(TProductColumn) to High(TProductColumn) do
    begin
        for p in prods do
        begin
            if (c in cols) OR (GetProductColumnValue(p, c).Value <> '') or
              ((c = pcFirmware) AND p.FHasFirmware) then
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
  prods: TArray<TProduct>): integer;
var
    p: TProduct;
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
