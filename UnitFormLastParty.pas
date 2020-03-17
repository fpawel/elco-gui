unit UnitFormLastParty;

interface

uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
    System.Classes, Vcl.Graphics,
    Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, Vcl.StdCtrls,
    Vcl.Imaging.pngimage, Vcl.ExtCtrls, System.ImageList, Vcl.ImgList,
    server_data_types, product_column, Vcl.Menus, System.Generics.Collections;

type
    TFormLastParty = class(TForm)
        StringGrid1: TStringGrid;
        PanelError: TPanel;
        ImageList1: TImageList;
        PopupMenu1: TPopupMenu;
        MenuCheck: TMenuItem;
        MenuUncheck: TMenuItem;
        N1: TMenuItem;
        N21: TMenuItem;
        N31: TMenuItem;
        N2: TMenuItem;
        MenuProductType: TMenuItem;
    N3: TMenuItem;
        procedure StringGrid1DrawCell(Sender: TObject; ACol, ARow: Integer;
          Rect: TRect; State: TGridDrawState);
        procedure StringGrid1SelectCell(Sender: TObject; ACol, ARow: Integer;
          var CanSelect: Boolean);
        procedure StringGrid1SetEditText(Sender: TObject; ACol, ARow: Integer;
          const Value: string);
        procedure StringGrid1MouseDown(Sender: TObject; Button: TMouseButton;
          Shift: TShiftState; X, Y: Integer);
        procedure FormShow(Sender: TObject);
        procedure FormCreate(Sender: TObject);
        procedure StringGrid1KeyDown(Sender: TObject; var Key: Word;
          Shift: TShiftState);
        procedure StringGrid1DblClick(Sender: TObject);
        procedure MenuCheckClick(Sender: TObject);
        procedure N2Click(Sender: TObject);
        procedure MenuProductTypeClick(Sender: TObject);
    procedure N3Click(Sender: TObject);
    private
        { Private declarations }
        Last_Edited_Col, Last_Edited_Row: Integer;

        FParty: TParty1;
        FProducts: TArray<TProductInfo>;
        FColumns: TProductColumns;

        FReadPlace, FReadBlock: Integer;

        FBmp: array [0..2] of TBitmap;

        function GetProductValue(ColumnIndex, RowIndex: Integer): RProductValue;

        procedure DrawCellStr(ACol, ARow: Integer; Rect: TRect; ta: TAlignment;
          str: string);

        procedure DrawCellText(ACol, ARow: Integer; Rect: TRect;
          ta: TAlignment);



        procedure UpdateSerial(ACol, ARow: Integer; Value: string);
        procedure UpdateNote(ACol, ARow: Integer; Value: string);

        property ProductValues[ColumnIndex, RowIndex: Integer]: RProductValue
          read GetProductValue;

    public
        { Public declarations }
        procedure SetProductionAll(production: Boolean);
        procedure SetProductionBlock(block: Integer; production: Boolean);
        procedure SetParty(party: TParty1);
        procedure upload;

        procedure SetReadPlace(APlace: Integer);
        procedure SetReadBlock(ABlock: Integer);

        procedure DrawCellFirmware(grd:TStringGrid;Rect: TRect; State: TGridDrawState; ACol, ARow:integer);

        property party: TParty1 read FParty;

    end;

var
    FormLastParty: TFormLastParty;

implementation

uses stringgridutils, stringutils, superobject, server_data_types_helpers,
    services, UnitFormFirmware, dateutils, UnitFormSelectProducts,  HttpExceptions,
    HttpRpcClient, UnitFormSelectStendPlacesDialog, UnitFormProductTypeDialog,
  UnitFormProductCurrents, UnitFormFirmwareChart, UnitFormProduct;

{$R *.dfm}

procedure TFormLastParty.FormCreate(Sender: TObject);
var
  I: Integer;

begin
    for I := 0 to 2 do
    begin
        FBmp[i] := TBitmap.Create;
        ImageList1.GetBitmap(i, FBmp[i]);
    end;
    FReadPlace := -1;
    FReadBlock := -1;
    SetLength(FProducts, 96);

end;

procedure TFormLastParty.FormShow(Sender: TObject);
begin
    upload;
end;

procedure TFormLastParty.StringGrid1SelectCell(Sender: TObject;
  ACol, ARow: Integer; var CanSelect: Boolean);
