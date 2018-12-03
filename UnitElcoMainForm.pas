unit UnitElcoMainForm;

interface

uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
    System.Classes, Vcl.Graphics,
    Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls,
    Vcl.ComCtrls, Vcl.ToolWin, System.ImageList, Vcl.ImgList, Vcl.Grids,
    Vcl.Menus, pipe;

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
        procedure FormCreate(Sender: TObject);
        procedure FormShow(Sender: TObject);
        procedure ToolButtonPartyClick(Sender: TObject);
        procedure PageControlMainChange(Sender: TObject);
        procedure PageControlMainDrawTab(Control: TCustomTabControl;
          TabIndex: Integer; const Rect: TRect; Active: Boolean);
    private
        { Private declarations }
        FInitialized: Boolean;
        procedure AppException(Sender: TObject; E: Exception);
    public
        { Public declarations }
    end;

var

    ElcoMainForm: TElcoMainForm;

implementation

{$R *.dfm}

uses stringgridutils, stringutils,
    superobject, UnitFormParties, UnitFormLastParty, vclutils,
    server_data_types, services, UnitFormParty, PropertiesFormUnit;

procedure TElcoMainForm.FormCreate(Sender: TObject);
begin
    FInitialized := false;
    Application.OnException := AppException;
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
        PropertiesForm.SetConfig(TSettingsSvc.Get);
    end;

end;

procedure TElcoMainForm.PageControlMainDrawTab(Control: TCustomTabControl;
  TabIndex: Integer; const Rect: TRect; Active: Boolean);
begin
    PageControl_DrawVerticalTab(Control, TabIndex, Rect, Active);
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

end.
