unit UnitFormJournal;

interface

uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
    System.Classes, Vcl.Graphics,
    Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, VirtualTrees,
    server_data_types,
    System.ImageList, Vcl.ImgList, Vcl.Grids, Vcl.StdCtrls, Vcl.ComCtrls,
    Vcl.Imaging.pngimage, pipe, Vcl.ToolWin;

type
    TNodeKind = (trdYear, trdMonth, trdDay, trdWork);

    PTreeData = ^RTreeData;

    RTreeData = record
        NodeKind: TNodeKind;
        Value: int64;
        Work: TJournalWork;
    end;

    TFormJournal = class(TForm)
        TreeView1: TVirtualStringTree;
        Splitter1: TSplitter;
        ImageList1: TImageList;
        Panel1: TPanel;
        RichEdit1: TRichEdit;
        ImageList2: TImageList;
        procedure FormCreate(Sender: TObject);
        procedure TreeView1GetImageIndex(Sender: TBaseVirtualTree;
          Node: PVirtualNode; Kind: TVTImageKind; Column: TColumnIndex;
          var Ghosted: Boolean; var ImageIndex: TImageIndex);
        procedure TreeView1GetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
          Column: TColumnIndex; TextType: TVSTTextType; var CellText: string);
        procedure FormShow(Sender: TObject);
        procedure TreeView1Expanding(Sender: TBaseVirtualTree;
          Node: PVirtualNode; var Allowed: Boolean);
        procedure TreeView1Collapsed(Sender: TBaseVirtualTree;
          Node: PVirtualNode);
        procedure TreeView1PaintText(Sender: TBaseVirtualTree;
          const TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex;
          TextType: TVSTTextType);
        procedure TreeView1Change(Sender: TBaseVirtualTree; Node: PVirtualNode);
    private
        { Private declarations }
        FInitialized: Boolean;

        FEntries: TArray<TJournalEntry>;
        FIncludeWork: Boolean;
        FHasYears: Boolean;

        function GetTreeData(Node: PVirtualNode): PTreeData;

        procedure CreateYearsNodes;
        procedure CreateMonthsNodes(ParentNode: PVirtualNode);
        procedure CreateDaysNodes(ParentNode: PVirtualNode);
        procedure CreateWorksNodes(ParentNode: PVirtualNode);
        function IsErrorNode(Node: PVirtualNode): Boolean;

        procedure PrintEntry(rec: TJournalEntry; include_work: Boolean);
        procedure PrintEntries;

        property TreeData[Node: PVirtualNode]: PTreeData read GetTreeData;
        property ErrorNode[Node: PVirtualNode]: Boolean read IsErrorNode;
    public
        { Public declarations }
        procedure OnNewEntry(x: TJournalEntry);
        procedure EnsureNodes;
    end;

var
    FormJournal: TFormJournal;

function IsErrorLevel(level: string): Boolean;

implementation

uses notify_services, stringutils, services, dateutils,
    richeditutils, UnitElcoMainForm;

{$R *.dfm}

procedure TFormJournal.FormCreate(Sender: TObject);
begin
    TreeView1.NodeDataSize := SizeOf(RTreeData);
    FInitialized := false;
    // SetOnNewEntry(OnNewEntry);
end;

procedure TFormJournal.EnsureNodes;
begin
    if not FHasYears then
        CreateYearsNodes;
end;

procedure TFormJournal.OnNewEntry(x: TJournalEntry);
var
    work_node, day_node: Boolean;
    year, month, day: word;
    Work: TJournalWork;
    Node_year, node_month, node_day, node_work, Iter_node: PVirtualNode;
label
    repeat_search;
begin

    Node_year := nil;
    node_month := nil;
    node_day := nil;
    node_work := nil;
    DecodeDate(x.FCreatedAt, year, month, day);