var
    r: TRect;
    grd: TStringGrid;

begin
    grd := Sender as TStringGrid;

    // When selecting a cell
    if grd.EditorMode then
    begin // It was a cell being edited
        grd.EditorMode := false; // Deactivate the editor
        // Do an extra check if the LastEdited_ACol and LastEdited_ARow are not -1 already.
        // This is to be able to use also the arrow-keys up and down in the Grid.
        if (Last_Edited_Col <> -1) and (Last_Edited_Row <> -1) then
            StringGrid1SetEditText(grd, Last_Edited_Col, Last_Edited_Row,
              grd.Cells[Last_Edited_Col, Last_Edited_Row]);
        // Just make the call
    end;
    // Do whatever else wanted

    if (ARow > 0) AND (FColumns[ACol] in [pcSerial, pcNote]) then
        grd.Options := grd.Options + [goEditing]
    else
        grd.Options := grd.Options - [goEditing];

    StringGrid_RedrawRow(grd, grd.Row);
    StringGrid_RedrawRow(grd, ARow);



end;

procedure TFormLastParty.StringGrid1SetEditText(Sender: TObject;
  ACol, ARow: Integer; const Value: string);
begin
    if ARow = 0 then
        exit;
    With StringGrid1 do
        // Fired on every change
        if Not EditorMode // goEditing must be 'True' in Options
        then
        begin // Only after user ends editing the cell
            Last_Edited_Col := -1; // Indicate no cell is edited
            Last_Edited_Row := -1; // Indicate no cell is edited
            // Do whatever wanted after user has finish editing a cell
            StringGrid1.OnSetEditText := nil;
            try
                case TProductColumn(FColumns[ACol]) of
                    pcSerial:
                        begin

                            UpdateSerial(ACol, ARow, Value);
                            // StringGrid1.col := ACol;
                            // StringGrid1.Row := ARow;
                            // SetForegroundWindow(StringGrid1.Handle);
                            // if StringGrid1.CanFocus then
                            // StringGrid1.SetFocus;
                        end;

                    pcNote:
                        UpdateNote(ACol, ARow, Value);
                end;
            finally
                StringGrid1.OnSetEditText := StringGrid1SetEditText;
            end;
        end
        else
        begin // The cell is being editted
            Last_Edited_Col := ACol; // Remember column of cell being edited
            Last_Edited_Row := ARow; // Remember row of cell being edited
        end;

end;

procedure TFormLastParty.StringGrid1MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
    ACol, ARow: Integer;
    p: ^TProductInfo;
begin
    if (GetAsyncKeyState(VK_LBUTTON) >= 0) then
        exit;
    StringGrid1.MouseToCell(X, Y, ACol, ARow);
    if (ACol > 0) or (ARow = 0) then
        exit;
    p := addr(FProducts[ARow - 1]);
    if p.ProductId = 0 then
        exit;

    try

        p.ProductId := TLastPartySvc.ToggleProductProductionAtPlace(p.Place);
        p.production := not p.production;
        PanelError.Visible := false;
    except
        on E: ERpcRemoteErrorException do
        begin
            PanelError.Caption := Format('%s: %s: %s',
              [ProductValues[0, ARow - 1].Value,
              product_column_name[FColumns[ACol]], E.Message]);
            PanelError.Visible := True;
        end;
    end;
    StringGrid_RedrawRow(StringGrid1, ARow);

end;

procedure TFormLastParty.StringGrid1DblClick(Sender: TObject);
var
    ACol, ARow, i: Integer;
    pt: TPoint;
    p: TProductInfo;
    f: Boolean;
begin
    GetCursorPos(pt);
    pt := StringGrid1.ScreenToClient(pt);
    StringGrid1.MouseToCell(pt.X, pt.Y, ACol, ARow);
    if (ARow = 0) and (ACol = 0) then
    begin
        pt := StringGrid1.ClientToScreen(pt);
        FormSelectProducts.Left := pt.X + 5;
        FormSelectProducts.Top := pt.Y + 5;
        FormSelectProducts.Show;
        exit;
    end;

    if ARow = 0 then
    begin
        for p in FProducts do
            if p.production = true then
            begin
                f := True;
                break;
            end;

        for p in FProducts do
            FProducts[p.Place].production := not f;

    end;
    if (ARow < 1) or (ARow > Length(FProducts)) then
        exit;
    if ACol > 0 then
    begin
        StringGrid1.EditorMode := false;
        with FormProduct do
        begin
            SetProduct(FProducts[ARow - 1]);
            Parent := self;
            Align := alRight;
            Font.Assign(self.Font);
            BorderStyle := bsNone;
            show;
        end;

    end;

