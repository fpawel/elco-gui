unit UnitFormLastParty;

interface

uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
    System.Classes, Vcl.Graphics,
    Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, Vcl.StdCtrls,
    Vcl.Imaging.pngimage, Vcl.ExtCtrls, System.ImageList, Vcl.ImgList,
    server_data_types, product_column;

type
    TFormLastParty = class(TForm)
        StringGrid1: TStringGrid;
        PanelError: TPanel;
        ImageList1: TImageList;
        ComboBox1: TComboBox;
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
        procedure ComboBox1CloseUp(Sender: TObject);
        procedure ComboBox1DropDown(Sender: TObject);
        procedure ComboBox1Exit(Sender: TObject);
        procedure StringGrid1DblClick(Sender: TObject);
    private
        { Private declarations }
        Last_Edited_Col, Last_Edited_Row: Integer;

        FParty: TParty;
        FProducts: TArray<TProduct>;
        FColumns: TProductColumns;

        function GetProductValue(ColumnIndex, RowIndex: Integer): RProductValue;

        procedure DrawCellStr(ACol, ARow: Integer; Rect: TRect; ta: TAlignment;
          str: string);

        procedure DrawCellText(ACol, ARow: Integer; Rect: TRect;
          ta: TAlignment);

        procedure DrawCellFirmware(Rect: TRect; State: TGridDrawState);

        procedure UpdateSerial(ACol, ARow: Integer; Value: string);
        procedure UpdateNote(ACol, ARow: Integer; Value: string);
        procedure UpdateProductType(ACol, ARow: Integer; Value: string);

        property ProductValues[ColumnIndex, RowIndex: Integer]: RProductValue
          read GetProductValue;

    public
        { Public declarations }
        procedure reload_data;
        procedure Update_View;
        procedure SetCurrents(place: Integer; v: TArray<double>);

    end;

var
    FormLastParty: TFormLastParty;

implementation

uses stringgridutils, pipe, stringutils, superobject, server_data_types_helpers,
    services, UnitFormFirmware;

{$R *.dfm}

procedure TFormLastParty.FormCreate(Sender: TObject);
begin
    SetLength(FProducts, 96);
    reload_data;
    Update_View;
end;

procedure TFormLastParty.FormShow(Sender: TObject);
begin
    //
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

    case FColumns[ACol] of
        pcProdType:
            begin
                r := grd.CellRect(ACol, ARow);
                r.Left := r.Left + grd.Left;
                r.Right := r.Right + grd.Left;
                r.Top := r.Top + grd.Top;
                r.Bottom := r.Bottom + grd.Top;

                with ComboBox1 do
                begin
                    ItemIndex := Items.IndexOf(grd.Cells[ACol, ARow]);
                    if (ItemIndex = -1) then
                    begin
                        Items.Add(grd.Cells[ACol, ARow]);
                        ItemIndex := Items.IndexOf(grd.Cells[ACol, ARow]);
                    end;

                    Width := r.Width;
                    Left := r.Left;
                    Top := r.Top;
                    Visible := True;

                end;
            end;
    else
        begin
            ComboBox1.Visible := false;
        end;
    end;

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
            case TProductColumn(FColumns[ACol]) of
                pcSerial:
                    UpdateSerial(ACol, ARow, Value);
                pcNote:
                    UpdateNote(ACol, ARow, Value);
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
    p: TProduct;
begin
    if (GetAsyncKeyState(VK_LBUTTON) >= 0) then
        exit;
    StringGrid1.MouseToCell(X, Y, ACol, ARow);
    if ACol > 0 then
        exit;
    try
        p := FProducts[ARow - 1];
        p.FProductID := TLastParty.ToggleProductProductionAtPlace(p.FPlace);
        p.FProduction := not p.FProduction;
        PanelError.Visible := false;
    except
        on E: ERemoteError do
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
    ACol, ARow: Integer;
    pt: TPoint;
