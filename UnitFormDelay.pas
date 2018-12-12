unit UnitFormDelay;

interface

uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
    System.Classes, Vcl.Graphics,
    Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.ComCtrls,
    Vcl.StdCtrls, System.ImageList, Vcl.ImgList, Vcl.ToolWin, server_data_types;

type

    TFormDelay = class(TForm)
        Panel1: TPanel;
        Timer1: TTimer;
        LabelCurrentTime: TLabel;
        LabelTotalTime: TLabel;
        LabelWhat: TLabel;
        LabelProgress: TLabel;
        Panel2: TPanel;
        Panel5: TPanel;
        ToolBar1: TToolBar;
        ToolButtonStop: TToolButton;
        ImageList4: TImageList;
        Panel3: TPanel;
        Panel4: TPanel;
        ProgressBar1: TProgressBar;
        procedure Timer1Timer(Sender: TObject);
        procedure ToolButton1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    private
        { Private declarations }
    public
        { Public declarations }
        procedure Setup(i: TDelayInfo);
    end;

var
    FormDelay: TFormDelay;

implementation

{$R *.dfm}

uses rest.json, System.DateUtils, math, services;

procedure TFormDelay.FormCreate(Sender: TObject);
var a:integer;
begin
    a := 0;
end;

procedure TFormDelay.Setup(i: TDelayInfo);
begin
    LabelCurrentTime.Caption := '00:00:00';
    LabelWhat.Caption := i.FWhat;
    LabelProgress.Caption := '';
    ProgressBar1.Position := 0;
    ProgressBar1.Max := i.FTimeSeconds * 1000;
    Timer1.Enabled := i.FRun;
    LabelTotalTime.Caption := FormatDateTime('HH:mm:ss',
      IncMilliSecond(0, i.FTimeSeconds));

    Visible := i.FRun;
end;

procedure TFormDelay.Timer1Timer(Sender: TObject);
var
    s: string;
    v: TDateTime;
begin
    s := LabelCurrentTime.Caption;
    if TryStrToTime(s, v) then
        LabelCurrentTime.Caption := FormatDateTime('HH:mm:ss', IncSecond(v));
    ProgressBar1.Position := ProgressBar1.Position + integer(Timer1.Interval);

    LabelProgress.Caption :=
      Inttostr(ceil(ProgressBar1.Position * 100 / ProgressBar1.Max)) + '%';

end;

procedure TFormDelay.ToolButton1Click(Sender: TObject);
begin
    TRunnerSvc.SkipDelay;
end;

end.
