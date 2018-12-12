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
        SplitterConsoleHoriz: TSplitter;
        PanelConsolePlaceholderBottom: TPanel;
        PanelConsole: TPanel;
        RichEdit1: TRichEdit;
        PanelConsoleHeader: TPanel;
        Panel6: TPanel;
        Panel7: TPanel;
        ToolBar4: TToolBar;
        ToolButtonMoveConsoleUp: TToolButton;
        ToolButtonConsoleHide: TToolButton;
        PopupMenu1: TPopupMenu;
        N4: TMenuItem;
        N7: TMenuItem;
        N11: TMenuItem;
        PageControlMain: TPageControl;
        TabSheetParty: TTabSheet;
        TabSheetParties: TTabSheet;
        ImageList4: TImageList;
        PanelStatusBottom: TPanel;
        TabSheetStend: TTabSheet;
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
        MemolMessageBoxText: TMemo;
        ToolBar3: TToolBar;
        ToolButton1: TToolButton;
        ToolButton4: TToolButton;
        PanelDialog: TPanel;
        Image2: TImage;
        PanelDialogStatus: TPanel;
        ToolBar5: TToolBar;
        ToolButton5: TToolButton;
        MemoPanelDialogText: TMemo;
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
    public
        { Public declarations }
        FIni: TIniFile;
        procedure ShowBalloonTip(c: TWinControl; Icon: TIconKind;
          const Title, Text: string);
    end;

var

    ElcoMainForm: TElcoMainForm;

implementation

{$R *.dfm}

uses stringgridutils, stringutils, JclDebug,
    superobject, UnitFormParties, UnitFormLastParty, vclutils,
    services, UnitFormParty, PropertiesFormUnit,
    notify_services, UnitFormEditText, UnitFormSelectStendPlacesDialog, ioutils,
    UnitFormSelectWorkDialog, dateutils, math;

procedure TElcoMainForm.FormClose(Sender: TObject; var Action: TCloseAction);
var
    wp: WINDOWPLACEMENT;
    fs: TFileStream;
    i: Integer;
begin

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

    with FormSelectWorkDialog.CheckListBox1 do
        for i := 0 to 4 do
            FIni.WriteBool('FormSelectWorkDialog', inttostr(i), Checked[i]);

end;

procedure TElcoMainForm.FormCreate(Sender: TObject);
begin
    FIni := TIniFile.Create(ExtractFileDir(paramstr(0)) + '\main.ini');
    FInitialized := false;
    Application.OnException := AppException;
    LabelStatusTop.Caption := '';
    SetOnHardwareError(
        procedure(s: string)
        begin

            if PanelMessageBox.Visible then
                MemolMessageBoxText.Text := MemolMessageBoxText.Text +
                  #10#13#10#13
            else
                MemolMessageBoxText.Text := '';

            PanelMessageBoxTitle.Caption := 'Ошибка оборудования';
            MemolMessageBoxText.Text := MemolMessageBoxText.Text + s;
            MemolMessageBoxText.Font.Color := clRed;
            PanelMessageBox.Visible := true;
            FormResize(self);
        end);
    SetOnReadCurrent(
        procedure(v: TReadCurrent)
        begin
            FormLastParty.SetCurrents(v.FPlace, v.FValues);
            v.Free;
        end);
    SetOnHardwareStarted(
        procedure(s: string)
        begin
            PanelMessageBox.Hide;
            ToolBarStop.Show;
            LabelStatusTop.Caption := s;

        end);
    SetOnHardwareStopped(
        procedure(s: string)
        begin
            PanelDialog.Hide;
            ToolBarStop.Visible := false;
            LabelStatusTop.Caption := s;

        end);

    SetOnStatus(
        procedure(s: string)
        begin
            PanelStatusBottom.Caption := s;
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
        procedure(x: TDelayInfo)
        begin
            SetupDelay(x);
            x.Free;
        end);

end;

procedure TElcoMainForm.FormResize(Sender: TObject);
begin
    if PanelMessageBox.Visible then
    begin
        PanelMessageBox.Left := ClientWidth div 2 - PanelMessageBox.Width div 2;
        PanelMessageBox.Top := ClientHeight div 2 -
          PanelMessageBox.Height div 2;
    end;

    if PanelDialog.Visible then
    begin
        PanelDialog.Left := ClientWidth div 2 - PanelDialog.Width div 2;
        PanelDialog.Top := ClientHeight div 2 - PanelDialog.Height div 2;
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

    with FormSelectWorkDialog.CheckListBox1 do
        for i := 0 to 4 do
            Checked[i] := FIni.ReadBool('FormSelectWorkDialog',
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

end;

procedure TElcoMainForm.PageControlMainChange(Sender: TObject);
var
    PageControl: TPageControl;
begin
    PageControl := Sender as TPageControl;
    PageControl.Repaint;
    if PageControl.ActivePage = TabSheetParties then
    begin
        if Assigned(FormParty.Party) then
            FormParty.Party := TPartiesCatalogue.Party
              (FormParty.Party.FPartyID);

    end
    else if PageControl.ActivePage = TabSheetParty then
    begin
        FormLastParty.reload_data;
        FormLastParty.update_view;
    end;

end;

procedure TElcoMainForm.PageControlMainDrawTab(Control: TCustomTabControl;
TabIndex: Integer; const Rect: TRect; Active: Boolean);
begin
    PageControl_DrawVerticalTab(Control, TabIndex, Rect, Active);
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

procedure TElcoMainForm.ToolButton1Click(Sender: TObject);
begin
    FormEditText.Show;
    ShowWindow(FormEditText.Handle, SW_RESTORE);

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
            PropertiesForm.SetConfig(TSettingsSvc.Sections);
            PropertiesForm.Left := x - 5 - PropertiesForm.Width;
            PropertiesForm.Top := Y + 5;
            PropertiesForm.Show;
            ShowWindow(PropertiesForm.Handle, SW_RESTORE);
        end;
end;

procedure TElcoMainForm.ToolButtonPartyClick(Sender: TObject);
begin
    with ToolButtonMainMenu do
        with ClientToScreen(Point(0, Height)) do
            PopupMenu1.Popup(x, Y);
end;

procedure TElcoMainForm.ToolButtonStopClick(Sender: TObject);
begin
    TRunnerSvc.SkipDelay;
end;

procedure TElcoMainForm.AppException(Sender: TObject; E: Exception);
    var
   stackList: TJclStackInfoList; //JclDebug.pas
   sl: TStringList;
   stacktrace:string;
begin


    stackList := JclCreateStackList(False, 0, Caller(0, False));
    sl := TStringList.Create;
    stackList.AddToStrings(sl, True, false, true, false);
    stacktrace := sl.Text;
    sl.Free;
    stacklist.Free;

    OutputDebugStringW(PWideChar(E.Message + #10#13 + stacktrace));
    //    Application.MessageBox(PWideChar(E.Message + #10#13#10#13 + stacktrace), 'Ошибка', MB_ICONERROR or MB_OK  );
    Application.ShowException(E);
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
            FormSelectStendPlacesDialog.Left := x + 5;
            FormSelectStendPlacesDialog.Top := Y + 5;
            FormSelectStendPlacesDialog.Show;
        end;
end;

procedure TElcoMainForm.N4Click(Sender: TObject);
begin
    with ToolButtonMainMenu do
        with ClientToScreen(Point(0, Height)) do
        begin
            ToolButtonMainMenu.PopupMenu.CloseMenu;
            FormSelectWorkDialog.Left := x + 5;
            FormSelectWorkDialog.Top := Y + 5;
            FormSelectWorkDialog.Show;
        end;
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

end.
