unit UnitElcoMainForm;

interface

uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
    System.Classes, Vcl.Graphics,
    Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls,
    Vcl.ComCtrls, Vcl.ToolWin, System.ImageList, Vcl.ImgList, Vcl.Grids,
    server_data_types, Vcl.Menus,  ComponentBaloonHintU,
    Vcl.Imaging.pngimage, inifiles;

type
    EHostApplicationPanic = class(Exception);

    TElcoMainForm = class(TForm)
        Panel1: TPanel;
        Panel14: TPanel;
        ImageList3: TImageList;
        PopupMenu1: TPopupMenu;
        N4: TMenuItem;
        PageControlMain: TPageControl;
        TabSheetParty: TTabSheet;
        TabSheetParties: TTabSheet;
        ImageList4: TImageList;
        ToolBarStop: TToolBar;
        ToolButton2: TToolButton;
        Panel3: TPanel;
        ToolBar1: TToolBar;
        ToolButtonRun: TToolButton;
        ImageList90: TImageList;
        ToolBar3: TToolBar;
        ToolButton1: TToolButton;
        ToolButton4: TToolButton;
        LabelStatusTop: TLabel;
        PanelDelay: TPanel;
        LabelDelayElepsedTime: TLabel;
        LabelProgress: TLabel;
        LabelWhat: TLabel;
        TimerDelay: TTimer;
        ToolBar6: TToolBar;
        ToolButtonStop: TToolButton;
        Panel2: TPanel;
        ProgressBar1: TProgressBar;
        N3: TMenuItem;
        N8: TMenuItem;
        TabSheetConsole: TTabSheet;
        TimerPerforming: TTimer;
        PanelPlaceholderMain: TPanel;
        ToolBar4: TToolBar;
        ToolButton5: TToolButton;
        PanelMessageBox: TPanel;
        ImageError: TImage;
        PanelMessageBoxTitle: TPanel;
        ToolBar2: TToolBar;
        ToolButton3: TToolButton;
        RichEditlMessageBoxText: TRichEdit;
        PanelWaitResponseMsg: TPanel;
        Image2: TImage;
        ImageInfo: TImage;
        TabSheetInterrogate: TTabSheet;
        PopupMenu2: TPopupMenu;
        MenuItem6: TMenuItem;
        MenuItem7: TMenuItem;
        ToolBar5: TToolBar;
        ToolButton9: TToolButton;
        ToolButton10: TToolButton;
        MenuNewParty: TMenuItem;
        N2: TMenuItem;
        N1: TMenuItem;
        N5: TMenuItem;
        N201: TMenuItem;
        N202: TMenuItem;
        N203: TMenuItem;
        GridPanelBottom: TGridPanel;
        TabSheetKtx500: TTabSheet;
        LabelStatusBottom: TLabel;
        LabelStatusKtx500: TLabel;
    N6: TMenuItem;
        procedure FormCreate(Sender: TObject);
        procedure FormShow(Sender: TObject);
        procedure ToolButtonPartyClick(Sender: TObject);
        procedure PageControlMainChange(Sender: TObject);
        procedure PageControlMainDrawTab(Control: TCustomTabControl;
          TabIndex: Integer; const Rect: TRect; Active: Boolean);
        procedure FormResize(Sender: TObject);
        procedure ToolButton3Click(Sender: TObject);
        procedure ToolButton2Click(Sender: TObject);
        procedure ToolButton1Click(Sender: TObject);
        procedure FormClose(Sender: TObject; var Action: TCloseAction);
        procedure ToolButton4Click(Sender: TObject);
        procedure N4Click(Sender: TObject);
        procedure ToolButtonStopClick(Sender: TObject);
        procedure TimerDelayTimer(Sender: TObject);
        procedure N8Click(Sender: TObject);
        procedure RichEditlMessageBoxTextMouseDown(Sender: TObject;
          Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
        procedure N2Click(Sender: TObject);
        procedure TimerPerformingTimer(Sender: TObject);
        procedure N3Click(Sender: TObject);
        procedure ToolButton5Click(Sender: TObject);
        procedure ToolButton6Click(Sender: TObject);
        procedure MenuItem8Click(Sender: TObject);
        procedure ToolButton10Click(Sender: TObject);
        procedure MenuItem6Click(Sender: TObject);
        procedure MenuNewPartyClick(Sender: TObject);
        procedure N201Click(Sender: TObject);
        procedure N202Click(Sender: TObject);
        procedure N203Click(Sender: TObject);
    procedure N6Click(Sender: TObject);
    private
        { Private declarations }
        FInitialized: Boolean;
        FhWndTip: THandle;
        FOnPipeBusyActiveControl: TWinControl;
        procedure AppException(Sender: TObject; E: Exception);

        procedure RunReadAndSaveProductCurrentsMenuClick(Sender: TObject);

        procedure SetupDelay(i: TDelayInfo);

        procedure HandleCopydata(var Message: TMessage); message WM_COPYDATA;
        procedure WMWindowPosChanged(var AMessage: TMessage);
          message WM_WINDOWPOSCHANGED;
        procedure WMEnterSizeMove(var Msg: TMessage); message WM_ENTERSIZEMOVE;

        procedure WMActivateApp(var AMessage: TMessage); message WM_ACTIVATEAPP;

        procedure OnReadCurrent(v: TReadCurrent);

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
    superobject, UnitFormParties, UnitFormLastParty, vclutils,
    services, UnitFormParty, UnitFormProperties,
    notify_services, UnitFormEditText, UnitFormSelectStendPlacesDialog, ioutils,
    dateutils, math, UnitFormSelectTemperaturesDialog, richeditutils, parproc,
    uitypes, types, UnitFormFirmware,
    UnitFormInterrogate, UnitFormConsole, UnitFormKtx500, HttpRpcClient;

const
    WorkItems: array [0 .. 11, 0 .. 1] of string = (('20"C ПГС1', 'i_f_plus20'),
      ('20"C ПГС3', 'i_s_plus20'), ('20"C ПГС1(2)', 'i13'),
      ('-20"C ПГС1', 'i_f_minus20'), ('-20"C ПГС3', 'i_s_minus20'),
      ('50"C ПГС1', 'i_f_plus50'), ('50"C ПГС3', 'i_s_plus50'), ('ПГС2', 'i24'),
      ('ПГС3', 'i35'), ('ПГС2', 'i26'), ('ПГС1', 'i17'),
      ('неизмеряемый', 'not_measured'));

procedure TElcoMainForm.FormCreate(Sender: TObject);
var
    i: Integer;
    menu: TMenuItem;
begin
    if GetParentProcessName = 'cmd.exe' then
        Writeln('we are cmd.exe');

    PanelMessageBox.Width := 700;
    PanelMessageBox.Height := 350;
    PanelWaitResponseMsg.Width := 500;
    PanelWaitResponseMsg.Height := 115;

    FIni := TIniFile.Create(ExtractFileDir(paramstr(0)) + '\main.ini');
    FInitialized := false;
    Application.OnException := AppException;
    LabelStatusTop.Caption := '';
    LabelStatusBottom.Caption := '';

    for i := 0 to length(WorkItems) - 1 do
    begin
        menu := TMenuItem.Create(self);
        PopupMenu1.Items.Add(menu);
        menu.Caption := WorkItems[i, 0];
        menu.Tag := i;
        menu.OnClick := RunReadAndSaveProductCurrentsMenuClick;
    end;

end;

procedure TElcoMainForm.FormShow(Sender: TObject);
var
    wp: WINDOWPLACEMENT;
    fs: TFileStream;
    FileName: string;
    i: Integer;
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

    with FormParties do
    begin
        Font.Assign(self.Font);
        Parent := TabSheetParties;
        BorderStyle := bsNone;
        Align := alClient;
        Show;
    end;

    with FormLastParty do
    begin
        Font.Assign(self.Font);
        Parent := TabSheetParty;
        BorderStyle := bsNone;
        Align := alClient;
        Show;
    end;

    with FormParty do
    begin
        Font.Assign(self.Font);
        Parent := FormParties;
        BorderStyle := bsNone;
        Align := alClient;
        Show;
    end;

    with FormConsole do
    begin
        Font.Assign(self.Font);
        Parent := TabSheetConsole;
        BorderStyle := bsNone;
        Align := alClient;
        //FFileName := ExtractFileDir(paramstr(0)) + '\elco.log';
        FFileName := '';
        Show;
    end;

    with FormFirmware do
    begin
        Font.Assign(self.Font);
        Parent := self;
        BorderStyle := bsNone;
        Align := alClient;
    end;

    with FormInterrogate do
    begin
        Font.Assign(self.Font);
        Parent := TabSheetInterrogate;
        BorderStyle := bsNone;
        Align := alClient;
        Show;
    end;

    with FormKtx500 do
    begin
        Font.Assign(self.Font);
        Parent := TabSheetKtx500;
        BorderStyle := bsNone;
        Align := alClient;
        Show;
    end;

    SetOnErrorOccurred(
        procedure(s: string)
        var
            sz: TSize;
        begin
            ImageInfo.Hide;
            ImageError.Show;

            if PanelMessageBox.Visible then
                RichEditlMessageBoxText.Text := RichEditlMessageBoxText.Text +
                  #10#13#10#13
            else
                RichEditlMessageBoxText.Text := '';

            PanelMessageBoxTitle.Caption := 'Произошла ошибка';
            RichEditlMessageBoxText.Text := RichEditlMessageBoxText.Text + s;
            RichEditlMessageBoxText.Font.Color := clRed;

            sz := GetTextSize(RichEditlMessageBoxText.Text,
              RichEditlMessageBoxText.Font);

            PanelMessageBox.Show;
            PanelMessageBox.BringToFront;
            FormResize(self);
        end);

    SetOnWorkComplete(
        procedure(s: string)
        begin
            ImageInfo.Show;
            ImageError.Hide;

            if PanelMessageBox.Visible then
                RichEditlMessageBoxText.Text := RichEditlMessageBoxText.Text +
                  #10#13#10#13
            else
                RichEditlMessageBoxText.Text := '';

            PanelMessageBoxTitle.Caption := 'Выполнение окончено';
            RichEditlMessageBoxText.Text := RichEditlMessageBoxText.Text + s;
            RichEditlMessageBoxText.Font.Color := clNavy;
            PanelMessageBox.Show;
            PanelMessageBox.BringToFront;
            FormResize(self);
        end);

    SetOnReadCurrent(OnReadCurrent);

    SetOnWorkStarted(
        procedure(s: string)
        begin
            PanelMessageBox.Hide;
            ToolBarStop.Show;
            LabelStatusTop.Caption := TimeToStr(now) + ' ' + s;
            TimerPerforming.Enabled := true;
            LabelStatusBottom.Caption := '';
        end);

    SetOnWorkStopped(
        procedure(s: string)
        begin
            ToolBarStop.Visible := false;
            LabelStatusTop.Caption := TimeToStr(now) + ' ' + s;
            TimerPerforming.Enabled := false;
            LabelStatusTop.Font.Color := clBlack;
            LabelStatusBottom.Caption := '';

        end);

    SetOnStatus(
        procedure(s: string)
        begin
            LabelStatusTop.Caption := TimeToStr(now) + ' ' + s;
        end);

    SetOnWarning(
        procedure(content: string)
        var
            s: string;
        begin
            s := content + #10#13#10#13;
            s := s + 'Нажмите OK чтобы игнорировать ошибку и продолжить технологический процесс.'#10#13#10#13;
            s := s + 'Нажмите ОТМЕНА чтобы прервать технологический процесс.';
            if MessageDlg(s, mtWarning, mbOKCancel, 0) <> IDOK then
                TRunnerSvc.StopHardware;
        end);
    SetOnDelay(
        procedure(X: TDelayInfo)
        begin
            SetupDelay(X);
        end);

    SetOnLastPartyChanged(
        procedure(party: TParty)
        begin
            FormLastParty.SetParty(party);
        end);

    SetOnStartServerApplication(
        procedure(n: string)
        begin
            FormLastParty.reload_data;
            FormParties.CreateYearsNodes;
            FormParty.party := FormLastParty.party;
            PanelMessageBox.Hide;
            PanelWaitResponseMsg.Hide;
        end);

    SetOnReadFirmware(FormFirmware.SetReadFirmwareInfo);
    SetOnPanic(
        procedure(pnicStr: String)
        begin
            NotifyServices_SetEnabled(false);
            Application.ShowException(EHostApplicationPanic.Create(pnicStr));
            Application.Terminate;

        end);

    TabSheetConsole.TabVisible := false;
    SetOnWriteConsole(
        procedure(s: String)
        begin
            FormConsole.NewLine(s);
            if not TabSheetConsole.TabVisible then
                TabSheetConsole.TabVisible := true;
            Application.ProcessMessages;
        end);

    SetOnKtx500Error(
        procedure(s: string)
        begin
            LabelStatusKtx500.Font.Color := clRed;
            LabelStatusKtx500.Caption := TimeToStr(now) + ' ' +s;
        end);;

    SetOnKtx500Info(
        procedure(X: TKtx500Info)
        var
            strOn, strCool: string;
        begin
            FormKtx500.AddEntry(X);
            LabelStatusKtx500.Font.Color := clRed;
            if X.On then
                strOn := 'вкл.'
            else
                strOn := 'выкл.';
            if X.CoolOn then
                strCool := ' компрессор'
            else
                strCool := '';
            LabelStatusKtx500.Font.Color := clNavy;
            LabelStatusKtx500.Caption :=

              Format('%s %s %s"C-->%s"C%s', [TimeToStr(now),
              strOn, floattostr(X.Temperature),
              floattostr(X.Destination), strCool

              ])

        end);

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

    with FormSelectStendPlacesDialog.CheckListBox1 do
        for i := 0 to 11 do
            FIni.WriteBool('FormSelectStendPlacesDialog', inttostr(i),
              Checked[i]);

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

    if PanelWaitResponseMsg.Visible then
    begin
        PanelWaitResponseMsg.Left := ClientWidth div 2 -
          PanelWaitResponseMsg.Width div 2;
        PanelWaitResponseMsg.Top := ClientHeight div 2 -
          PanelWaitResponseMsg.Height div 2;
    end;

end;

procedure TElcoMainForm.PageControlMainChange(Sender: TObject);
var
    PageControl: TPageControl;
begin
    FormFirmware.Hide;
    PageControl := Sender as TPageControl;
    PageControl.Repaint;
    PanelMessageBox.Hide;
    if PageControl.ActivePage = TabSheetParties then
    begin
        if FormParty.party.PartyID = 0 then
            FormParty.party := TPartiesCatalogueSvc.party(FormParty.party.PartyID)
        else
            FormParty.party := TLastPartySvc.party;

        if not FormParties.HasYears then
        begin
            FormParties.CreateYearsNodes;
            FormParty.party := TLastPartySvc.party;
            exit;
        end;
    end
    else if PageControl.ActivePage = TabSheetParty then
    begin
        FormLastParty.reload_data;
    end
    else if PageControl.ActivePage = TabSheetInterrogate then
    begin
        FormInterrogate.UpdateCheckBlocks;
    end;

end;

procedure TElcoMainForm.PageControlMainDrawTab(Control: TCustomTabControl;
TabIndex: Integer; const Rect: TRect; Active: Boolean);
begin
    PageControl_DrawVerticalTab(Control, TabIndex, Rect, Active);
end;

procedure TElcoMainForm.RichEditlMessageBoxTextMouseDown(Sender: TObject;
Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
    if Button = TMouseButton.mbRight then
        RichEdit_PopupMenu(RichEditlMessageBoxText);
end;

procedure TElcoMainForm.TimerDelayTimer(Sender: TObject);
var
    s: string;
    v: TDateTime;
begin
    s := LabelDelayElepsedTime.Caption;
    if TryStrToTime(s, v) then
        LabelDelayElepsedTime.Caption := FormatDateTime('HH:mm:ss',
          IncSecond(v));
    ProgressBar1.Position := ProgressBar1.Position +
      Integer(TimerDelay.Interval);

    LabelProgress.Caption :=
      inttostr(ceil(ProgressBar1.Position * 100 / ProgressBar1.Max)) + '%';

end;

procedure TElcoMainForm.TimerPerformingTimer(Sender: TObject);
var
    v: Integer;
begin
    with LabelStatusTop.Font do
        if Color = clRed then
            Color := clblue
        else
            Color := clRed;
end;

procedure TElcoMainForm.ToolButton10Click(Sender: TObject);
begin
    with ToolButton10 do
        with ClientToScreen(Point(0, Height)) do
            PopupMenu2.Popup(X, Y);
end;

procedure TElcoMainForm.ToolButton1Click(Sender: TObject);
begin
    FormEditText.Show;
end;

procedure TElcoMainForm.ToolButton2Click(Sender: TObject);
begin
    TRunnerSvc.StopHardware;
end;

procedure TElcoMainForm.ToolButton3Click(Sender: TObject);
begin
    PanelMessageBox.Hide;
end;

procedure TElcoMainForm.ToolButton4Click(Sender: TObject);
begin
    with ToolBar3 do
        with ClientToScreen(Point(0, Height)) do
        begin
            FormProperties.SetConfig(TSettingsSvc.Sections);
            FormProperties.Left := X - 5 - FormProperties.Width;
            FormProperties.Top := Y + 5;
            FormProperties.Show;
            // ShowWindow(FormProperties.Handle, SW_SHOW);
        end;
end;

procedure TElcoMainForm.ToolButton5Click(Sender: TObject);
begin
    FormFirmware.Hide;
end;

procedure TElcoMainForm.ToolButton6Click(Sender: TObject);
begin
    TPDfSvc.Run(TLastPartySvc.PartyID);
end;

procedure TElcoMainForm.ToolButtonPartyClick(Sender: TObject);
begin
    with ToolButtonRun do
        with ClientToScreen(Point(0, Height)) do
            PopupMenu1.Popup(X, Y);
end;

procedure TElcoMainForm.ToolButtonStopClick(Sender: TObject);
begin
    TRunnerSvc.SkipDelay;
end;

procedure TElcoMainForm.AppException(Sender: TObject; E: Exception);
var
    stackList: TJclStackInfoList; // JclDebug.pas
    sl: TStringList;
    stacktrace: string;

    FErrorLog: TextFile;
    ErrorLogFileName: string;
begin

    stackList := JclCreateStackList(false, 0, Caller(0, false));
    sl := TStringList.Create;
    stackList.AddToStrings(sl, true, false, true, false);
    stacktrace := sl.Text;
    sl.Free;
    stackList.Free;
    OutputDebugStringW(PWideChar(E.Message + #10#13 + stacktrace));

    ErrorLogFileName := ExtractFileDir(paramstr(0)) + '\elco.log';
    AssignFile(FErrorLog, ErrorLogFileName, CP_UTF8);
    if FileExists(ErrorLogFileName) then
        Append(FErrorLog)
    else
        Rewrite(FErrorLog);

    Writeln(FErrorLog, FormatDateTime('dd/MM/yy hh:nn:ss', now), ' ',
      'DELPHI_EXCEPTION', ' ', E.ClassName, ' ', stringreplace(Trim(E.Message),
      #13, ' ', [rfReplaceAll, rfIgnoreCase]));

    Writeln(FErrorLog, StringOfChar('-', 120));

    Writeln(FErrorLog, stringreplace(Trim(stacktrace), #13, ' ',
      [rfReplaceAll, rfIgnoreCase]));

    Writeln(FErrorLog, StringOfChar('-', 120));

    CloseFile(FErrorLog);

    if E is ERpcNoResponseException then
    begin
        // PanelMessageBoxTitle.Caption := E.ClassName;
        // RichEditlMessageBoxText.Text := E.Message;
        // RichEditlMessageBoxText.Font.Color := clRed;
        // PanelMessageBox.Visible := true;
        // FormResize(self);
        PanelWaitResponseMsg.Caption := 'Подключение...';
        PanelWaitResponseMsg.Visible := true;
        PanelWaitResponseMsg.BringToFront;
        FormResize(self);
        exit;
    end;

    if E is EHostApplicationPanic then
    begin
        Application.ShowException(E);
        Application.Terminate;
        exit;
    end;

    if MessageDlg(E.Message, mtError, [mbAbort, mbIgnore], 0) = mrAbort then
    begin
        Application.OnException := nil;
        Application.Terminate;
        exit;
    end;
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

procedure TElcoMainForm.MenuItem6Click(Sender: TObject);
begin
    TLastPartySvc.Export;
end;

procedure TElcoMainForm.MenuItem8Click(Sender: TObject);
begin
    FormEditText.Show;
end;

procedure TElcoMainForm.MenuNewPartyClick(Sender: TObject);
begin
    if MessageBox(Handle, 'Подтвердите необходимость создания новой партии.',
      'Запрос подтверждения', mb_IconQuestion or mb_YesNo) = mrYes then
        FormLastParty.SetParty(TPartiesCatalogueSvc.NewParty);
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

procedure TElcoMainForm.N2Click(Sender: TObject);
begin
    FormLastParty.SetParty(TLastPartySvc.Import);
    FormParties.CreateYearsNodes;

end;

procedure TElcoMainForm.N3Click(Sender: TObject);
begin
    TRunnerSvc.RunWritePartyFirmware;
end;

procedure TElcoMainForm.N4Click(Sender: TObject);
begin
    with ToolButtonRun do
        with ClientToScreen(Point(0, Height)) do
        begin
            ToolButtonRun.PopupMenu.CloseMenu;
            FormSelectTemperaturesDialog.Left := X + 5;
            FormSelectTemperaturesDialog.Top := Y + 5;
            FormSelectTemperaturesDialog.Show;
        end;
end;

procedure TElcoMainForm.N6Click(Sender: TObject);
begin
    FormLastParty.SetParty(TLastPartySvc.SelectOnlyOkProductsProduction);
end;

procedure TElcoMainForm.N8Click(Sender: TObject);
begin
    TRunnerSvc.RunMainError;
end;

procedure TElcoMainForm.SetupDelay(i: TDelayInfo);
begin

    LabelDelayElepsedTime.Caption := '00:00:00';
    LabelWhat.Caption := i.What;
    LabelProgress.Caption := '';
    ProgressBar1.Position := 0;
    ProgressBar1.Max := i.TimeSeconds * 1000;
    PanelDelay.Visible := i.Run;
    TimerDelay.Enabled := i.Run;
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
begin
    TRunnerSvc.RunReadAndSaveProductCurrents
      (WorkItems[(Sender as TMenuItem).Tag][1]);
end;

function FormatFloatArray(v: TArray<double>): string;
var
    s: TArray<string>;
    i: Integer;
begin
    SetLength(s, length(v));
    for i := 0 to length(v) - 1 do
        s[i] := Format('%d:%g', [i, v[i]]);
    result := string.Join(' ', s);
end;

Function GetTextSize(const Text: String; Font: TFont): TSize;
var
    LBmp: TBitmap;
begin
    LBmp := TBitmap.Create;
    try
        LBmp.Canvas.Font := Font;
        result := LBmp.Canvas.TextExtent(Text);
    finally
        LBmp.Free;
    end;
end;

end.
