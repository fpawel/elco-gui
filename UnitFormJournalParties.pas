unit UnitFormJournalParties;

interface

uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
    System.Classes, Vcl.Graphics,
    Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Grids, Vcl.ExtCtrls,
    server_data_types, Vcl.Menus;

type
    TFormJournalParties = class(TForm)
        Panel1: TPanel;
        StringGrid1: TStringGrid;
        Panel3: TPanel;
        ComboBox1: TComboBox;
        Splitter1: TSplitter;
        PopupMenu1: TPopupMenu;
        MenuDeleteItem: TMenuItem;
        MenuCopyItem: TMenuItem;
        MenuPDF: TMenuItem;
        procedure FormCreate(Sender: TObject);
        procedure ComboBox1Change(Sender: TObject);
        procedure StringGrid1DrawCell(Sender: TObject; ACol, ARow: Integer;
          Rect: TRect; State: TGridDrawState);
        procedure StringGrid1SelectCell(Sender: TObject; ACol, ARow: Integer;
          var CanSelect: Boolean);
        procedure FormShow(Sender: TObject);
        procedure Panel1Resize(Sender: TObject);
        procedure MenuDeleteItemClick(Sender: TObject);
        procedure MenuCopyItemClick(Sender: TObject);
        procedure MenuPDFClick(Sender: TObject);
    procedure StringGrid1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    private
        { Private declarations }
        FParties: TArray<TParty2>;
        FYearMonth: TArray<TYearMonth>;
        function Party: TParty2;
        function PartyStr: string;
    public
        { Public declarations }
        procedure FetchYearsMonths;
    end;

var
    FormJournalParties: TFormJournalParties;

implementation

{$R *.dfm}

uses httprpcclient, dateutils, stringgridutils, stringutils, services,
    UnitFormParty, UnitFormLastParty;

procedure TFormJournalParties.FormCreate(Sender: TObject);
begin
    //
end;

procedure TFormJournalParties.FormShow(Sender: TObject);
begin
    //
end;

procedure TFormJournalParties.MenuCopyItemClick(Sender: TObject);
begin
    if StringGrid1.Row < 1 then
        exit;
    TRunnerSvc.CopyParty(Party.PartyID);
end;

procedure TFormJournalParties.MenuDeleteItemClick(Sender: TObject);
begin
    if StringGrid1.Row < 1 then
        exit;
    if MessageDlg('Поддтвердите запрос удаления данных: '#13#10#13#10 + PartyStr
      + #13#10#13#10'После удаления данные не могут быть воссатновлены.', mtWarning,
      mbOKCancel, 0) <> IDOK then
        TRunnerSvc.StopHardware;
    TPartiesCatalogueSvc.DeletePartyID(Party.PartyID);
    ComboBox1Change(nil);
end;

procedure TFormJournalParties.MenuPDFClick(Sender: TObject);
begin
    if StringGrid1.Row < 1 then
        exit;
    TPdfSvc.RunPartyID(Party.PartyID);
end;

procedure TFormJournalParties.Panel1Resize(Sender: TObject);
begin
    with StringGrid1 do
    begin
        ColWidths[0] := 60;
        ColWidths[1] := 60;
        ColWidths[2] := 90;
        ColWidths[3] := Panel1.Width - ColWidths[0] - ColWidths[1] -
          ColWidths[2] - 10;
        Repaint;
    end;
end;

procedure TFormJournalParties.StringGrid1DrawCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
var
    grd: TStringGrid;
    cnv: TCanvas;
    ta: TAlignment;

begin
    grd := StringGrid1;
    cnv := grd.Canvas;
    cnv.Font.Assign(grd.Font);
    cnv.Brush.Color := clWhite;

    if gdSelected in State then
        cnv.Brush.Color := clGradientInactiveCaption;

    ta := taLeftJustify;
    case ACol of
        0:
            begin
                ta := taCenter;
                cnv.Font.Color := clGreen;
            end;
        1:
            begin
                ta := taLeftJustify;
                cnv.Font.Color := clBlack;
            end;
    end;
    StringGrid_DrawCellText(StringGrid1, ACol, ARow, Rect, ta,
      StringGrid1.Cells[ACol, ARow]);
end;

procedure TFormJournalParties.StringGrid1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
    if Key =  VK_DELETE then
        MenuDeleteItem.Click;
end;

procedure TFormJournalParties.StringGrid1SelectCell(Sender: TObject;
  ACol, ARow: Integer; var CanSelect: Boolean);
begin
    if ARow - 1 >= length(FParties) then
        exit;
    FormParty.Party := services.TPartiesCatalogueSvc.Party
      (FParties[ARow - 1].PartyID);
    // FormChartSeries.Hide;
    // Mil82HttpGetResponseAsync(Format(Mil82HttpAddr + '/chart?bucket=%d',
    // [FBuckets[ARow - 1].BucketID]), OnResponse);
end;

procedure TFormJournalParties.ComboBox1Change(Sender: TObject);
var
    I: Integer;
begin

    with StringGrid1 do
    begin
        ColCount := 4;

        OnSelectCell := nil;
        with FYearMonth[ComboBox1.ItemIndex] do
            FParties := TPartiesCatalogueSvc.PartiesOfYearMonth(year, month);
        RowCount := length(FParties) + 1;
        if RowCount = 1 then
            exit;

        FixedRows := 1;
        Cells[0, 0] := 'День';
        Cells[1, 0] := '№';
        Cells[2, 0] := 'Исполнение';
        Cells[3, 0] := 'Заметка';

        for I := 0 to length(FParties) - 1 do
            with FParties[I] do
            begin
                Cells[0, I + 1] := IntToStr2(Day);
                Cells[1, I + 1] := IntToStr(PartyID);
                Cells[2, I + 1] := ProductTypeName;
                Cells[3, I + 1] := Note.str;
            end;
        Row := RowCount - 1;
        OnSelectCell := StringGrid1SelectCell;
        FormParty.Party := services.TPartiesCatalogueSvc.Party
            (FParties[length(FParties) - 1].PartyID);
    end;

end;

procedure TFormJournalParties.FetchYearsMonths;
var
    I: Integer;
    ym: TYearMonth;
begin
    ComboBox1.Clear;
    FYearMonth := TPartiesCatalogueSvc.YearsMonths;
    if length(FYearMonth) = 0 then
        with ym do
        begin
            year := YearOf(now);
            month := MonthOf(now);
            FYearMonth := [ym];
        end;

    for I := 0 to length(FYearMonth) - 1 do
        with FYearMonth[I] do
            ComboBox1.Items.Add(format('%d %s',
              [year, FormatDateTime('MMMM', IncMonth(0, month))]));

    ComboBox1.ItemIndex := 0;
    ComboBox1Change(nil);
end;


function TFormJournalParties.Party: TParty2;
begin
    result := FParties[StringGrid1.Row - 1];
end;

function TFormJournalParties.PartyStr: string;
begin
    result := format('№%d %s, день %s, %s', [Party.PartyID, ComboBox1.Text,
        inttostr2( Party.Day),
      Party.ProductTypeName]);
    if Party.Note.Valid = true then
        result := result + ', ' + Party.Note.str;

end;

end.