repeat_search:
    Iter_node := TreeView1.GetFirst;
    while Assigned(Iter_node) do
    begin
        if (TreeData[Iter_node].NodeKind = trdYear) and
          (TreeData[Iter_node].Value = year) then
            Node_year := Iter_node;

        if (TreeData[Iter_node].NodeKind = trdMonth) and
          (TreeData[Iter_node].Value = month) and
          (TreeData[Iter_node.Parent].Value = year) then
            node_month := Iter_node;

        if (TreeData[Iter_node].NodeKind = trdDay) and
          (TreeData[Iter_node].Value = day) and
          (TreeData[Iter_node.Parent].Value = month) and
          (TreeData[Iter_node.Parent.Parent].Value = year) then
            node_day := Iter_node;

        if (TreeData[Iter_node].NodeKind = trdWork) then
        begin
            Work := TreeData[Iter_node].Work;
            if Work.FWorkID = x.FWorkID then
                node_work := Iter_node;
        end;

        Iter_node := TreeView1.GetNext(Iter_node);
    end;

    if not(Assigned(Node_year) and Assigned(node_month) and Assigned(node_day)
      and Assigned(node_work)) then
    begin
        CreateYearsNodes;
        goto repeat_search;
    end;
    //TreeView1.FocusedNode := node_work;
    //TreeView1.Selected[node_work] := true;
    TreeView1Change(TreeView1, node_work);
end;

procedure TFormJournal.TreeView1Change(Sender: TBaseVirtualTree;
  Node: PVirtualNode);
var
    p: PTreeData;
    rec: TJournalEntry;
begin

    RichEdit1.Hide;
    if not Assigned(Node) then
        exit;
    p := TreeData[Node];
    case p.NodeKind of
        trdWork:
            begin
                FEntries := TJournal.EntriesOfWorkID(p.Work.FWorkID);
                FIncludeWork := false;
                PrintEntries;
            end;
        trdDay:
            begin
                FEntries := TJournal.DayEntries
                  (TreeData[Node.Parent.Parent].Value,
                  TreeData[Node.Parent].Value, TreeData[Node].Value);
                FIncludeWork := true;
                PrintEntries;
            end;

    end;

end;

procedure TFormJournal.TreeView1Collapsed(Sender: TBaseVirtualTree;
  Node: PVirtualNode);
begin
    TreeView1.DeleteChildren(Node);
end;

procedure TFormJournal.TreeView1Expanding(Sender: TBaseVirtualTree;
  Node: PVirtualNode; var Allowed: Boolean);
begin
    case TreeData[Node].NodeKind of
        trdYear:
            CreateMonthsNodes(Node);
        trdMonth:
            CreateDaysNodes(Node);
        trdDay:
            CreateWorksNodes(Node);
    end;

end;

procedure TFormJournal.TreeView1GetImageIndex(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Kind: TVTImageKind; Column: TColumnIndex;
  var Ghosted: Boolean; var ImageIndex: TImageIndex);
begin
    if (Column = 0) AND (Kind in [ikNormal, ikSelected]) then
    begin
        ImageIndex := Integer(TreeData[Node].NodeKind);
        if ErrorNode[Node] then
            ImageIndex := 6;

    end;
end;

procedure TFormJournal.TreeView1GetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: string);
var
    p: PTreeData;
begin
    p := Sender.GetNodeData(Node);
    case Column of
        0:
            begin
                case p.NodeKind of
                    trdYear:
                        CellText := inttostr(p.Value);
                    trdMonth:
                        CellText := inttostr2(p.Value) + ' ' +
                          month_name(p.Value);
                    trdDay:
                        CellText := inttostr2(p.Value);
                    trdWork:
                        CellText := FormatDateTime('HH:nn:ss',
                          IncHour(p.Work.FCreatedAt, 3)) + ' ' + p.Work.FName;

                end;
            end;
    end;
end;

procedure TFormJournal.TreeView1PaintText(Sender: TBaseVirtualTree;
  const TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex;
  TextType: TVSTTextType);
begin
    if ErrorNode[Node] then
    begin
        if TreeView1.Selected[Node] AND (Node = TreeView1.FocusedNode) then
        begin
            // TargetCanvas.Font.Color := clYellow;
        end
        else
        begin
            // TargetCanvas.Font.Color := clRed;
        end;
    end;
end;

procedure TFormJournal.FormShow(Sender: TObject);
begin
    if not FInitialized then
    begin
        // CreateYearsNodes;
        FInitialized := true;
    end;
end;

function TFormJournal.GetTreeData(Node: PVirtualNode): PTreeData;
begin
    result := PTreeData(TreeView1.GetNodeData(Node));
end;

procedure TFormJournal.CreateYearsNodes;
var
    Node: PVirtualNode;
    year: Integer;
