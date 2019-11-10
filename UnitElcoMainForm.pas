unit UnitElcoMainForm;

interface

uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
    System.Classes, Vcl.Graphics,
    Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls,
    Vcl.ComCtrls, Vcl.ToolWin, System.ImageList, Vcl.ImgList, Vcl.Grids,
    server_data_types, Vcl.Menus, ComponentBaloonHintU,
    Vcl.Imaging.pngimage, inifiles;

type
    EHostApplicationPanic = class(Exception);

    TElcoMainForm = class(TForm)
        ImageList3: TImageList;
        ImageList4: TImageList;
        ToolBarStop: TToolBar;
        ToolButton2: TToolButton;
        Panel3: TPanel;
        ImageList90: TImageList;
        LabelStatusTop: TLabel;
        PanelDelay: TPanel;
        LabelDelayElepsedTime: TLabel;
        LabelProgress: TLabel;
        ToolBar6: TToolBar;
        ToolButtonStop: TToolButton;
        Panel2: TPanel;
        ProgressBar1: TProgressBar;
        TimerPerforming: TTimer;
        PanelPlaceholderMain: TPanel;
        PanelMessageBox: TPanel;
        ImageError: TImage;
        PanelMessageBoxTitle: TPanel;
        ToolBar2: TToolBar;
        ToolButton3: TToolButton;
        RichEditlMessageBoxText: TRichEdit;
        ImageInfo: TImage;
        GridPanelBottom: TGridPanel;
        LabelStatusBottom: TLabel;
        LabelStatusKtx500: TLabel;
        MainMenu1: TMainMenu;
        N10: TMenuItem;
        N11: TMenuItem;
        N12: TMenuItem;
        MenuGetCurrents: TMenuItem;
        MenuSetGas: TMenuItem;
        N15: TMenuItem;
        N17: TMenuItem;
        N18: TMenuItem;
        N19: TMenuItem;
        I201: TMenuItem;
        I501: TMenuItem;
        N20: TMenuItem;
        PDF2: TMenuItem;
        N21: TMenuItem;
        N22: TMenuItem;
        PageControlMain: TPageControl;
        TabSheetParty: TTabSheet;
        TabSheetAppSettings: TTabSheet;
        TabSheetArchiveParties: TTabSheet;
        TabSheetTermoChamber: TTabSheet;
        TabSheetConsole: TTabSheet;
        TabSheetScenary: TTabSheet;
        TabSheetInterrogate: TTabSheet;
        N1: TMenuItem;
        TabSheetFindProduct: TTabSheet;
        procedure FormCreate(Sender: TObject);
        procedure FormShow(Sender: TObject);
        procedure FormResize(Sender: TObject);
        procedure ToolButton3Click(Sender: TObject);
        procedure ToolButton2Click(Sender: TObject);
        procedure FormClose(Sender: TObject; var Action: TCloseAction);
        procedure ToolButtonStopClick(Sender: TObject);
        procedure RichEditlMessageBoxTextMouseDown(Sender: TObject;
          Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
        procedure TimerPerformingTimer(Sender: TObject);
        procedure N201Click(Sender: TObject);
        procedure N202Click(Sender: TObject);
        procedure N203Click(Sender: TObject);
        procedure PDF1Click(Sender: TObject);
        procedure N11Click(Sender: TObject);
        procedure N12Click(Sender: TObject);
        procedure N15Click(Sender: TObject);
        procedure N18Click(Sender: TObject);
        procedure I201Click(Sender: TObject);
        procedure N20Click(Sender: TObject);
        procedure PDF2Click(Sender: TObject);
        procedure PageControlMainDrawTab(Control: TCustomTabControl;
          TabIndex: Integer; const Rect: TRect; Active: Boolean);
        procedure PageControlMainChange(Sender: TObject);
    private
        { Private declarations }
        FInitialized: Boolean;
        FhWndTip: THandle;

        function ExceptionDialog(e: Exception): Boolean;
        procedure AppException(Sender: TObject; e: Exception);

        procedure RunReadAndSaveProductCurrentsMenuClick(Sender: TObject);
        procedure RunSwitchGasMenuClick(Sender: TObject);

        procedure SetupDelay(i: TDelayInfo);

        procedure HandleCopydata(var Message: TMessage); message WM_COPYDATA;
        procedure WMWindowPosChanged(var AMessage: TMessage);
          message WM_WINDOWPOSCHANGED;
        procedure WMEnterSizeMove(var Msg: TMessage); message WM_ENTERSIZEMOVE;

        procedure WMActivateApp(var AMessage: TMessage); message WM_ACTIVATEAPP;

        procedure OnReadCurrent(v: TReadCurrent);
        procedure OnWorkComplete(X: TWorkResult);
        procedure OnWarning(content: string);

    public
        { Public declarations }
        FIni: TIniFile;
        procedure ShowBalloonTip(c: TWinControl; Icon: TIconKind;
          const Title, Text: string);
    end;

var

    ElcoMainForm: TElcoMainForm;

function FormatFloatArray(v: TArray<double>): string;

Function GetTextSize(const Text: String; Font: TFont): TSize;

implementation

{$R *.dfm}

uses stringgridutils, stringutils, JclDebug,
    superobject, UnitFormLastParty, vclutils,
    services, UnitFormParty,
    notify_services, UnitFormEditAppConfig, UnitFormSelectStendPlacesDialog,
    ioutils,
    dateutils, math, UnitFormSelectTemperaturesDialog, richeditutils, parproc,
    uitypes, types, UnitFormFirmware,
    UnitFormInterrogate, UnitFormConsole, UnitFormKtx500, HttpRpcClient,
    UnitFormAppConfig, UnitFormJournalParties, UnitFormModalMessage,
    UnitFormJournalProducts, UnitFormPopup, UnitFormNewPartyDialog,
    UnitFormFirmwareChart, UnitFormProductCurrents, UnitFormScriptSource,
    logfile;

const
    WorkItems: array [0 .. 11, 0 .. 1] of string = (('20"C ПГС1', 'i_f_plus20'),
      ('20"C ПГС3', 'i_s_plus20'), ('20"C ПГС1(2)', 'i13'),
      ('-20"C ПГС1', 'i_f_minus20'), ('-20"C ПГС3', 'i_s_minus20'),
      ('50"C ПГС1', 'i_f_plus50'), ('50"C ПГС3', 'i_s_plus50'), ('ПГС2', 'i24'),
      ('ПГС3', 'i35'), ('ПГС2', 'i26'), ('ПГС1', 'i17'),
      ('неизмеряемый', 'not_measured'));

    GasTempItems: array [0 .. 11, 0 .. 1] of Integer = ((1, 20), (3, 20),
      (1, 20), (1, -20), (3, -20), (1, 50), (3, 50), (2, 20), (3, 20), (2, 20),
      (1, 20), (0, 20));

procedure ShowFormCenterScreen(AForm: TForm);
begin
    // AForm.Parent := ElcoMainForm;
    AForm.Position := poScreenCenter;
    AForm.Show;
    ShowWindow(AForm.Handle, SW_RESTORE);
end;

procedure TElcoMainForm.FormCreate(Sender: TObject);
var
    i: Integer;
    menu: TMenuItem;
begin
    if GetParentProcessName = 'cmd.exe' then
        Writeln('we are cmd.exe');

    PanelMessageBox.Width := 700;
    PanelMessageBox.Height := 350;

    FIni := TIniFile.Create(ExtractFileDir(paramstr(0)) + '\main.ini');
    FInitialized := false;
    Application.OnException := AppException;
    LabelStatusTop.Caption := '';
    LabelStatusBottom.Caption := '';

    for i := 0 to length(WorkItems) - 1 do
    begin
        menu := TMenuItem.Create(self);
        MenuGetCurrents.Add(menu);
        menu.Caption := WorkItems[i, 0];
        menu.Tag := i;
        menu.OnClick := RunReadAndSaveProductCurrentsMenuClick;
    end;

    for i := 0 to 4 do
    begin
        menu := TMenuItem.Create(self);
        MenuSetGas.Add(menu);
        if i = 0 then
            menu.Caption := 'Отключить газ'
        else
            menu.Caption := 'ПГС' + inttostr(i);

        menu.Tag := i;
        menu.OnClick := RunSwitchGasMenuClick;
    end;

end;

procedure TElcoMainForm.FormShow(Sender: TObject);
var
    wp: WINDOWPLACEMENT;
    fs: TFileStream;
    FileName: string;
    i: Integer;

    procedure MakeInlineForm(AForm: TForm; tbs: TTabSheet);
    begin
        with AForm do
        begin
            Font.Assign(self.Font);
            Parent := tbs;
            BorderStyle := bsNone;
            Align := alClient;
            Show;
        end;
    end;

begin
    if FInitialized then
        exit;
    FInitialized := true;

    FileName := TPath.Combine(ExtractFilePath(paramstr(0)), 'window.position');
    if FileExists(FileName) then
    begin
        fs := TFileStream.Create(FileName, fmOpenRead);
        fs.Read(wp, SizeOf(wp));
        fs.Free;
        SetWindowPlacement(Handle, wp);
    end;

    with FormSelectStendPlacesDialog.CheckListBox1 do
        for i := 0 to 11 do
            Checked[i] := FIni.ReadBool('FormSelectStendPlacesDialog',
              inttostr(i), false);

    with FormSelectTemperaturesDialog.CheckListBox1 do
        for i := 0 to 2 do
            Checked[i] := FIni.ReadBool('FormSelectTemperaturesDialog',
              inttostr(i), false);

    FormLastParty.reload_data;
    MakeInlineForm(FormLastParty, TabSheetParty);
    with FormParty do
    begin
        Font.Assign(self.Font);
        Parent := FormJournalParties;
        BorderStyle := bsNone;
        Align := alClient;
        Party := services.TLastPartySvc.Party;
        Show;
    end;
    FormJournalParties.FetchYearsMonths;
    MakeInlineForm(FormJournalParties, TabSheetArchiveParties);
    FormAppConfig.Upload;
    MakeInlineForm(FormAppConfig, TabSheetAppSettings);
    MakeInlineForm(FormKtx500, TabSheetTermoChamber);
    MakeInlineForm(FormConsole, TabSheetConsole);
    MakeInlineForm(FormScriptSource, TabSheetScenary);
    MakeInlineForm(FormInterrogate, TabSheetInterrogate);
    MakeInlineForm(FormJournalProducts, TabSheetFindProduct);

    SetOnReadCurrent(OnReadCurrent);

    SetOnWorkStarted(
        procedure(s: string)
        begin
            PanelMessageBox.Hide;
            ToolBarStop.Show;
            LabelStatusTop.Caption := TimeToStr(now) + ' ' + s;
            TimerPerforming.Enabled := true;
            LabelStatusBottom.Caption := '';
            FormLastParty.SetReadPlace(-1);
            FormLastParty.SetReadBlock(-1);
        end);

    SetOnWorkComplete(OnWorkComplete);

    SetOnStatus(
        procedure(s: string)
        begin
            LabelStatusTop.Caption := TimeToStr(now) + ' ' + s;
        end);

    SetOnWarning(OnWarning);

    SetOnLastPartyChanged(
        procedure(party: TParty1)
        begin
            FormLastParty.SetParty(party);
            FormJournalParties.FetchYearsMonths;
        end);

    SetOnReadFirmware(FormFirmware.SetReadFirmwareInfo);
    SetOnPanic(
        procedure(pnicStr: String)
        begin
            NotifyServices_SetEnabled(false);
            Application.ShowException(EHostApplicationPanic.Create(pnicStr));
            Application.Terminate;

        end);

    SetOnWriteConsole(
        procedure(s: String)
        begin
            FormConsole.NewLine(s);
            Application.ProcessMessages;
        end);

    SetOnKtx500Error(
        procedure(s: string)
        begin
            LabelStatusKtx500.Font.Color := clRed;
            LabelStatusKtx500.Caption := TimeToStr(now) + ' ' + s;
        end);

    SetOnKtx500Info(
        procedure(X: TKtx500Info)
        var
            strOn, strCool: string;
        begin
            FormKtx500.AddEntry(X);
            LabelStatusKtx500.Font.Color := clRed;
            if X.TemperatureOn = true then
                strOn := 'вкл.'
            else
                strOn := 'выкл.';
            if X.CoolOn = true then
                strCool := ' компрессор'
            else
                strCool := '';
            LabelStatusKtx500.Font.Color := clNavy;
            LabelStatusKtx500.Caption :=

              Format('%s %s %s"C-->%s"C%s', [TimeToStr(now), strOn,
              floattostr(X.Temperature), floattostr(X.Destination), strCool])
        end);

    SetOnReadPlace(FormLastParty.SetReadPlace);
    SetOnReadBlock(FormLastParty.SetReadBlock);

    SetOnDelay(SetupDelay);
    SetOnEndDelay(
        procedure(s: string)
        begin
            PanelDelay.Hide;
        end);
    SetOnScriptLine(FormScriptSource.OnScriptLine);

    NotifyServices_SetEnabled(true);
    TRunnerSvc.StopHardware;
end;

procedure TElcoMainForm.FormClose(Sender: TObject; var Action: TCloseAction);
var
    wp: WINDOWPLACEMENT;
    fs: TFileStream;
    i: Integer;
begin

    NotifyServices_SetEnabled(false);
    try
        TRunnerSvc.StopHardware;
    except
    end;

    fs := TFileStream.Create(TPath.Combine(ExtractFilePath(paramstr(0)),
      'window.position'), fmOpenWrite or fmCreate);
    if not GetWindowPlacement(Handle, wp) then
        raise Exception.Create('GetWindowPlacement: false');
    fs.Write(wp, SizeOf(wp));
    fs.Free;

    if Assigned(FormSelectStendPlacesDialog) then
        with FormSelectStendPlacesDialog.CheckListBox1 do
            for i := 0 to 11 do
                FIni.WriteBool('FormSelectStendPlacesDialog', inttostr(i),
                  Checked[i]);

    if Assigned(FormSelectTemperaturesDialog) then
        with FormSelectTemperaturesDialog.CheckListBox1 do
            for i := 0 to 2 do
                FIni.WriteBool('FormSelectTemperaturesDialog', inttostr(i),
                  Checked[i]);

    // SendMessage(FindWindow('ElcoServerWindow', nil), WM_CLOSE, 0, 0);
end;

procedure TElcoMainForm.FormResize(Sender: TObject);
begin
    if PanelMessageBox.Visible then
    begin
        PanelMessageBox.Left := ClientWidth div 2 - PanelMessageBox.Width div 2;
        PanelMessageBox.Top := ClientHeight div 2 -
          PanelMessageBox.Height div 2;
    end;
end;

procedure TElcoMainForm.PageControlMainChange(Sender: TObject);
var
    PageControl: TPageControl;
begin
    PageControl := Sender as TPageControl;
    PageControl.Repaint;
    if PageControl.ActivePage = TabSheetParty then
        FormLastParty.reload_data
    else if PageControl.ActivePage = TabSheetArchiveParties then
        FormJournalParties.FetchYearsMonths
    else if PageControl.ActivePage = TabSheetInterrogate then
        FormInterrogate.UpdateCheckBlocks
    else if PageControl.ActivePage = TabSheetAppSettings then
        FormAppConfig.Upload;

end;

procedure TElcoMainForm.PageControlMainDrawTab(Control: TCustomTabControl;
TabIndex: Integer; const Rect: TRect; Active: Boolean);
begin
    PageControl_DrawVerticalTab1(Control, TabIndex, Rect, Active);
end;

procedure TElcoMainForm.PDF1Click(Sender: TObject);
begin
    TPDfSvc.RunPartyID(TLastPartySvc.PartyID);
end;

procedure TElcoMainForm.PDF2Click(Sender: TObject);
begin
    TPDfSvc.RunPartyID(TLastPartySvc.PartyID);

end;

procedure TElcoMainForm.RichEditlMessageBoxTextMouseDown(Sender: TObject;
Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
    if Button = TMouseButton.mbRight then
        RichEdit_PopupMenu(RichEditlMessageBoxText);
end;

procedure TElcoMainForm.TimerPerformingTimer(Sender: TObject);
begin
    with LabelStatusTop.Font do
        if Color = clRed then
            Color := clblue
        else
            Color := clRed;
end;

procedure TElcoMainForm.ToolButton2Click(Sender: TObject);
begin
    TRunnerSvc.StopHardware;
end;

procedure TElcoMainForm.ToolButton3Click(Sender: TObject);
begin
    PanelMessageBox.Hide;
end;

procedure TElcoMainForm.ToolButtonStopClick(Sender: TObject);
begin
    TRunnerSvc.SkipDelay;
end;

function TElcoMainForm.ExceptionDialog(e: Exception): Boolean;
begin
    Result := MessageBox(Handle, PChar(e.ClassName + #10#10 + e.Message +
      #10#10), PChar(ExtractFileName(Application.ExeName)),
      MB_ABORTRETRYIGNORE or MB_ICONERROR) = IDABORT;
end;

procedure TElcoMainForm.AppException(Sender: TObject; e: Exception);
begin

    LogfileWriteException(e);

    if e is EHostApplicationPanic then
    begin
        Application.ShowException(e);
        Application.Terminate;
        exit;
    end;

    if ExceptionDialog(e) then
        Close;
end;

procedure TElcoMainForm.ShowBalloonTip(c: TWinControl; Icon: TIconKind;
const Title, Text: string);
begin
    CloseWindow(FhWndTip);
    FhWndTip := ComponentBaloonHintU.ShowBalloonTip(c, Icon, Title, Text);
end;

procedure TElcoMainForm.WMEnterSizeMove(var Msg: TMessage);
begin
    CloseWindow(FhWndTip);
    inherited;
end;

procedure TElcoMainForm.WMWindowPosChanged(var AMessage: TMessage);
begin
    CloseWindow(FhWndTip);
    inherited;
end;

procedure TElcoMainForm.WMActivateApp(var AMessage: TMessage);
begin
    CloseWindow(FhWndTip);
    inherited;
end;

procedure TElcoMainForm.HandleCopydata(var Message: TMessage);
begin
    notify_services.HandleCopydata(Message);
end;

procedure TElcoMainForm.I201Click(Sender: TObject);
var
    s: string;
    v: double;
label l;
begin
    s := '1';
l:
    if not InputQuery('Пересчёт Iч -20"С', 'Укажите коэффициент пересчёта', s)
    then
        exit;
    s := s.Trim;
    if not try_str_to_float(s, v) then
        goto l;
    FormLastParty.SetParty(TLastPartySvc.CalculateSensMinus20(v));
end;

procedure TElcoMainForm.N11Click(Sender: TObject);
begin
    ShowFormCenterScreen(FormSelectTemperaturesDialog);
end;

procedure TElcoMainForm.N12Click(Sender: TObject);
begin
    TRunnerSvc.RunWritePartyFirmware;

end;

procedure TElcoMainForm.N15Click(Sender: TObject);
begin
    FormEditAppConfig.Position := poScreenCenter;
    FormEditAppConfig.ShowModal;
    FormLastParty.reload_data;
end;

procedure TElcoMainForm.N18Click(Sender: TObject);
begin
    ShowFormCenterScreen(FormNewPartyDialog);
end;

procedure TElcoMainForm.N201Click(Sender: TObject);
begin
    FormLastParty.SetParty(TLastPartySvc.CalculateFonMinus20);
end;

procedure TElcoMainForm.N202Click(Sender: TObject);
var
    s: string;
    v: double;
label l;
begin
    s := '1';
l:
    if not InputQuery('Пересчёт Iч -20"С', 'Укажите коэффициент пересчёта', s)
    then
        exit;
    s := s.Trim;
    if not try_str_to_float(s, v) then
        goto l;
    FormLastParty.SetParty(TLastPartySvc.CalculateSensMinus20(v));
end;

procedure TElcoMainForm.N203Click(Sender: TObject);
var
    s: string;
    v: double;
label l;
begin
    s := '1';
l:
    if not InputQuery('Пересчёт Iч 50"С', 'Укажите коэффициент пересчёта', s)
    then
        exit;
    s := s.Trim;
    if not try_str_to_float(s, v) then
        goto l;
    FormLastParty.SetParty(TLastPartySvc.CalculateSensPlus50(v));
end;

procedure TElcoMainForm.SetupDelay(i: TDelayInfo);
begin

    PanelDelay.Visible := true;

    LabelProgress.Caption := '';
    ProgressBar1.Position := i.ElapsedSeconds * 1000;
    ProgressBar1.Max := i.TotalSeconds * 1000;

    LabelDelayElepsedTime.Caption := FormatDateTime('HH:mm:ss',
      IncSecond(0, i.ElapsedSeconds));
    if ProgressBar1.Max <> 0 then
        LabelProgress.Caption :=
          inttostr(ceil(ProgressBar1.Position * 100 / ProgressBar1.Max)) + '%';
end;

procedure TElcoMainForm.OnReadCurrent(v: TReadCurrent);
var
    i: Integer;
begin

    with FormInterrogate do
        if FCheckBlock[v.Block] then
            for i := 0 to 7 do

                StringGrid1.Cells[1 + i, 1 + v.Block] :=
                  floattostr(v.Values[i]);

    LabelStatusBottom.Caption := Format('Блок %d: %s',
      [v.Block, FormatFloatArray(v.Values)]);

end;

procedure TElcoMainForm.RunReadAndSaveProductCurrentsMenuClick(Sender: TObject);
var
    n: Integer;
begin
    n := (Sender as TMenuItem).Tag;
    TRunnerSvc.RunReadAndSaveProductCurrents(WorkItems[n][1],
      GasTempItems[n][0], GasTempItems[n][1]);
end;

procedure TElcoMainForm.RunSwitchGasMenuClick(Sender: TObject);
begin
    TRunnerSvc.RunSwitchGas((Sender as TMenuItem).Tag);
end;

function FormatFloatArray(v: TArray<double>): string;
var
    s: TArray<string>;
    i: Integer;
begin
    SetLength(s, length(v));
    for i := 0 to length(v) - 1 do
        s[i] := Format('%d:%g', [i, v[i]]);
    Result := string.Join(' ', s);
end;

Function GetTextSize(const Text: String; Font: TFont): TSize;
var
    LBmp: TBitmap;
begin
    LBmp := TBitmap.Create;
    try
        LBmp.Canvas.Font := Font;
        Result := LBmp.Canvas.TextExtent(Text);
    finally
        LBmp.Free;
    end;
end;

procedure TElcoMainForm.OnWorkComplete(X: TWorkResult);
begin
    ToolBarStop.Visible := false;

    TimerPerforming.Enabled := false;

    if RichEditlMessageBoxText.Lines.Count > 14 then
        RichEditlMessageBoxText.ScrollBars := ssVertical
    else
        RichEditlMessageBoxText.ScrollBars := ssNone;

    LabelStatusTop.Caption := TimeToStr(now) + ': ' + X.WorkName;

    case X.Tag of
        0:
            begin
                ImageInfo.Show;
                ImageError.Hide;
                LabelStatusTop.Font.Color := clNavy;
                RichEditlMessageBoxText.Font.Color := clNavy;
                PanelMessageBoxTitle.Caption := X.WorkName + ': успешно';
                LabelStatusTop.Caption := LabelStatusTop.Caption + ': успешно';
            end;
        1:
            begin
                ImageInfo.Show;
                ImageError.Hide;
                LabelStatusTop.Font.Color := clMaroon;
                RichEditlMessageBoxText.Font.Color := clMaroon;
                PanelMessageBoxTitle.Caption := X.WorkName + ': прервано';
                LabelStatusTop.Caption := LabelStatusTop.Caption + ': прервано';
            end;
        2:
            begin
                ImageInfo.Hide;
                ImageError.Show;
                LabelStatusTop.Font.Color := clRed;
                RichEditlMessageBoxText.Font.Color := clRed;
                PanelMessageBoxTitle.Caption := X.WorkName + ': не выполнено';
                LabelStatusTop.Caption := LabelStatusTop.Caption +
                  ': не выполнено';
            end;
    else
        raise Exception.Create('unknown work result: ' + inttostr(X.Tag));
    end;

    RichEditlMessageBoxText.Text := stringreplace(X.Message, ': ',
      #13#10#9' - ', [rfReplaceAll, rfIgnoreCase]);

    LabelStatusBottom.Caption := '';
    PanelMessageBox.Show;
    PanelMessageBox.BringToFront;
    FormResize(self);
    FormLastParty.SetReadPlace(-1);
    FormLastParty.SetReadBlock(-1);
end;

procedure TElcoMainForm.OnWarning(content: string);
var
    s: string;
begin
    s := content + #10#13#10#13;
    s := s + '"Принять" - игнорировать ошибку и продолжить.'#10#13#10#13;
    s := s + '"Отмена" - прервать выполнение.';
    // FormModalMessage.Parent := self;
    FormModalMessage.PanelMessageBoxTitle.Caption := 'Предупреждение';
    FormModalMessage.RichEditlMessageBoxText.Text := content;
    FormModalMessage.ImageInfo.Hide;
    FormModalMessage.ImageError.Show;

    FormModalMessage.ShowModal;
    if FormModalMessage.ModalResult <> mrOk then
        TRunnerSvc.StopHardware;

    // s := content + #10#13#10#13;
    // s := s + '"Ok" - игнорировать ошибку и продолжить.'#10#13#10#13;
    // s := s + '"Cancel" - прервать выполнение.';
    // if MessageDlg(s, mtWarning, mbOKCancel, 0) <> IDOK then
    // TRunnerSvc.StopHardware;
end;

procedure TElcoMainForm.N20Click(Sender: TObject);
begin
    FormLastParty.SetParty(TLastPartySvc.SelectOnlyOkProductsProduction);
end;

end.
