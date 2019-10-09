unit UnitFormNewPartyDialog;

interface

uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
    System.Classes, Vcl.Graphics,
    Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, Vcl.StdCtrls, Vcl.ExtCtrls,
    Vcl.Menus;

type
    TFormNewPartyDialog = class(TForm)
        Panel1: TPanel;
        Button1: TButton;
        PopupMenu1: TPopupMenu;
        N1: TMenuItem;
        N2: TMenuItem;
        N3: TMenuItem;
        StringGrid1: TStringGrid;
        N4: TMenuItem;
        Label1: TLabel;
        procedure FormCreate(Sender: TObject);
        procedure N1Click(Sender: TObject);
        procedure N2Click(Sender: TObject);
        procedure N3Click(Sender: TObject);
        procedure StringGrid1DrawCell(Sender: TObject; ACol, ARow: Integer;
          Rect: TRect; State: TGridDrawState);
        procedure N4Click(Sender: TObject);
        procedure StringGrid1SelectCell(Sender: TObject; ACol, ARow: Integer;
          var CanSelect: Boolean);
        procedure StringGrid1SetEditText(Sender: TObject; ACol, ARow: Integer;
          const Value: string);
        procedure Button1Click(Sender: TObject);
    private
        Last_Edited_Col, Last_Edited_Row: Integer;
        { Private declarations }
    public
        { Public declarations }
    end;

var
    FormNewPartyDialog: TFormNewPartyDialog;

implementation

{$R *.dfm}

uses stringgridutils, services;

procedure TFormNewPartyDialog.Button1Click(Sender: TObject);
var
    xs: TArray<int64>;
    cl, ro, n: Integer;
    v: int64;
begin
    SetLength(xs, 96);
    for ro := 1 to 12 do
        for cl := 1 to 8 do
            xs[(ro - 1) * 8 + cl - 1] :=
              StrToIntDef(StringGrid1.Cells[cl, ro], 0);
    TRunnerSvc.NewParty(xs);
    N4.Click;
    hide;

end;

procedure TFormNewPartyDialog.FormCreate(Sender: TObject);
var
    i: Integer;
begin
    Label1.hide;
    with StringGrid1 do
    begin
        ColCount := 9;
        RowCount := 13;
        for i := 0 to 11 do
            Cells[0, i + 1] := 'Ѕлок ' + inTTostr(i + 1);
        for i := 0 to 7 do
            Cells[i + 1, 0] := 'ћесто ' + inTTostr(i + 1);
    end;
    Last_Edited_Col := -1; // Indicate no cell is edited
    Last_Edited_Row := -1; // Indicate no cell is edited
end;

procedure TFormNewPartyDialog.N1Click(Sender: TObject);
begin
    StringGrid_CopytoClipboard(StringGrid1);
end;

procedure TFormNewPartyDialog.N2Click(Sender: TObject);
begin
    StringGrid_PasteFromClipBoard(StringGrid1);
end;

procedure TFormNewPartyDialog.N3Click(Sender: TObject);
var
    g: TGridRect;
begin
    with StringGrid1 do
    begin
        g.Left := 1;
        g.Top := 1;
        g.Bottom := RowCount - 1;
        g.Right := ColCount - 1;
        Selection := g;
    end;

end;

procedure TFormNewPartyDialog.N4Click(Sender: TObject);
var
    i: Integer;
    j: Integer;
begin
    with StringGrid1 do
        for i := 1 to ColCount - 1 do
            for j := 1 to RowCount - 1 do
                Cells[i, j] := '';
end;

procedure TFormNewPartyDialog.StringGrid1DrawCell(Sender: TObject;
  ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
var
    grd: TStringGrid;
    cnv: TCanvas;

begin
    grd := StringGrid1;
    cnv := grd.Canvas;
    cnv.Font.Assign(grd.Font);

    if (ARow = 0) or (ACol = 0) then
    begin
        StringGrid1.Canvas.Brush.Color := cl3DLight;
        StringGrid_DrawCellText(grd, ACol, ARow, Rect, taCenter,
          grd.Cells[ACol, ARow]);
        StringGrid_DrawCellBounds(StringGrid1.Canvas, ACol, ARow, Rect);
        exit;
    end;

    if gdSelected in State then
        cnv.Brush.Color := clGradientInactiveCaption
    else
        cnv.Brush.Color := grd.Color;

    StringGrid_DrawCellText(grd, ACol, ARow, Rect, taCenter,
      grd.Cells[ACol, ARow]);

    StringGrid_DrawCellBounds(cnv, ACol, ARow, Rect);
end;

procedure TFormNewPartyDialog.StringGrid1SelectCell(Sender: TObject;
  ACol, ARow: Integer; var CanSelect: Boolean);
var
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
end;

procedure TFormNewPartyDialog.StringGrid1SetEditText(Sender: TObject;
  ACol, ARow: Integer; const Value: string);
var
    serial: int64;
    cl, ro: Integer;
    dup_cl, dup_ro: Integer;
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
            serial := StrToIntDef(Value, 0);
            if serial <= 0 then
            begin
                Label1.Caption :=
                  Format('%d:%d невозможно получить положительное целое чесло из строки "%s"',
                  [ACol, ARow, Cells[ACol, ARow]]);
                Cells[ACol, ARow] := '';
                Label1.Show;
                exit;
            end;
            for cl := 1 to 8 do
                for ro := 1 to 12 do
                    if (cl <> ACol) AND (ro <> ARow) AND
                      (StrToInt64Def(Cells[cl, ro], 0) = serial) then
                    begin
                        Label1.Caption :=
                          Format('%d:%d дублирует значение в €чейке %d:%d',
                          [ACol, ARow, cl, ro]);
                        Cells[ACol, ARow] := '';
                        Label1.Show;
                        exit;
                    end;
            Label1.hide;
            exit;

        end
        else
        begin // The cell is being editted
            Last_Edited_Col := ACol; // Remember column of cell being edited
            Last_Edited_Row := ARow; // Remember row of cell being edited
        end;

end;

end.
