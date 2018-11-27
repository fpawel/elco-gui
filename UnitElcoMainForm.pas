unit UnitElcoMainForm;

interface

uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
    System.Classes, Vcl.Graphics,
    Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls,
    Vcl.ComCtrls, Vcl.ToolWin, System.ImageList, Vcl.ImgList, Vcl.Grids,
    Vcl.Menus;

type
    TElcoMainForm = class(TForm)
        Panel1: TPanel;
        Panel14: TPanel;
        Panel4: TPanel;
        Panel8: TPanel;
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
        N1: TMenuItem;
        N6: TMenuItem;
        N7: TMenuItem;
        N10: TMenuItem;
        N11: TMenuItem;
        N2: TMenuItem;
        PageControlMain: TPageControl;
        TabSheetParty: TTabSheet;
        TabSheetParties: TTabSheet;
        ImageList4: TImageList;
        Panel2: TPanel;
        ToolBarParty: TToolBar;
        ToolButtonParty: TToolButton;
        PanelStendMessage: TPanel;
        TabSheetStend: TTabSheet;
        TabSheetSettings: TTabSheet;
        ToolBarStop: TToolBar;
        ToolButton2: TToolButton;
        procedure FormCreate(Sender: TObject);
        procedure FormShow(Sender: TObject);
        procedure ToolButtonPartyClick(Sender: TObject);
        procedure PageControlMainChange(Sender: TObject);
        procedure PageControlMainDrawTab(Control: TCustomTabControl;
          TabIndex: Integer; const Rect: TRect; Active: Boolean);
    private
        { Private declarations }
        FInitialized: Boolean;
    public
        { Public declarations }
    end;

var

    ElcoMainForm: TElcoMainForm;

implementation

{$R *.dfm}

uses UnitDataModule1, stringgridutils, stringutils,
    superobject, UnitFormParties, UnitFormLastParty, vclutils,
    server_data_types, services, UnitFormParty;

procedure TElcoMainForm.FormCreate(Sender: TObject);
begin
    FInitialized := false;
end;

procedure TElcoMainForm.FormShow(Sender: TObject);
var ww:Word;
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

end;

procedure TElcoMainForm.PageControlMainChange(Sender: TObject);
var
    PageControl: TPageControl;
begin
    PageControl := Sender as TPageControl;
    PageControl.Repaint;
    if PageControl.ActivePage = TabSheetParties then
    begin
        if Assigned( FormParty.Party )  then
            FormParty.Party := TPartiesCatalogue.Party(FormParty.Party.FPartyID);

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

procedure TElcoMainForm.ToolButtonPartyClick(Sender: TObject);
begin
    with ToolButtonParty do
        with ClientToScreen(Point(0, Height)) do
            PopupMenu1.Popup(x, Y);
end;

end.