end;

procedure TFormLastParty.StringGrid1DrawCell(Sender: TObject;
  ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
var
    grd: TStringGrid;
    cnv: TCanvas;
    p: TProductInfo;

begin
    grd := StringGrid1;
    cnv := grd.Canvas;
    cnv.Font.Assign(grd.Font);

    if ARow = 0 then
    begin
        StringGrid1.Canvas.Brush.Color := cl3DLight;
        DrawCellText(ACol, 0, Rect, taCenter);
        StringGrid_DrawCellBounds(StringGrid1.Canvas, ACol, 0, Rect);
        exit;
    end;

    p := FProducts[ARow - 1];

    if gdSelected in State then
        cnv.Brush.Color := clGradientInactiveCaption
    else if ARow = grd.Row then
        cnv.Brush.Color := clInfoBk
    else if (FReadPlace = ARow - 1) or ((ARow - 1) div 8 = FReadBlock) then
        cnv.Brush.Color := clSkyBlue
    else if p.ProductId > 0 then
    begin
        cnv.Brush.Color := grd.Color;
        // cnv.Font.Color := clNavy;
    end
    else
    begin
        cnv.Brush.Color := $F9F9F9;
        cnv.Font.Color := clGray;
    end;

    case TProductColumn(FColumns[ACol]) of
        pcPlace:
            StringGrid_DrawCheckBoxCell(StringGrid1, 0, ARow, Rect, State,
              p.production);
        pcFirmware:
            if p.HasFirmware = true then
                DrawCellFirmware( grd, Rect, State, ACol, ARow)
            else
                StringGrid1.Canvas.FillRect(Rect);

    else
        case ProductValues[ACol, ARow - 1].Valid of
            vpvInvalid:
                cnv.Font.Color := clRed;
            vpvValid:
                cnv.Font.Color := clBlue;
            vpvNotCheck:
                cnv.Font.Color := clBlack;
        end;
        DrawCellText(ACol, ARow, Rect, ProdColumnAlignment(FColumns[ACol]));
    end;

    StringGrid_DrawCellBounds(cnv, ACol, ARow, Rect);
end;

procedure TFormLastParty.StringGrid1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
    ACol: Integer;
begin

    with StringGrid1 do
    begin
        if EditorMode AND (Key = VK_RETURN) then
        begin
            if Row < Rowcount - 1 then
                Row := Row + 1
            else
                EditorMode := false;
            exit;
        end;

        if EditorMode or (Row < 0) or (Key <> VK_DELETE) then
            exit;

        if FProducts[Row - 1].ProductId = 0 then
            exit;

        if MessageDlg
          (Format('Подтвердите необходимость удаления данных ЭХЯ %s?',
          [ProductValues[0, Row - 1].Value]), mtConfirmation, [mbYes, mbNo], 0)
          <> mrYes then
            exit;

        try
            TLastPartySvc.DeleteProductAtPlace(Row - 1);
            upload;
            PanelError.Visible := false;
        except
            on E: ERpcRemoteErrorException do
            begin
                PanelError.Caption :=
                  Format('%s: %s: %s', [ProductValues[0, Row - 1].Value,
                  product_column_name[FColumns[ACol]], E.Message]);
                PanelError.Visible := True;
            end;
        end;

    end;

end;

procedure TFormLastParty.DrawCellStr(ACol, ARow: Integer; Rect: TRect;
  ta: TAlignment; str: string);
var
    X, Y, txt_width, txt_height: Integer;
begin
    with StringGrid1.Canvas do
    begin

        if TextWidth(str) + 3 > Rect.Width then
            str := cut_str(str, StringGrid1.Canvas, Rect.Width);
        txt_width := TextWidth(str);
        txt_height := TextHeight(str);
        X := Rect.Left + 3;
        if ta = taRightJustify then
            X := Rect.Right - 3 - round(txt_width)
        else if ta = taCenter then
            X := Rect.Left + round((Rect.Width - txt_width) / 2.0);
        Y := Rect.Top + round((Rect.Height - txt_height) / 2.0);
        TextRect(Rect, X, Y, str);
    end;
end;

procedure TFormLastParty.DrawCellText(ACol, ARow: Integer; Rect: TRect;
  ta: TAlignment);
begin
    DrawCellStr(ACol, ARow, Rect, ta, StringGrid1.Cells[ACol, ARow]);
end;

procedure TFormLastParty.DrawCellFirmware(grd:TStringGrid; Rect: TRect; State: TGridDrawState; ACol, ARow:integer);
var bmpIndex:integer;
begin
    if gdSelected in State then
        bmpIndex := 1
    else
        if ARow = grd.Row then
            bmpIndex := 2
        else
            bmpIndex := 0;
    grd.Canvas.FillRect(Rect);
    StringGrid_DrawCellBmp(grd, Rect, FBmp[bmpIndex]);
end;

procedure TFormLastParty.SetParty(party: TParty1);
var
    i: Integer;
    ARow, ACol: Integer;
    s: string;
    m: TMenuItem;
begin
    FParty := party;

    with Application.MainForm do
    begin
        Caption := Format('Партия ЭХЯ № %d, создана %s',
          [FParty.PartyID, FormatDateTime('dd MMMM yyyy hh:nn',
          IncHour(FParty.CreatedAt, 3))])
    end;

    for i := 0 to 95 do
    begin
        ZeroMemory(@FProducts[i],SizeOf(FProducts[i]));
        FProducts[i].Place := i;
    end;

    for i := 0 to Length(FParty.Products) - 1 do
        FProducts[FParty.Products[i].Place] := FParty.Products[i];

    FColumns := GetProductColumns(FProducts, [pcPlace, pcProductID, pcSerial, pcProdType, pcNote]);

    with StringGrid1 do
    begin
        colcount := Length(FColumns);
        Rowcount := 96 + 1;
        FixedRows := 1;
        FixedCols := 1;
        ColWidths[0] := 80;

        for ACol := 0 to colcount - 1 do
        begin
            Cells[ACol, 0] := product_column_name[FColumns[ACol]];
            ColWidths[ACol] := ProductColumnWidth(FColumns[ACol],
              StringGrid1.Canvas, FParty.Products);
        end;

        for ARow := 1 to Rowcount - 1 do
        begin
            for ACol := 0 to colcount - 1 do
            begin
                Cells[ACol, ARow] := ProductValues[ACol, ARow - 1].Value;
            end;
        end;
    end;

end;

procedure TFormLastParty.upload;
var p:TParty1;
begin
    p := TLastPartySvc.party;
    SetParty(p);
end;

function TFormLastParty.GetProductValue(ColumnIndex, RowIndex: Integer)
  : RProductValue;
begin
    result := GetProductColumnValue(FProducts[RowIndex], FColumns[ColumnIndex]);

end;

procedure TFormLastParty.MenuCheckClick(Sender: TObject);
var
    ARow: Integer;
    p: ^TProductInfo;
    ProductIDs: TArray<Int64>;

begin
    with StringGrid1 do
    begin
        for ARow := Selection.Top to Selection.Bottom do
        begin
            p := @FProducts[ARow - 1];
            if p.ProductId = 0 then
                Continue;
            p.production := Sender = MenuCheck;
            Cells[0, ARow] := GetProductColumnValue(p^, pcPlace).Value;
            SetLength(ProductIDs, Length(ProductIDs) + 1);
            ProductIDs[Length(ProductIDs) - 1] := p.ProductId;
        end;
    end;

    TPartiesCatalogueSvc.SetProductsProduction(ProductIDs, Sender = MenuCheck);
end;

procedure TFormLastParty.MenuProductTypeClick(Sender: TObject);
var
    pt: TPoint;
begin
    With StringGrid1 do
    begin
        FormProductTypeDialog.SetPlaces(Selection.Top - 1,
          Selection.Bottom - 1);
        pt := ClientToScreen(CellRect(Selection.Right, Selection.Bottom)
          .BottomRight);
        FormProductTypeDialog.Left := pt.X;
        FormProductTypeDialog.Top := pt.Y;
        FormProductTypeDialog.Show;
    end;
end;

procedure TFormLastParty.N2Click(Sender: TObject);
var
    ARow: Integer;
    p: ^TProductInfo;
begin
    with StringGrid1.Selection do
        TLastPartySvc.SetPointsMethodInPlacesRange(Top - 1, Bottom - 1,
          (Sender as TComponent).Tag);
    upload;

end;

procedure TFormLastParty.N3Click(Sender: TObject);
begin
    TPdfSvc.RunProductID(FProducts[StringGrid1.Row - 1].ProductID);
end;

procedure TFormLastParty.UpdateNote(ACol, ARow: Integer; Value: string);
var
    p: ^TProductInfo;

begin
    try
        p := addr(FProducts[ARow - 1]);
        p.ProductId := TLastPartySvc.SetProductNoteAtPlace(p.Place, Value);
        p.NoteProduct.str := Value;
        p.NoteProduct.Valid := True;
        PanelError.Visible := false;
    except
        on E: Exception do
        begin

            PanelError.Caption := Format('%s: %s: "%s": %s',
              [ProductValues[0, ARow - 1].Value, product_column_name[pcNote],
              Value, E.Message]);
            PanelError.Visible := True;
        end;
    end;

    if Value <> p.NoteProduct.str then
        with StringGrid1 do
        begin
            OnSetEditText := nil;
            Cells[ACol, ARow] := p.NoteProduct.str;
            OnSetEditText := StringGrid1SetEditText;
        end;
    StringGrid_RedrawRow(StringGrid1, ARow);

end;

procedure TFormLastParty.UpdateSerial(ACol, ARow: Integer; Value: string);
var
    p: ^TProductInfo;
begin
    try
        p := @FProducts[ARow - 1];
        if (p.ProductId = 0) AND (Trim(Value) = '') then
            exit;

        p.ProductId := TLastPartySvc.SetProductSerialAtPlace(p.Place,
          strtoint(Value));
        p.Serial.Int64 := strtoint(Value);
        p.Serial.Valid := True;
        PanelError.Visible := false;
    except
        on E: Exception do
        begin

            PanelError.Caption := Format('%s: %s: "%s": %s',
              [ProductValues[0, ARow - 1].Value, product_column_name[pcSerial],
              Value, E.Message]);
            PanelError.Visible := True;
            // StringGrid1.Options := StringGrid1.Options - [goEditing];
        end;
    end;

    if Value <> p.Serial.str then
        with StringGrid1 do
        begin
            OnSetEditText := nil;
            Cells[ACol, ARow] := p.Serial.str;
            OnSetEditText := StringGrid1SetEditText;
        end;
    StringGrid_RedrawRow(StringGrid1, ARow);
end;

procedure TFormLastParty.SetProductionAll(production: Boolean);
var
    p: TProductInfo;
begin
    TLastPartySvc.SelectAll(production);
    for p in FProducts do
    begin
        FProducts[p.Place].production := production;
        StringGrid_RedrawCell(StringGrid1, 0, p.Place + 1);
    end;

end;

procedure TFormLastParty.SetProductionBlock(block: Integer;
  production: Boolean);
var
    p: TProductInfo;
begin
    TLastPartySvc.SetBlockChecked(block, Integer(production));
    for p in FProducts do
        if (p.Place div 8) = block then
        begin
            FProducts[p.Place].production := production;
            StringGrid_RedrawCell(StringGrid1, 0, p.Place + 1);
        end;

end;

procedure TFormLastParty.SetReadBlock(ABlock: Integer);
var
    i, prevReadBlock: Integer;
begin
    if ABlock = FReadBlock then
        exit;

    prevReadBlock := FReadBlock;
    FReadBlock := ABlock;

    if (prevReadBlock > -1) then
        for i := prevReadBlock * 8 to (prevReadBlock + 1) * 8 do
            StringGrid_RedrawRow(StringGrid1, i + 1);

    for i := ABlock * 8 to (ABlock  + 1)* 8 do
        StringGrid_RedrawRow(StringGrid1, i + 1);
end;

procedure TFormLastParty.SetReadPlace(APlace: Integer);
var
    prevReadPlace: Integer;
begin
    if APlace = FReadPlace then
        exit;

    prevReadPlace := FReadPlace;
    FReadPlace := APlace;

    if (prevReadPlace > -1) then
        StringGrid_RedrawRow(StringGrid1, prevReadPlace + 1);
    StringGrid_RedrawRow(StringGrid1, APlace + 1);
end;

end.
