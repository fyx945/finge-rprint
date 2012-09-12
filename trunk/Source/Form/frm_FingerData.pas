unit frm_FingerData;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, StrUtils,
  Dialogs, StdCtrls, RzCmboBx, ExtCtrls, RzPanel, RzRadGrp, DB, kbmMemTable,
  Grids, DBGrids, RzSplit, RzButton, siComp, RzRadChk, GridsEh, DBGridEh, Menus, RzEdit, Mask,
  RzDBEdit, DBGridEhGrouping;

type
  TfrmFingerData = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    cb_AreaCode: TRzComboBox;
    cb_StoreCode: TRzComboBox;
    RzSplitter1: TRzSplitter;
    mt_Staff: TkbmMemTable;
    ds_Staff: TDataSource;
    btn_UploadFM: TRzButton;
    btn_Download: TRzButton;
    RzToolbar1: TRzToolbar;
    RzSpacer1: TRzSpacer;
    RzSpacer2: TRzSpacer;
    RzSpacer3: TRzSpacer;
    RzSpacer4: TRzSpacer;
    siLang: TsiLang;
    RzButton3: TRzButton;
    dbg_Staff: TDBGridEh;
    mt_StaffSEL: TBooleanField;
    mt_StaffSTAFFID: TStringField;
    mt_StaffFPID: TStringField;
    mt_StaffResignDate: TDateField;
    mt_StaffSTAFF_NAME_C: TStringField;
    mt_StaffSTAFF_NAME_E: TStringField;
    mt_StaffSTAFF_NAME_S: TStringField;
    mt_StaffNICKNM_E: TStringField;
    mt_StafffpCount: TIntegerField;
    pm_Checked: TPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    cb_ShowResign: TRzCheckBox;
    mem_FingerLog: TRzMemo;
    RzGroupBox1: TRzGroupBox;
    Label3: TLabel;
    RzDBEdit1: TRzDBEdit;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure cb_AreaCodeChange(Sender: TObject);
    procedure cb_StoreCodeChange(Sender: TObject);
    procedure cb_ShowResignClick(Sender: TObject);
    procedure N1Click(Sender: TObject);
    procedure N3Click(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure btn_UploadFMClick(Sender: TObject);
    procedure btn_DownloadClick(Sender: TObject);
    procedure RzButton3Click(Sender: TObject);
  private

  protected
    //----------------------------------------//Effect: 显示地区信息
    //Author: JackyZhou at 2008-02-28         //Remark:
    procedure ShowAreaMas();
    procedure ShowStoreMas(AreaCode: String);
    procedure ShowStaffInfo(StoreCode: string);

    procedure ShowResignStaff(ShowResign: Boolean);

    //----------------------------------------//Effect: 选择记录
    //Author: JackyZhou at 2008-03-05         //Remark:
    procedure CheckedAllStaff(Check: Boolean);
    function UncheckedStaff: Integer;

    //----------------------------------------//Effect: 获得选择的员工
    //Author: JackyZhou at 2008-03-05         //Remark:
    function GetCheckedStaff(): TStringList;

  public
    //----------------------------------------//Effect: 上传\下载\删除数据
    //Author: JackyZhou at 2008-03-05         //Remark:
    function UploadFMData(FPIDList: TStringList): Integer;
    function DownloadFMData(FPIDList: TStringList): Integer;
    function DeleteFMData(FPIDList: TStringList): Integer;

     // Added by JackyZhou 2010-04-07   //更新显示语言
     function ChangeLanguage(): Boolean;
  end;

var
  frmFingerData: TfrmFingerData;

implementation

uses
  unt_Control, dm_Main, dm_Local_old, unt_Finger, unt_Staff;

{$R *.dfm}


//============================== protected ========================================//
procedure TfrmFingerData.ShowAreaMas;
begin
  cb_AreaCode.Items.Clear;
  cb_AreaCode.Items := Staff.LoadAreaMas(Control.Language);
end;

procedure TfrmFingerData.ShowResignStaff(ShowResign: Boolean);
begin
  if mt_Staff.Active then
  begin
    if ShowResign then
    begin
      mt_Staff.Filter := 'ResignDate IS NOT NULL';
    end
    else
    begin
      mt_Staff.Filter := 'ResignDate IS NULL';   
    end;
    mt_Staff.Filtered := True;
  end;

end;

procedure TfrmFingerData.ShowStoreMas(AreaCode: String);
begin
  cb_StoreCode.Items.Clear;
  cb_StoreCode.Items := Staff.LoadStoreMas(AreaCode, Control.Language);
end;

procedure TfrmFingerData.ShowStaffInfo(StoreCode: string);
begin
  if not(mt_Staff.Active) then
    mt_Staff.Open;
  mt_Staff.EmptyTable;
  mt_Staff.LoadFromDataSet( Staff.LoadStaffFingerCount(StoreCode), [mtcpoAppend] );
  ShowResignStaff( cb_ShowResign.Checked );
  with dbg_Staff do
  begin
    Columns[0].Checkboxes := True;
    Columns[0].Width := 25;
    Columns[1].Visible := False;
    Columns[2].Width := 50;
    Columns[3].Visible := False;
    Columns[4].Visible := False;
    Columns[5].Visible := False;
    Columns[6].Visible := False;
    case Control.Language of
      ENG : Columns[5].Visible := True;
      CHS : Columns[6].Visible := True;
      GB5 : Columns[4].Visible := True;
    else
      Columns[4].Visible := True;
    end;
    Columns[3].Width := 110;
    Columns[5].Width := 110;
    Columns[6].Width := 110;
    Columns[7].Width := 80;
    Columns[8].Width := 40;
    //---------SumList---------//
    FooterRowCount := 1;
    FooterColor := clYellow;
    SumList.Active := True;
    Columns[7].Footer.ValueType := fvtCount;
    Columns[8].Footer.ValueType := fvtSum; 
  end;
  CheckedAllStaff(False);
end;

procedure TfrmFingerData.CheckedAllStaff(Check: Boolean);
var
  curRow: Integer;
begin
  if mt_Staff.Active then
  with mt_Staff do
  begin
    DisableControls;
    curRow := dbg_Staff.Row;
    First;
    while not(Eof) do
    begin
      Edit;
      FieldByName('SEL').AsBoolean := Check;
      Post;
      Next;
    end;
    First;
    MoveBy(curRow -1);
    EnableControls;
  end;
end;

function TfrmFingerData.UncheckedStaff: Integer;
var
  checkRecord: Integer;
  curRow: Integer;
begin
  checkRecord := 0;
  if mt_Staff.Active then
  with mt_Staff do
  begin
    DisableControls;
    curRow := dbg_Staff.Row;
    First;
    while not(Eof) do
    begin
      Edit;
      FieldByName('SEL').AsBoolean := not(FieldByName('SEL').AsBoolean);
      if FieldByName('SEL').AsBoolean = True then
        checkRecord := checkRecord + 1;
      Post;
      Next;
    end;
    First;
    MoveBy(curRow -1);
    EnableControls;
  end;
  Result := checkRecord;
end;

function TfrmFingerData.GetCheckedStaff: TStringList;
var
  FPIDList: TStringList;
  FPID: string;
  curRow: Integer;
begin
  FPIDList := TStringList.Create;
  with mt_Staff do
  begin
    DisableControls;
    curRow := dbg_Staff.Row;
    First;
    while not(Eof) do
    begin
      if FieldByName('SEL').AsBoolean then
      begin
        FPID := FieldByName('FPID').AsString;
        if FPID <> '' then
          FPIDList.Add( FPID );
      end;
      Next;
    end;
    First;
    MoveBy(curRow -1);
    EnableControls;
  end;
  Result := FPIDList;
end;

//============================== public ======================================//
function TfrmFingerData.UploadFMData(FPIDList: TStringList): Integer;
var
  iLoop, opFM: Integer;
  msg, FPID: String;
begin
  opFM := 0;
  for iLoop := 0 to FPIDList.Count - 1 do
  begin
    FPID := FPIDList[iLoop];
    if Finger.GetFingerCount(FPID)>0 then
    begin
      Finger.DeleteFinger_Server(FPID);
      opFM := opFM + Finger.UploadFMData(FPID);
    end;
  end;

  if FPIDList.Count > 0 then
  begin
    msg := Format( siLang.GetText('UPLOAD_FINGER'), [FPIDList.Count, opFM]);
    cb_StoreCodeChange(cb_StoreCode);
  end
  else
  begin
    msg := siLang.GetText('NO_SELECT');
  end;
  mem_FingerLog.Lines.Add(msg);
end;

function TfrmFingerData.DownloadFMData(FPIDList: TStringList): Integer;
var
  iLoop, opFM: Integer;
  msg, FPID: String;
begin
  opFM := 0;
  for iLoop := 0 to FPIDList.Count - 1 do
  begin
    FPID := FPIDList[iLoop];
    //加入判断是否有指纹数据
    if Finger.GetFingerCount_Server(FPID)>0 then
    begin
      Finger.DeleteFinger_Local(FPID);
      opFM := opFM + Finger.DownloadFMData(FPID);
    end;
  end;

  if FPIDList.Count > 0 then
  begin
    msg := Format( siLang.GetText('DOWNLOAD_FINGER'), [FPIDList.Count, opFM]);
    cb_StoreCodeChange(cb_StoreCode);
  end
  else
  begin
    msg := siLang.GetText('NO_SELECT');
  end;
  mem_FingerLog.Lines.Add(msg);
end;

function TfrmFingerData.DeleteFMData(FPIDList: TStringList): Integer;
var
  iLoop, opFM: Integer;
  msg, FPID: String;
begin
  opFM := 0;
  for iLoop := 0 to FPIDList.Count - 1 do
  begin
    FPID := FPIDList[iLoop];
    opFM := opFM + Finger.DeleteFinger_Local(FPID);
  end;

  if FPIDList.Count > 0 then
  begin
    msg := Format( siLang.GetText('DELETE_FINGER'), [FPIDList.Count, opFM]);
    cb_StoreCodeChange(cb_StoreCode);
  end
  else
  begin
    msg := siLang.GetText('NO_SELECT');
  end;
  mem_FingerLog.Lines.Add(msg);
end;

//============================== Event =======================================//
procedure TfrmFingerData.FormCreate(Sender: TObject);
begin
//
end;

procedure TfrmFingerData.FormShow(Sender: TObject);
begin
  ShowAreaMas();
end;

procedure TfrmFingerData.N1Click(Sender: TObject);
begin
  CheckedAllStaff(True);
end;

procedure TfrmFingerData.N2Click(Sender: TObject);
begin
  UncheckedStaff();
end;

procedure TfrmFingerData.N3Click(Sender: TObject);
begin
  CheckedAllStaff(False);
end;

procedure TfrmFingerData.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TfrmFingerData.FormDestroy(Sender: TObject);
begin
  frmFingerData := nil
end;

procedure TfrmFingerData.cb_AreaCodeChange(Sender: TObject);
var
  AreaCode: String;
  iPos: Integer;
begin
  AreaCode := TRzComboBox(Sender).Text;
  iPos := Pos('-', AreaCode);
  AreaCode := LeftStr(AreaCode, iPos -1);
  ShowStoreMas(AreaCode);

  if mt_Staff.Active then
    mt_Staff.EmptyTable;
end;

procedure TfrmFingerData.cb_StoreCodeChange(Sender: TObject);
var
  StoreCode: String;
  iPos: Integer;
begin
  StoreCode := TRzComboBox(Sender).Text;
  iPos := Pos('-', StoreCode);
  StoreCode := LeftStr(StoreCode, iPos -1);
  ShowStaffInfo(StoreCode);
end;

procedure TfrmFingerData.cb_ShowResignClick(Sender: TObject);
begin
  ShowResignStaff( cb_ShowResign.Checked );
  CheckedAllStaff(False);
end;

procedure TfrmFingerData.btn_UploadFMClick(Sender: TObject);
begin
  UploadFMData( GetCheckedStaff() );
end;

procedure TfrmFingerData.btn_DownloadClick(Sender: TObject);
begin
  DownloadFMData( GetCheckedStaff() );
end;

procedure TfrmFingerData.RzButton3Click(Sender: TObject);
begin
  DeleteFMData ( GetCheckedStaff() );
end;

function TfrmFingerData.ChangeLanguage: Boolean;
begin
  ShowAreaMas();
  cb_StoreCode.Items.Clear;
  mt_Staff.EmptyTable;
end;

end.