begin
    FHasYears := false;
    TreeView1.Clear;
    for year in TJournal.Years do
    begin
        Node := TreeView1.AddChild(nil);
        TreeData[Node].Value := year;
        TreeData[Node].NodeKind := trdYear;
        TreeView1.HasChildren[Node] := true;
        TreeView1.Expanded[Node] := year = YearOf(now);
        FHasYears := true;
    end;
end;

procedure TFormJournal.CreateMonthsNodes(ParentNode: PVirtualNode);
var
    Node: PVirtualNode;
    month: Integer;
begin

    for month in TJournal.Months(TreeData[ParentNode].Value) do
    begin
        Node := TreeView1.AddChild(ParentNode);

        TreeData[Node].Value := month;
        TreeData[Node].NodeKind := trdMonth;
        TreeView1.HasChildren[Node] := true;
        TreeView1.Expanded[Node] := (month = monthof(now)) and
          (TreeData[Node.Parent].Value = YearOf(now));
    end;
end;

procedure TFormJournal.CreateDaysNodes(ParentNode: PVirtualNode);
var
    Node: PVirtualNode;
    day: Integer;
    Expanded: Boolean;
begin
    for day in TJournal.Days(TreeData[ParentNode.Parent].Value,
      TreeData[ParentNode].Value) do
    begin
        Node := TreeView1.AddChild(ParentNode);
        TreeData[Node].Value := day;
        TreeData[Node].NodeKind := trdDay;

        TreeView1.HasChildren[Node] := true;
        Expanded := (TreeData[Node.Parent.Parent].Value = YearOf(now)) and
          (TreeData[Node.Parent].Value = monthof(now)) and (day = dayof(now));
        TreeView1.Expanded[Node] := Expanded;;

    end;
end;

procedure TFormJournal.CreateWorksNodes(ParentNode: PVirtualNode);
var
    Node: PVirtualNode;
    Work: TJournalWork;
    works: TArray<TJournalWork>;

begin
    works := TJournal.DayWorks(TreeData[ParentNode.Parent.Parent].Value,
      TreeData[ParentNode.Parent].Value, TreeData[ParentNode].Value);

    for Work in works do
    begin
        Node := TreeView1.AddChild(ParentNode);
        TreeData[Node].NodeKind := trdWork;
        TreeData[Node].Work := Work;
        TreeView1.Expanded[Node] := false;
        TreeView1.HasChildren[Node] := false;
    end;
end;

procedure TFormJournal.PrintEntry(rec: TJournalEntry; include_work: Boolean);
begin

    RichEdit1.SelAttributes.Color := clGreen;
    RichEdit1.SelText := TimeToStr(rec.FCreatedAt) + '  ';

    if include_work then
    begin
        RichEdit1.SelAttributes.Style := [fsBold];
        RichEdit1.SelAttributes.Color := clGray;
        RichEdit1.SelText := rec.FWorkName + ' ';
    end;

    RichEdit1.SelAttributes.Style := [];

    if IsErrorLevel(rec.FLevel) then
    begin
        RichEdit1.SelAttributes.Color := clRed;
        // RichEdit_setBackcolor(RichEdit1, cl3DLight);
    end
    else if (rec.FLevel = 'warn') or (rec.FLevel = 'warning') then
        RichEdit1.SelAttributes.Color := clMaroon
    else if rec.FLevel = 'info' then
        RichEdit1.SelAttributes.Color := clNavy
    else if rec.FLevel = 'debug' then
        RichEdit1.SelAttributes.Color := clGray
    else
        RichEdit1.SelAttributes.Color := clBlack;
    RichEdit1.SelText := rec.FMessage + #13;
end;

function TFormJournal.IsErrorNode(Node: PVirtualNode): Boolean;
var
    p: PTreeData;
begin
    p := TreeData[Node];
    result := (p.NodeKind = trdWork) AND (p.Work.FErrorOccurred);
end;

function IsErrorLevel(level: string): Boolean;
begin
    result := (level = 'error') or (level = 'fatal') or (level = 'panic');
end;

procedure TFormJournal.PrintEntries;
var
    rec: TJournalEntry;
begin
    RichEdit1.Hide;
    RichEdit1.Lines.Clear;
    for rec in FEntries do
        PrintEntry(rec, FIncludeWork);

    if ElcoMainForm.PageControlMain.ActivePage = ElcoMainForm.TabSheetJournal then
    begin
        RichEdit1.Show;
        SendMessage(RichEdit1.handle, WM_VSCROLL, SB_BOTTOM, 0);
    end;
end;

end.
