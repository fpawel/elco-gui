unit UnitFormKtx500;

interface

uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
    System.Classes, Vcl.Graphics, server_data_types,
    Vcl.Controls, Vcl.Forms, Vcl.Dialogs, VclTee.TeeGDIPlus, VclTee.TeEngine,
    VclTee.Series, Vcl.ExtCtrls, VclTee.TeeProcs, VclTee.Chart;

type
    TFormKtx500 = class(TForm)
        Chart1: TChart;
        SeriesCurrentTemperature: TFastLineSeries;
        SeriesDestinationTemperature: TFastLineSeries;
        SeriesOnOff: TFastLineSeries;
        SeriesCoolOnOff: TFastLineSeries;
    private
        { Private declarations }


    public
        { Public declarations }
        procedure AddEntry(X: TKtx500Info);
    end;

var
    FormKtx500: TFormKtx500;

implementation

{$R *.dfm}



procedure TFormKtx500.AddEntry(X: TKtx500Info);
var
    b: double;
    strOn, strCool: string;
begin
    SeriesDestinationTemperature.AddXY(now, X.Destination);
    SeriesCurrentTemperature.AddXY(now, X.Temperature);
    if X.TemperatureOn = true then
    begin
        b := 1;
        strOn := 'вкл.'
    end
    else
    begin
        b := 0;
        strOn := 'выкл.'
    end;
    SeriesOnOff.AddXY(now, b);
    if X.CoolOn = true then
    begin
        b := 1;
        strCool := ' компрессор'
    end
    else
    begin
        b := 0;
        strCool := ''
    end;

    SeriesCoolOnOff.AddXY(now, b);
end;


end.
