unit UnitElcoMainForm;

interface

uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
    System.Classes, Vcl.Graphics,
    Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls,
    Vcl.ComCtrls, Vcl.ToolWin, System.ImageList, Vcl.ImgList, Vcl.Grids,
    server_data_types, Vcl.Menus, pipe, ComponentBaloonHintU,
    Vcl.Imaging.pngimage, inifiles;

type
    TElcoMainForm = class(TForm)
        Panel1: TPanel;
        Panel14: TPanel;
        ImageList3: TImageList;
        PopupMenu1: TPopupMenu;
        N4: TMenuItem;
        N7: TMenuItem;
        N11: TMenuItem;
        PageControlMain: TPageControl;
        TabSheetParty: TTabSheet;
        TabSheetParties: TTabSheet;
        ImageList4: TImageList;
        PanelStatusBottom: TPanel;
        ToolBarStop: TToolBar;
        ToolButton2: TToolButton;
        Panel3: TPanel;
        ToolBar1: TToolBar;
        ToolButtonMainMenu: TToolButton;
        N1: TMenuItem;
        N2: TMenuItem;
        PanelMessageBox: TPanel;
        PanelMessageBoxTitle: TPanel;
        ToolBar2: TToolBar;
        ToolButton3: TToolButton;
        Image1: TImage;
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
        N5: TMenuItem;
        N6: TMenuItem;
        N8: TMenuItem;
        RichEditlMessageBoxText: TRichEdit;
        PanelWaitPipe: TPanel;
        Image2: TImage;
        TimerShowPanelWaitPipe: TTimer;
        TabSheetComportConsole: TTabSheet;
    TabSheetJournal: TTabSheet;
    TimerPerforming: TTimer;
    ProgressBar2: TProgressBar;
    LabelStatusBottom: TLabel;
    PanelPlaceholderMain: TPanel;
    ToolBar4: TToolBar;
    ToolButton5: TToolButton;
        procedure FormCreate(Sender: TObject);
        procedure FormShow(Sender: TObject);
        procedure ToolButtonPartyClick(Sender: TObject);
        procedure PageControlMainChange(Sender: TObject);
        procedure PageControlMainDrawTab(Control: TCustomTabControl;
          TabIndex: Integer; const Rect: TRect; Active: Boolean);
        procedure FormResize(Sender: TObject);
        procedure N11Click(Sender: TObject);
        procedure ToolButton3Click(Sender: TObject);
        procedure ToolButton2Click(Sender: TObject);
        procedure ToolButton1Click(Sender: TObject);
        procedure FormClose(Sender: TObject; var Action: TCloseAction);
        procedure ToolButton4Click(Sender: TObject);
        procedure N4Click(Sender: TObject);
        procedure ToolButtonStopClick(Sender: TObject);
        procedure TimerDelayTimer(Sender: TObject);
        procedure N8Click(Sender: TObject);
        procedure N7Click(Sender: TObject);
        procedure RichEditlMessageBoxTextMouseDown(Sender: TObject;
          Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
        procedure N1Click(Sender: TObject);
        procedure N2Click(Sender: TObject);
        procedure TimerShowPanelWaitPipeTimer(Sender: TObject);
    procedure TimerPerformingTimer(Sender: TObject);
    procedure N3Click(Sender: TObject);
    procedure ToolButton5Click(Sender: TObject);
    private
        { Private declarations }
        FInitialized: Boolean;
        FhWndTip: THandle;
        procedure AppException(Sender: TObject; E: Exception);

        procedure SetupDelay(i: TDelayInfo);

        procedure HandleCopydata(var Message: TMessage); message WM_COPYDATA;
        procedure WMWindowPosChanged(var AMessage: TMessage);
          message WM_WINDOWPOSCHANGED;
        procedure WMEnterSizeMove(var Msg: TMessage); message WM_ENTERSIZEMOVE;

        procedure WMActivateApp(var AMessage: TMessage); message WM_ACTIVATEAPP;

        procedure OnPipeBusy(var Msg: TMessage);
          message WM_SERVER_APP_PIPE_BUSY;
    public
        { Public declarations }
        FIni: TIniFile;
        procedure ShowBalloonTip(c: TWinControl; Icon: TIconKind;
          const Title, Text: string);
    end;

var

    ElcoMainForm: TElcoMainForm;

function FormatFloatArray(v: TArray<double>): string;

implementation

{$R *.dfm}

uses stringgridutils, stringutils, JclDebug,
    superobject, UnitFormParties, UnitFormLastParty, vclutils,
    services, UnitFormParty, UnitFormProperties,
    notify_services, UnitFormEditText, UnitFormSelectStendPlacesDialog, ioutils,
    dateutils, math, UnitFormSelectTemperaturesDialog, richeditutils, parproc,
    UnitFormComportCon, UnitFormConsole, uitypes, types, UnitFormFirmware,
  UnitFormJournal;

procedure TElcoMainForm.FormCreate(Sender: TObject);
begin
    if GetParentProcessName = 'cmd.exe' then
        Writeln('we are cmd.exe');

    PanelMessageBox.Width := 700;
    PanelMessageBox.Height := 350;
    PanelWaitPipe.Width := 500;
    PanelWaitPipe.Height := 115;

    FIni := TIniFile.Create(ExtractFileDir(paramstr(0)) + '\main.ini');
    FInitialized := false;
    Application.OnException := AppException;
    LabelStatusTop.Caption := '';
    TabSheetComportConsole.TabVisible := false;
    LabelStatusBottom.Caption := '';

    SetOnHardwareError(
        procedure(s: string)
        begin

            if PanelMessageBox.Visible then
                RichEditlMessageBoxText.Text := RichEditlMessageBoxText.Text +
                  #10#13#10#13
            else
                RichEditlMessageBoxText.Text := '';

            PanelMessageBoxTitle.Caption := 'Ошибка оборудования';
            RichEditlMessageBoxText.Text := RichEditlMessageBoxText.Text + s;
            RichEditlMessageBoxText.Font.Color := clRed;
            PanelMessageBox.Show;
            PanelMessageBox.BringToFront;
            FormResize(self);
        end);

    SetOnReadCurrent(
        procedure(v: TReadCurrent)

        begin
            FormLastParty.SetCurrents(v.FBlock, v.FValues);
            LabelStatusBottom.Caption := Format('Блок %d: %s',
              [v.FBlock, FormatFloatArray(v.FValues)]);
            v.Free;
        end);

    SetOnHardwareStarted(
        procedure(s: string)
        begin
            PanelMessageBox.Hide;
            ToolBarStop.Show;
            LabelStatusTop.Caption := s;
            TimerPerforming.Enabled := true;
            LabelStatusBottom.Caption := '';
        end);

    SetOnHardwareStopped(
        procedure(s: string)
        begin
            ToolBarStop.Visible := false;
            LabelStatusTop.Caption := s;
            TimerPerforming.Enabled := false;
            LabelStatusTop.font.Color := clBlack;
            ProgressBar2.Visible := false;
            LabelStatusBottom.Caption := '';

        end);

    SetOnStatus(
        procedure(s: string)
        begin
            LabelStatusTop.Caption := s;
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
            X.Free;
        end);

    SetOnLastPartyChanged(
        procedure(party: TParty)
        begin
            FormLastParty.SetParty(party);
        end);

    SetOnStartServerApplication(procedure(n:string)
    begin
        FormLastParty.reload_data;
        FormParties.CreateYearsNodes;
        FormParty.party := FormLastParty.Party;
        PanelMessageBox.Hide;
    end);

    SetOnComportEntry(
        procedure(entry: TComportEntry)
        begin
            if not TabSheetComportConsole.TabVisible then
            begin
                TabSheetComportConsole.TabVisible := true;
                PageControlMain.Repaint;
            end;
            FormComportCon.OnComportEntry(entry);
        end);
    SetOnNewJournalEntry(FormJournal.OnNewEntry);
    SetOnReadFirmware(FormFirmware.SetReadFirmwareInfo);
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

    with FormComportCon do
    begin
        Font.Assign(self.Font);
        Parent := TabSheetComportConsole;
        BorderStyle := bsNone;
        Align := alClient;
        Show;
    end;

    with FormJournal do
    begin
        Font.Assign(self.Font);
        Parent := TabSheetJournal;
        BorderStyle := bsNone;
        Align := alClient;
        Show;
    end;

    with FormFirmware do
    begin
        Font.Assign(self.Font);
        Parent := Self;
        BorderStyle := bsNone;
        Align := alClient;
    end;
end;

procedure TElcoMainForm.FormClose(Sender: TObject; var Action: TCloseAction);
var
    wp: WINDOWPLACEMENT;
    fs: TFileStream;
    i: Integer;
begin

    notify_services.Cancel;

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

    if PanelWaitPipe.Visible then
    begin
        PanelWaitPipe.Left := ClientWidth div 2 - PanelWaitPipe.Width div 2;
        PanelWaitPipe.Top := ClientHeight div 2 - PanelWaitPipe.Height div 2;
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
        if Assigned(FormParty.party) then
            FormParty.party := TPartiesCatalogue.party(FormParty.party.FPartyID)
        else
            FormParty.party := TLastParty.party;

        if not FormParties.HasYears then
        begin
            FormParties.CreateYearsNodes;
            FormParty.party := TLastParty.party;
            exit;
        end;
    end
    else if PageControl.ActivePage = TabSheetParty then
    begin
        FormLastParty.reload_data;
    end else if PageControl.ActivePage = TabSheetJournal then
    begin
        FormJournal.EnsureNodes;
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
var v  : integer;
begin
    with LabelStatusTop.Font do
    if Color = clRed then
        Color := clblue else Color := clRed;
    if not ProgressBar2.Visible then
    begin
        ProgressBar2.Show;
        ProgressBar2.Top := 100500;
    end;
    v := ProgressBar2.Position + TimerPerforming.Interval;
    if v > ProgressBar2.Max then
        v := 0;
    ProgressBar2.Position := v;
end;

procedure TElcoMainForm.TimerShowPanelWaitPipeTimer(Sender: TObject);
begin
    PanelWaitPipe.Visible := true;
    TimerShowPanelWaitPipe.Enabled := false;
    PanelWaitPipe.BringToFront;
    FormResize(self);
end;

procedure TElcoMainForm.ToolButton1Click(Sender: TObject);
begin
    FormEditText.Show;
    //ShowWindow(FormEditText.Handle, SW_SHOW);

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
            //ShowWindow(FormProperties.Handle, SW_SHOW);
        end;
end;

procedure TElcoMainForm.ToolButton5Click(Sender: TObject);
begin
    FormFirmware.Hide;
end;

procedure TElcoMainForm.ToolButtonPartyClick(Sender: TObject);
begin
    with ToolButtonMainMenu do
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

    if E is pipe.EPipeNotFound then
    begin
        //PanelMessageBoxTitle.Caption := E.ClassName;
        //RichEditlMessageBoxText.Text := E.Message;
        //RichEditlMessageBoxText.Font.Color := clRed;
        //PanelMessageBox.Visible := true;
        //FormResize(self);

        PanelWaitPipe.Caption := 'Подключение...';
        PanelWaitPipe.Visible := true;
        PanelWaitPipe.BringToFront;
        FormResize(self);

        exit;
    end;

    stackList := JclCreateStackList(false, 0, Caller(0, false));
    sl := TStringList.Create;
    stackList.AddToStrings(sl, true, false, true, false);
    stacktrace := sl.Text;
    sl.Free;
    stackList.Free;
    OutputDebugStringW(PWideChar(E.Message + #10#13 + stacktrace));

    ErrorLogFileName := ExtractFileDir(paramstr(0)) + '\elcoui.errors.log';
    AssignFile(FErrorLog, ErrorLogFileName, CP_UTF8);
    if FileExists(ErrorLogFileName) then
        Append(FErrorLog)
    else
        Rewrite(FErrorLog);

    Writeln(FErrorLog, FormatDateTime('hh:nn:ss', now), ' ', E.ClassName, ' ',
      stringreplace(Trim(E.Message), #13, ' ', [rfReplaceAll, rfIgnoreCase]));

    Writeln(FErrorLog, StringOfChar('-', 120));

    Writeln(FErrorLog, stringreplace(Trim(stacktrace), #13, ' ',
      [rfReplaceAll, rfIgnoreCase]));

    Writeln(FErrorLog, StringOfChar('-', 120));

    CloseFile(FErrorLog);

    if MessageDlg(E.Message, mtError, [mbAbort, mbIgnore], 0) = mrAbort then
    begin
        Application.OnException := nil;
        Application.Terminate;
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

procedure TElcoMainForm.N11Click(Sender: TObject);
begin
    with ToolButtonMainMenu do
        with ClientToScreen(Point(0, Height)) do
        begin
            ToolButtonMainMenu.PopupMenu.CloseMenu;
            FormSelectStendPlacesDialog.Left := X + 5;
            FormSelectStendPlacesDialog.Top := Y + 5;
            FormSelectStendPlacesDialog.Show;
        end;
end;

procedure TElcoMainForm.N1Click(Sender: TObject);
begin
    TLastParty.Export;
end;

procedure TElcoMainForm.N2Click(Sender: TObject);
begin
    FormLastParty.SetParty(TPartiesCatalogue.Import);
    FormParties.CreateYearsNodes;

end;

procedure TElcoMainForm.N3Click(Sender: TObject);
begin
    TRunnerSvc.RunWritePartyFirmware;
end;

procedure TElcoMainForm.N4Click(Sender: TObject);
begin
    with ToolButtonMainMenu do
        with ClientToScreen(Point(0, Height)) do
        begin
            ToolButtonMainMenu.PopupMenu.CloseMenu;
            FormSelectTemperaturesDialog.Left := X + 5;
            FormSelectTemperaturesDialog.Top := Y + 5;
            FormSelectTemperaturesDialog.Show;
        end;
end;

procedure TElcoMainForm.N7Click(Sender: TObject);
begin
    if MessageBox(Handle, 'Подтвердите необходимость создания новой партии.',
      'Запрос подтверждения', mb_IconQuestion or mb_YesNo) = mrYes then
        FormLastParty.SetParty(TPartiesCatalogue.NewParty);
end;

procedure TElcoMainForm.N8Click(Sender: TObject);
begin
    TRunnerSvc.RunMainError;
end;

procedure TElcoMainForm.SetupDelay(i: TDelayInfo);
begin

    LabelDelayElepsedTime.Caption := '00:00:00';
    LabelWhat.Caption := i.FWhat;
    LabelProgress.Caption := '';
    ProgressBar1.Position := 0;
    ProgressBar1.Max := i.FTimeSeconds * 1000;
    PanelDelay.Visible := i.FRun;
    TimerDelay.Enabled := i.FRun;
end;

procedure TElcoMainForm.OnPipeBusy(var Msg: TMessage);
var
    pipe_busy: Boolean;
begin
    pipe_busy := Msg.WParam <> 0;
    Panel3.Enabled := not pipe_busy;
    PageControlMain.Enabled := not pipe_busy;
    // PanelWaitPipe.Visible :=  pipe_busy;
    if pipe_busy then
    begin
        PanelWaitPipe.Caption := 'Выполняется запрос...';
        TimerShowPanelWaitPipe.Enabled := true;

    end
    else
    begin
        PanelWaitPipe.Visible := false;
        TimerShowPanelWaitPipe.Enabled := false;
    end;
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

end.
