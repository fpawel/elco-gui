unit UnitFormParties;

interface

uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
    System.Classes, Vcl.Graphics,
    Vcl.Controls, Vcl.Forms, Vcl.Dialogs, VirtualTrees, System.ImageList,
    Vcl.ImgList, Vcl.ExtCtrls, server_data_types, Vcl.Menus;

type

    TNodeKind = (trdYear, trdMonth, trdDay, trdParty);

    PTreeData = ^RTreeData;

    RTreeData = record
        Value: int64;
        NodeKind: TNodeKind;
        Party: TParty;
    end;

    TFormParties = class(TForm)
        TreeView1: TVirtualStringTree;
        ImageList1: TImageList;
        Splitter1: TSplitter;
        PopupMenu1: TPopupMenu;
        MenuDeleteItem: TMenuItem;
        MenuCopyItem: TMenuItem;
        MenuPDF: TMenuItem;
        procedure FormCreate(Sender: TObject);
        procedure TreeView1Collapsed(Sender: TBaseVirtualTree;
          Node: PVirtualNode);
        procedure TreeView1GetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
          Column: TColumnIndex; TextType: TVSTTextType; var CellText: string);
        procedure TreeView1GetImageIndex(Sender: TBaseVirtualTree;
          Node: PVirtualNode; Kind: TVTImageKind; Column: TColumnIndex;
          var Ghosted: Boolean; var ImageIndex: TImageIndex);
        procedure TreeView1Expanding(Sender: TBaseVirtualTree;
          Node: PVirtualNode; var Allowed: Boolean);
        procedure FormShow(Sender: TObject);
        procedure TreeView1Change(Sender: TBaseVirtualTree; Node: PVirtualNode);
        procedure TreeView1KeyDown(Sender: TObject; var Key: Word;
          Shift: TShiftState);
        procedure MenuDeleteItemClick(Sender: TObject);
        procedure PopupMenu1Popup(Sender: TObject);
        procedure MenuCopyItemClick(Sender: TObject);
        procedure MenuPDFClick(Sender: TObject);
    private
        { Private declarations }
        FInitialized: Boolean;
        FNode: PVirtualNode;
        FHasYears: Boolean;

        function GetTreeData(Node: PVirtualNode): PTreeData;

        procedure CreateMonthsNodes(ParentNode: PVirtualNode);
        procedure CreateDaysNodes(ParentNode: PVirtualNode);
        procedure CreatePartiesNodes(ParentNode: PVirtualNode);

        function IsActivePartyNode(Node: PVirtualNode): Boolean;

        property TreeData[Node: PVirtualNode]: PTreeData read GetTreeData;

    public
        { Public declarations }
        procedure CreateYearsNodes;
        property HasYears: Boolean read FHasYears;

    end;

var
    FormParties: TFormParties;

implementation

{$R *.dfm}

uses stringutils, superobject,
    dateutils, services,
    UnitFormParty, UnitFormLastParty;

procedure TFormParties.FormCreate(Sender: TObject);
begin
    TreeView1.NodeDataSize := SizeOf(RTreeData);
    FInitialized := false;
    FHasYears := false;

end;

procedure TFormParties.FormShow(Sender: TObject);
begin
    if FInitialized then
        exit;
    FInitialized := true;

    CreateYearsNodes;
end;

procedure TFormParties.TreeView1Change(Sender: TBaseVirtualTree;
  Node: PVirtualNode);
begin
    FNode := Node;
    if not(Assigned(TreeData[Node]) AND (TreeData[Node].NodeKind = trdParty))
    then
        exit;
    FormParty.Party := services.TPartiesCatalogueSvc.Party
      (TreeData[Node].Value);
    Node := TreeView1.GetFirst;
    while Assigned(Node) do
    begin
        if TreeView1.IsVisible[Node] then
            TreeView1.RepaintNode(Node);
        Node := TreeView1.GetNext(Node);
    end;
end;

procedure TFormParties.TreeView1Collapsed(Sender: TBaseVirtualTree;
  Node: PVirtualNode);
var
    p: PTreeData;
begin
    p := Sender.GetNodeData(Node);
    // freeNodeData(VirtualStringTree1, Node.FirstChild);
    TreeView1.DeleteChildren(Node);
end;

procedure TFormParties.TreeView1Expanding(Sender: TBaseVirtualTree;
  Node: PVirtualNode; var Allowed: Boolean);
var
    p: PTreeData;
    NewNode: PVirtualNode;
    NewData: PTreeData;
begin
    p := Sender.GetNodeData(Node);
    case p.NodeKind of
        trdYear:
            CreateMonthsNodes(Node);
        trdMonth:
            CreateDaysNodes(Node);
        trdDay:
            CreatePartiesNodes(Node);
        trdParty:
            ;
    end;

