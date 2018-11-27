unit UnitFormParties;

interface

uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
    System.Classes, Vcl.Graphics,
    Vcl.Controls, Vcl.Forms, Vcl.Dialogs, VirtualTrees, System.ImageList,
    Vcl.ImgList, Vcl.ExtCtrls, server_data_types;

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
    private
        { Private declarations }
        FInitialized: Boolean;

        function GetTreeData(Node: PVirtualNode): PTreeData;
        procedure CreateYearsNodes;
        procedure CreateMonthsNodes(ParentNode: PVirtualNode);
        procedure CreateDaysNodes(ParentNode: PVirtualNode);
        procedure CreatePartiesNodes(ParentNode: PVirtualNode);

        function IsActivePartyNode(Node: PVirtualNode): Boolean;

        property TreeData[Node: PVirtualNode]: PTreeData read GetTreeData;
    public
        { Public declarations }

    end;

var
    FormParties: TFormParties;




implementation

{$R *.dfm}

uses stringutils, superobject,
    dateutils,
    UnitFormParty, UnitServerApp;


procedure TFormParties.FormCreate(Sender: TObject);
begin
    TreeView1.NodeDataSize := SizeOf(RTreeData);
    FInitialized := false;

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
    if Assigned(TreeData[Node]) AND (TreeData[Node].NodeKind = trdParty) then
    begin
        FormParty.Party := ServerApp.Party(TreeData[Node].Value);
        Node := TreeView1.GetFirst;
        while Assigned(Node) do
        begin
            if TreeView1.IsVisible[Node] then
                TreeView1.RepaintNode(Node);
            Node := TreeView1.GetNext(Node);
        end;

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
                        CellText := p.Party.FProductTypeName;
                end;
            end;
        1:
            begin
                case p.NodeKind of
                    trdParty:
                        CellText := inttostr(p.Value);
                end;
            end;
    end;
end;

procedure TFormParties.CreatePartiesNodes(ParentNode: PVirtualNode);
var
    Node: PVirtualNode;
    NodeData: PTreeData;
    req, i: ISuperobject;
begin
    req := SO;
    req.i['Year'] := TreeData[ParentNode.Parent.Parent].Value;
    req.i['Month'] := TreeData[ParentNode.Parent].Value;
    req.i['Day'] := TreeData[ParentNode].Value;
    for i in ServerApp.GetJsonResult('PartiesCatalogue.Parties', req) do
    begin
        Node := TreeView1.AddChild(ParentNode);
        NodeData := TreeData[Node];
        NodeData.Party := TParty.FromJsonString(i.AsJson);
        NodeData.Value := NodeData.Party.FPartyID;
        NodeData.NodeKind := trdParty;
    end;
end;

procedure TFormParties.CreateDaysNodes(ParentNode: PVirtualNode);
var
    Node: PVirtualNode;
    req, i: ISuperobject;
begin
    req := SO;
    req.i['Year'] := TreeData[ParentNode.Parent].Value;
    req.i['Month'] := TreeData[ParentNode].Value;

    for i in ServerApp.GetJsonResult('PartiesCatalogue.Days', req) do
    begin
        Node := TreeView1.AddChild(ParentNode);
        TreeView1.HasChildren[Node] := true;
        TreeData[Node].Value := i.AsInteger;
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
    req, i: ISuperobject;
begin

    req := SO;
    req.i['Year'] := TreeData[ParentNode].Value;
    for i in ServerApp.GetJsonResult('PartiesCatalogue.Months', req) do
    begin
        Node := TreeView1.AddChild(ParentNode);
        TreeView1.HasChildren[Node] := true;
        TreeData[Node].Value := i.AsInteger;
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
    req, i: ISuperobject;
begin
    TreeView1.Clear;
    req := SO;
    for i in ServerApp.GetJsonResult('PartiesCatalogue.Years', req) do
    begin
        Node := TreeView1.AddChild(nil);
        TreeData[Node].Value := i.AsInteger;
        TreeData[Node].NodeKind := trdYear;
        TreeView1.HasChildren[Node] := true;
        if IsActivePartyNode(Node) then
        begin
            TreeView1.Expanded[Node] := true;
        end;
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
    dt := FormParty.Party.FCreatedAt;
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
            exit(p.Value = FormParty.Party.FPartyID)
    end;
    exit(false);
end;

function TFormParties.GetTreeData(Node: PVirtualNode): PTreeData;
begin
    result := PTreeData(TreeView1.GetNodeData(Node));
end;

end.
