unit UnitElcoMainForm;

interface

uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
    System.Classes, Vcl.Graphics,
    Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls,
    Vcl.ComCtrls, Vcl.ToolWin, System.ImageList, Vcl.ImgList, Vcl.Grids,
    Vcl.Menus, pipe, ComponentBaloonHintU, Vcl.Imaging.pngimage;

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
        PanelWorkTools: TPanel;
        TabSheetStend: TTabSheet;
        TabSheetSettings: TTabSheet;
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
        PanelStatus: TPanel;
        Panel4: TPanel;
    ToolBar3: TToolBar;
    ToolButton1: TToolButton;
    ToolButton4: TToolButton;
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
    private
        { Private declarations }
        FInitialized: Boolean;
        FhWndTip: THandle;
        procedure AppException(Sender: TObject; E: Exception);

        procedure HandleCopydata(var Message: TMessage); message WM_COPYDATA;
        procedure WMWindowPosChanged(var AMessage: TMessage);
          message WM_WINDOWPOSCHANGED;
        procedure WMEnterSizeMove(var Msg: TMessage); message WM_ENTERSIZEMOVE;

        procedure WMActivateApp(var AMessage: TMessage); message WM_ACTIVATEAPP;
    public
        { Public declarations }
        procedure ShowBalloonTip(c: TWinControl; Icon: TIconKind;
          const Title, Text: string);
    end;

var

    ElcoMainForm: TElcoMainForm;

implementation

{$R *.dfm}

uses stringgridutils, stringutils,
    superobject, UnitFormParties, UnitFormLastParty, vclutils,
    server_data_types, services, UnitFormParty, PropertiesFormUnit,
    notify_services, UnitFormEditText;

procedure TElcoMainForm.FormCreate(Sender: TObject);
begin
    FInitialized := false;
    Application.OnException := AppException;
    SetOnHardwareError(
        procedure(s: string)
        begin
            PanelMessageBoxTitle.Caption := 'Ошибка оборудования';
            MemolMessageBoxText.Text := s;
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
            ToolBarStop.Visible := true;
            PanelStatus.Caption := s;

        end);
    SetOnHardwareStopped(
        procedure(s: string)
        begin
            ToolBarStop.Visible := false;
            PanelStatus.Caption := s;

        end);

    SetOnStatus(
        procedure(s: string)
        begin
            PanelStatus.Caption := s;
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
end;

procedure TElcoMainForm.FormShow(Sender: TObject);
begin
    if FInitialized then
        exit;
    FInitialized := true;

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

    with PropertiesForm do
    begin
        Font.Assign(self.Font);
        Parent := TabSheetSettings;
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
    end
    else if PageControl.ActivePage = TabSheetSettings then
    begin
        PropertiesForm.SetConfig(TSettingsSvc.Sections);
    end;

end;

procedure TElcoMainForm.PageControlMainDrawTab(Control: TCustomTabControl;
TabIndex: Integer; const Rect: TRect; Active: Boolean);
begin
    PageControl_DrawVerticalTab(Control, TabIndex, Rect, Active);
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

procedure TElcoMainForm.ToolButtonPartyClick(Sender: TObject);
begin
    with ToolButtonMainMenu do
        with ClientToScreen(Point(0, Height)) do
            PopupMenu1.Popup(x, Y);
end;

procedure TElcoMainForm.AppException(Sender: TObject; E: Exception);
begin
    OutputDebugStringW(PWideChar(E.Message));
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
    TRunnerSvc.RunReadCurrent;
end;

end.
