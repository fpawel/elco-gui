unit UnitFormProduct;

interface

uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
    System.Classes, Vcl.Graphics,
    Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls,
    Vcl.ToolWin,
    server_data_types, server_data_types_helpers, System.ImageList, Vcl.ImgList,
    Vcl.ExtCtrls, UnitFormFirmwareBytes;

type
    TFormProduct = class(TForm)
        Panel3: TPanel;
        ImageList4: TImageList;
        ToolBar6: TToolBar;
        ToolButtonStop: TToolButton;
        Label1: TLabel;
        PageControl1: TPageControl;
        TabSheet1: TTabSheet;
        TabSheet2: TTabSheet;
        procedure ToolButtonStopClick(Sender: TObject);
        procedure FormShow(Sender: TObject);
    procedure PageControl1Change(Sender: TObject);
    private
        { Private declarations }
        FProduct:TProductInfo;
        procedure setupProduct;
    public
        { Public declarations }
        procedure SetProduct(AProduct: TProductInfo);
    end;

var
    FormProduct: TFormProduct;

implementation

{$R *.dfm}

uses UnitFormFirmware, UnitFormProductCurrents, UnitFormFirmwareChart;

procedure TFormProduct.FormShow(Sender: TObject);
begin
    with FormFirmware do
    begin
        Font.Assign(self.Font);
        Parent := TabSheet1;
        BorderStyle := bsNone;
        Align := alTop;
        Show;
    end;
    with FormFirmwareChart do
    begin
        Font.Assign(self.Font);
        Parent := TabSheet1;
        BorderStyle := bsNone;
        Align := alClient;
        Show;
    end;

    with FormProductCurrents do
    begin
        Font.Assign(self.Font);
        Parent := TabSheet2;
        BorderStyle := bsNone;
        Align := alTop;
        Show;
    end;
end;

procedure TFormProduct.PageControl1Change(Sender: TObject);
begin
    if PageControl1.ActivePage = TabSheet2 then
        FormProductCurrents.Load(FProduct.ProductID);

end;

procedure TFormProduct.SetProduct(AProduct: TProductInfo);
begin
    FProduct := AProduct;
    setupProduct;

end;

procedure TFormProduct.ToolButtonStopClick(Sender: TObject);
begin
    Hide;
end;

procedure TFormProduct.setupProduct;
begin
    Label1.Caption := Format('Ё’я %d место %d.%d', [FProduct.ProductID,

      FProduct.Place div 8 + 1, FProduct.Place mod 8 + 1

      ]);
    FormFirmware.SetProduct( FProduct );
    FormProductCurrents.Load(FProduct.ProductID);
end;


end.