end;

procedure TFormParties.TreeView1GetImageIndex(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Kind: TVTImageKind; Column: TColumnIndex;
  var Ghosted: Boolean; var ImageIndex: TImageIndex);
var
    p: PTreeData;
begin
    if (Column = 0) AND (Kind in [ikNormal, ikSelected]) then
    begin
        if IsActivePartyNode(Node) then
            ImageIndex := 4
        else
            ImageIndex := integer(TreeData[Node].NodeKind);

    end;
end;

procedure TFormParties.TreeView1GetText(Sender: TBaseVirtualTree;
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
                    trdParty:
                        CellText := p.Party.ProductTypeName;
                end;
            end;
        1:
            begin
                case p.NodeKind of
                    trdParty:
                        CellText := inttostr(p.Value);
                end;
            end;
        2:
            begin
                case p.NodeKind of
                    trdParty:
                        if p.Party.Note.Valid then
                            CellText := p.Party.Note.Str;
                end;
            end;
    end;
end;

procedure TFormParties.TreeView1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
    s: string;
begin
    if Key <> VK_DELETE then
        exit;

    case TreeData[FNode].NodeKind of
        trdYear:
            s := format('��� %d', [TreeData[FNode].Value]);
        trdMonth:
            s := format('��� %d, ����� %s %s', [TreeData[FNode.Parent].Value,
              inttostr2(TreeData[FNode].Value),
              month_name(TreeData[FNode].Value)]);
        trdDay:
            s := format('��� %d, ����� %s %s, ���� %s',
              [TreeData[FNode.Parent.Parent].Value,
              inttostr2(TreeData[FNode.Parent].Value),
              month_name(TreeData[FNode.Parent].Value),
              inttostr2(TreeData[FNode].Value)]);
        trdParty:
            s := format('������ %d', [TreeData[FNode].Value]);
    end;

    if MessageBox(Handle, Pchar('����������� ������������� �������� ������: ' +
      s), '������ �������������', mb_IconQuestion or mb_YesNo) <> mrYes then
        exit;

    case TreeData[FNode].NodeKind of
        trdYear:
            TPartiesCatalogueSvc.DeleteYear(TreeData[FNode].Value);
        trdMonth:
            TPartiesCatalogueSvc.DeleteMonth(TreeData[FNode.Parent].Value,
              TreeData[FNode].Value);

        trdDay:
            TPartiesCatalogueSvc.DeleteDay(TreeData[FNode.Parent.Parent].Value,
              TreeData[FNode.Parent].Value, TreeData[FNode].Value);
        trdParty:
            TPartiesCatalogueSvc.DeletePartyID(TreeData[FNode].Value);
    end;

    CreateYearsNodes;

end;

procedure TFormParties.CreatePartiesNodes(ParentNode: PVirtualNode);
var
    Node: PVirtualNode;
    NodeData: PTreeData;
    Party: TParty;
begin

    for Party in TPartiesCatalogueSvc.Parties(TreeData[ParentNode.Parent.Parent]
      .Value, TreeData[ParentNode.Parent].Value, TreeData[ParentNode].Value) do
    begin
        Node := TreeView1.AddChild(ParentNode);
        NodeData := TreeData[Node];
        NodeData.Party := Party;
        NodeData.Value := NodeData.Party.PartyID;
        NodeData.NodeKind := trdParty;
    end;
end;

procedure TFormParties.CreateDaysNodes(ParentNode: PVirtualNode);
var
    Node: PVirtualNode;
    day: integer;
begin
    for day in TPartiesCatalogueSvc.Days(TreeData[ParentNode.Parent].Value,
      TreeData[ParentNode].Value) do
    begin
        Node := TreeView1.AddChild(ParentNode);
        TreeView1.HasChildren[Node] := true;
        TreeData[Node].Value := day;
        TreeData[Node].NodeKind := trdDay;
        if IsActivePartyNode(Node) then
        begin
            TreeView1.Expanded[Node] := true;
        end;
    end;
end;

procedure TFormParties.CreateMonthsNodes(ParentNode: PVirtualNode);
var
    Node: PVirtualNode;
    month: integer;
begin

    for month in TPartiesCatalogueSvc.Months(TreeData[ParentNode].Value) do
    begin
        Node := TreeView1.AddChild(ParentNode);
        TreeView1.HasChildren[Node] := true;
        TreeData[Node].Value := month;
        TreeData[Node].NodeKind := trdMonth;

        if IsActivePartyNode(Node) then
        begin
            TreeView1.Expanded[Node] := true;
        end;
    end;
end;

procedure TFormParties.CreateYearsNodes;
var
    Node: PVirtualNode;
    year: integer;
begin
    FHasYears := false;
    TreeView1.Clear;
    for year in TPartiesCatalogueSvc.Years do
    begin
        Node := TreeView1.AddChild(nil);
        TreeData[Node].Value := year;
        TreeData[Node].NodeKind := trdYear;
        TreeView1.HasChildren[Node] := true;
        if IsActivePartyNode(Node) then
        begin
            TreeView1.Expanded[Node] := true;
        end;
        FHasYears := true;
    end;
end;

function TFormParties.IsActivePartyNode(Node: PVirtualNode): Boolean;
var
    p: PTreeData;
    v: int64;
    dt: TDateTime;
begin
    p := TreeData[Node];
    v := p.Value;

//    if FormParty.Party.PartyID <> 0 then
//        FormParty.Party := TLastPartySvc.Party;

    dt := FormParty.Party.CreatedAt;
    case p.NodeKind of
        trdYear:
            if v = YearOf(dt) then
                exit(true);
        trdMonth:
            if (p.Value = MonthOf(dt)) AND
              (TreeData[Node.Parent].Value = YearOf(dt)) then
                exit(true);
        trdDay:
            if (p.Value = DayOf(dt)) AND
              (TreeData[Node.Parent].Value = MonthOf(dt)) AND
              (TreeData[Node.Parent.Parent].Value = YearOf(dt)) then
                exit(true);
        trdParty:
            exit(p.Value = FormParty.Party.PartyID)
    end;
    exit(false);
end;

procedure TFormParties.MenuCopyItemClick(Sender: TObject);
begin
    FormLastParty.SetParty(TPartiesCatalogueSvc.CopyParty(TreeData[FNode]
      .Party.PartyID));
end;

procedure TFormParties.MenuDeleteItemClick(Sender: TObject);
begin
    if not Assigned(TreeData[FNode]) then
        exit;

    case TreeData[FNode].NodeKind of
        trdYear:
            TPartiesCatalogueSvc.DeleteYear(TreeData[FNode].Value);
        trdMonth:
            TPartiesCatalogueSvc.DeleteMonth(TreeData[FNode.Parent].Value,
              TreeData[FNode].Value);

        trdDay:
            TPartiesCatalogueSvc.DeleteDay(TreeData[FNode.Parent.Parent].Value,
              TreeData[FNode.Parent].Value, TreeData[FNode].Value);
        trdParty:
            TPartiesCatalogueSvc.DeletePartyID(TreeData[FNode].Value);
    end;

end;

procedure TFormParties.MenuPDFClick(Sender: TObject);
begin
    TPdfSvc.Run(TreeData[FNode].Party.PartyID);
end;

procedure TFormParties.PopupMenu1Popup(Sender: TObject);
var
    s: string;
begin
    MenuCopyItem.Visible := TreeData[FNode].NodeKind = trdParty;
    MenuPDF.Visible := TreeData[FNode].NodeKind = trdParty;
    case TreeData[FNode].NodeKind of
        trdParty:
            begin
                FormParty.Party := services.TPartiesCatalogueSvc.Party
                  (TreeData[FNode].Value);
                s := format('%d %s %s', [TreeData[FNode].Value,
                  TreeData[FNode].Party.ProductTypeName,
                  FormatDatetime('YYYY MMMM dd',
                  TreeData[FNode].Party.CreatedAt)]);
                MenuDeleteItem.Caption := 'Удалить партию : ' + s;
                MenuCopyItem.Caption := 'Копировать : ' + s;
                MenuPDF.Caption := 'Отчёт : ' + s;
            end;

        trdYear:
            MenuDeleteItem.Caption := format('Удалить данные за год %d',
              [TreeData[FNode].Value]);

        trdMonth:

            MenuDeleteItem.Caption := format('Удалить данные за месяц %d, %s %s',
              [TreeData[FNode.Parent].Value, inttostr2(TreeData[FNode].Value),
              month_name(TreeData[FNode].Value)]);

        trdDay:

            MenuDeleteItem.Caption :=
              format('Удалить данные за день %d, %s %s, %s',
              [TreeData[FNode.Parent.Parent].Value,
              inttostr2(TreeData[FNode.Parent].Value),
              month_name(TreeData[FNode.Parent].Value),
              inttostr2(TreeData[FNode].Value)]);

    end;

end;

function TFormParties.GetTreeData(Node: PVirtualNode): PTreeData;
begin
    result := PTreeData(TreeView1.GetNodeData(Node));
end;

end.