begin
    GetCursorPos(pt);
    pt := StringGrid1.ScreenToClient(pt);
    StringGrid1.MouseToCell(pt.X, pt.Y, ACol, ARow);
    if (ARow < 0) or (ARow > Length(FProducts)) then
        exit;
    FormFirmware.SetProduct(FProducts[ARow - 1]);
end;

procedure TFormLastParty.StringGrid1DrawCell(Sender: TObject;
  ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
var
    grd: TStringGrid;
    cnv: TCanvas;
    p: TProduct;

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
    else if p.FProductID > 0 then
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
              p.FProduction);
        pcFirmware:
            if p.FHasFirmware then
                DrawCellFirmware(Rect, State)
            else
                StringGrid1.Canvas.FillRect(Rect);
        pcStend:
            DrawCellText(ACol, ARow, Rect, ProdColumnAlignment(pcStend));
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
    p: TProduct;
    ACol: Integer;
begin

    with StringGrid1 do
    begin
        if EditorMode or (Row < 0) or (Key <> VK_DELETE) then
            exit;

        p := FProducts[Row - 1];
        if p.FProductID = 0 then
            exit;

        ComboBox1.Hide;

        if MessageDlg
          (Format('Подтвердите необходимость удаления данных ЭХЯ %s?',
          [ProductValues[0, Row - 1].Value]), mtConfirmation, [mbYes, mbNo], 0)
          <> mrYes then
            exit;

        try
            TLastParty.DeleteProductAtPlace(Row - 1);
            p.Free;
            p := TProduct.Create;
            p.FPlace := Row - 1;
            FProducts[Row - 1] := p;
            Cells[0, Row] := ProductValues[0, Row - 1].Value;
            for ACol := 1 to colcount - 1 do
                Cells[ACol, Row] := '';
            PanelError.Visible := false;
        except
            on E: ERemoteError do
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

procedure TFormLastParty.ComboBox1CloseUp(Sender: TObject);
begin
    with ComboBox1, StringGrid1 do
    begin
        if ItemIndex <> -1 then
            Cells[col, Row] := Items[ItemIndex]
        else
            Cells[col, Row] := '';
        UpdateProductType(col, Row, ComboBox1.Text)
    end;
    StringGrid1.SetFocus;
end;

procedure TFormLastParty.ComboBox1DropDown(Sender: TObject);
var
    i: string;
begin
    ComboBox1.Items.Clear;
    ComboBox1.Items.Add('');
    for i in TProductTypes.Names do
        ComboBox1.Items.Add(i);

end;

procedure TFormLastParty.ComboBox1Exit(Sender: TObject);
begin
    ComboBox1.Visible := false;
end;

procedure TFormLastParty.DrawCellFirmware(Rect: TRect; State: TGridDrawState);
var
    bmp: TBitmap;
begin
    bmp := TBitmap.Create;
    if gdSelected in State then
        ImageList1.GetBitmap(1, bmp)
    else
        ImageList1.GetBitmap(0, bmp);
    StringGrid1.Canvas.FillRect(Rect);
    StringGrid_DrawCellBmp(StringGrid1, Rect, bmp);
    bmp.Free
end;

procedure TFormLastParty.Update_View;
var
    ARow, ACol: Integer;

begin

    with StringGrid1 do
    begin
        colcount := Length(FColumns);
        RowCount := 96 + 1;
        FixedRows := 1;
        FixedCols := 1;
        ColWidths[0] := 80;

        for ACol := 0 to colcount - 1 do
        begin
            Cells[ACol, 0] := product_column_name[FColumns[ACol]];
            ColWidths[ACol] := ProductColumnWidth(FColumns[ACol],
              StringGrid1.Canvas, FParty.FProducts);
        end;

        for ARow := 1 to RowCount - 1 do
        begin
            for ACol := 0 to colcount - 1 do
            begin
                Cells[ACol, ARow] := ProductValues[ACol, ARow - 1].Value;
            end;
        end;
    end;
end;

procedure TFormLastParty.SetCurrents(place: Integer; v: TArray<double>);
var
    i: Integer;
begin
    for i := 0 to 7 do
        StringGrid1.Cells[3, 1 + place * 8 + i] := floattostr(v[i]);


end;

procedure TFormLastParty.reload_data;
var
    i: Integer;
begin
    FParty := TLastParty.Party;
    for i := 0 to 95 do
        FProducts[i] := nil;
    for i := 0 to Length(FParty.FProducts) - 1 do
        FProducts[FParty.FProducts[i].FPlace] := FParty.FProducts[i];

    for i := 0 to 95 do
    begin
        if not Assigned(FProducts[i]) then
        begin
            FProducts[i] := TProduct.Create;
            FProducts[i].FPlace := i;
        end;
    end;

    FColumns := GetProductColumns(FProducts, [pcPlace, pcStend, pcSerial,
      pcProdType, pcNote]);

end;

function TFormLastParty.GetProductValue(ColumnIndex, RowIndex: Integer)
  : RProductValue;
begin
    result := GetProductColumnValue(FProducts[RowIndex], FColumns[ColumnIndex]);

end;

procedure TFormLastParty.UpdateNote(ACol, ARow: Integer; Value: string);
var
    p: TProduct;

begin
    try
        p := FProducts[ARow - 1];
        p.FProductID := TLastParty.SetProductNoteAtPlace(p.FPlace, Value);
        p.FNote.FString := Value;
        p.FNote.FValid := True;
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

    if Value <> p.FNote.str then
        with StringGrid1 do
        begin
            OnSetEditText := nil;
            Cells[ACol, ARow] := p.FNote.str;
            OnSetEditText := StringGrid1SetEditText;
        end;
    StringGrid_RedrawRow(StringGrid1, ARow);

end;

procedure TFormLastParty.UpdateProductType(ACol, ARow: Integer; Value: string);
var
    p: TProduct;
begin
    try
        p := FProducts[ARow - 1];
        p.FProductID := TLastParty.SetProductTypeAtPlace(p.FPlace, Value);
        p.FProductTypeName.FString := Value;
        p.FProductTypeName.FValid := Trim(Value) <> '';
        PanelError.Visible := false;
    except
        on E: ERemoteError do
        begin

            PanelError.Caption := Format('%s: %s: "%s": %s',
              [ProductValues[0, ARow - 1].Value,
              product_column_name[pcProdType], Value, E.Message]);
            PanelError.Visible := True;
        end;
    end;

    if Value <> p.FProductTypeName.str then
        with StringGrid1 do
        begin
            OnSetEditText := nil;
            Cells[ACol, ARow] := p.FProductTypeName.str;
            OnSetEditText := StringGrid1SetEditText;
        end;
    StringGrid_RedrawRow(StringGrid1, ARow);

end;

procedure TFormLastParty.UpdateSerial(ACol, ARow: Integer; Value: string);
var
    p: TProduct;
begin
    try
        p := FProducts[ARow - 1];
        p.FProductID := TLastParty.SetProductSerialAtPlace(p.FPlace,
          strtoint(Value));
        p.FSerial.FInt64 := strtoint(Value);
        p.FSerial.FValid := True;
        PanelError.Visible := false;
    except
        on E: Exception do
        begin

            PanelError.Caption := Format('%s: %s: "%s": %s',
              [ProductValues[0, ARow - 1].Value, product_column_name[pcSerial],
              Value, E.Message]);
            PanelError.Visible := True;
        end;
    end;

    if Value <> p.FSerial.str then
        with StringGrid1 do
        begin
            OnSetEditText := nil;
            Cells[ACol, ARow] := p.FSerial.str;
            OnSetEditText := StringGrid1SetEditText;
        end;
    StringGrid_RedrawRow(StringGrid1, ARow);
end;

end.
