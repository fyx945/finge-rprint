unit frm_FingerEnroll;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, RzPanel, StdCtrls, RzCmboBx, ExtCtrls, RzButton,
  DB, StrUtils, kbmMemTable, RzSplit, RzEdit, OleCtrls, ZKFPEngXControl_TLB,
  Mask, RzDBEdit, GridsEh, DBGridEh, siComp, DBGridEhGrouping;

type
  TfrmFingerEnroll = class(TForm)
    RzPanel1: TRzPanel;
    Label1: TLabel;
    cb_AreaCode: TRzComboBox;
    Label2: TLabel;
    cb_StoreCode: TRzComboBox;
    ds_Staff: TDataSource;
    mt_Staff: TkbmMemTable;
    RzSplitter1: TRzSplitter;
    RzPanel2: TRzPanel;
    mem_FingerLog: TRzMemo;
    btn_Enrool: TRzButton;
    RzButton2: TRzButton;
    RzGroupBox1: TRzGroupBox;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    RzDBEdit1: TRzDBEdit;
    RzDBEdit2: TRzDBEdit;
    ne_fpCount: TRzNumericEdit;
    Label6: TLabel;
    det_FPID: TRzDBEdit;
    dbg_Staff: TDBGridEh;
    ZKEngine: TZKFPEngX;
    siLang: TsiLang;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure cb_AreaCodeChange(Sender: TObject);
    procedure cb_StoreCodeChange(Sender: TObject);
    procedure mt_StaffAfterScroll(DataSet: TDataSet);
    procedure btn_EnroolClick(Sender: TObject);
    procedure ZKEngineFeatureInfo(ASender: TObject; AQuality: Integer);
    procedure ZKEngineCapture(ASender: TObject; ActionResult: WordBool;
      ATemplate: OleVariant);
    procedure ZKEngineEnroll(ASender: TObject; ActionResult: WordBool;
      ATemplate: OleVariant);
  private
    { Private declarations }
  protected
    //----------------------------------------//Effect: 显示地区信息
    //Author: JackyZhou at 2007-10-19         //Remark:
    procedure ShowAreaMas();
    procedure ShowStoreMas(AreaCode: String);
    procedure ShowStaffInfo(StoreCode: string);

  public
     function OpenURU: Boolean;
     function ConnectURU: Boolean;
     // Added by JackyZhou 2010-04-07   //更新显示语言
     function ChangeLanguage(): Boolean;

    //----------------------------------------//Effect: 录取指纹
    //Author: JackyZhou at 2007-10-23         //Remark:
    //procedure EnrollFinger(FPID: Integer);
  end;

var
  frmFingerEnroll: TfrmFingerEnroll;

implementation

uses
  unt_Control, dm_Main, unt_Staff, unt_Biokey, unt_Finger;

var
  Biokey: TBiokey;

{$R *.dfm}

//============================== protected ========================================//
procedure TfrmFingerEnroll.ShowAreaMas;
begin
  cb_AreaCode.Items.Clear;
  cb_AreaCode.Items := Staff.LoadAreaMas(Control.Language);
end;

procedure TfrmFingerEnroll.ShowStoreMas(AreaCode: String);
begin
  cb_StoreCode.Items.Clear;
  cb_StoreCode.Items := Staff.LoadStoreMas(AreaCode, Control.Language);
end;

procedure TfrmFingerEnroll.ShowStaffInfo(StoreCode: string);
begin
  with mt_Staff do
  begin
    LoadFromDataSet( Staff.LoadStoreStaff(StoreCode), [mtcpoStructure] );
    Filter := 'ResignDate IS NULL';
    Filtered := True;
    Fields[0].Visible := False;
    Fields[2].Visible := False;
    Fields[3].Visible := False;
    Fields[4].Visible := False;
    Fields[5].Visible := False;
    Fields[6].Visible := False;
    Fields[7].Visible := False;
    Fields[9].Visible := False;
    case Control.Language of
      ENG : Fields[6].Visible := True;
      CHS : Fields[7].Visible := True;
      GB5 : Fields[5].Visible := True;
    else
      Fields[6].Visible := True;
    end;
  end;
  with dbg_Staff do
  begin
    Columns[0].Width := 50;
    Columns[1].Width := 110;
    Columns[2].Width := 100;
  end;
end;

//============================== public ======================================//
function TfrmFingerEnroll.OpenURU: Boolean;
begin
  //BioKey := TBiokey.Create(Self, ZKEngine);
  //if (not Config.ControlDriver) or ( Config.ControlDriver and Biokey.EnableBiokey) then
  try
    if Biokey.OpenFP then
    begin
      Result := true;
      btn_Enrool.Enabled := true;
    end
    else
    begin
      Result := false;
      btn_Enrool.Enabled := False;
      //mem_FingerLog.Lines.Add('打开指纹仪失败！')
      mem_FingerLog.Lines.Add(siLang.GetText('URU_CANNOT_OPEN'));
    end;
  except
    btn_Enrool.Enabled := False;
    Raise ERangeError.CreateFmt(siLang.GetText('URU_OPEN_EXCEPT'), []);
    Result := false;
  end;
end;

//============================== Event =======================================//
procedure TfrmFingerEnroll.FormCreate(Sender: TObject);
begin
  //OpenURU();
end;

function TfrmFingerEnroll.ConnectURU: Boolean;
begin

  if Assigned(ZKEngine) then
    FreeAndNil(ZKEngine);
  ZKEngine := TZKFPEngX.Create(Self);
  ZKEngine.OnCapture := ZKEngineCapture;
  ZKEngine.OnEnroll := ZKEngineEnroll;
  ZKEngine.OnFeatureInfo := ZKEngineFeatureInfo;
  if Assigned(Biokey) then
    FreeAndNil(Biokey);
  BioKey := TBiokey.Create(Self, ZKEngine);
  if (not Config.ControlDriver) or ( Config.ControlDriver and Biokey.EnableBiokey) then
    Result := OpenURU
  else
    Result := False;
end;


procedure TfrmFingerEnroll.FormShow(Sender: TObject);
begin
  //
  ConnectURU;
  ShowAreaMas();
end;

procedure TfrmFingerEnroll.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if Config.ControlDriver then   
    Biokey.DisableBiokey();
  Action := caFree;
end;

procedure TfrmFingerEnroll.FormDestroy(Sender: TObject);
begin
  //Biokey.DisableBiokey;
  frmFingerEnroll := nil;
end;

procedure TfrmFingerEnroll.cb_AreaCodeChange(Sender: TObject);
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

procedure TfrmFingerEnroll.cb_StoreCodeChange(Sender: TObject);
var
  StoreCode: String;
  iPos: Integer;
begin
  StoreCode := TRzComboBox(Sender).Text;
  iPos := Pos('-', StoreCode);
  StoreCode := LeftStr(StoreCode, iPos -1);
  ShowStaffInfo(StoreCode);
end;

procedure TfrmFingerEnroll.mt_StaffAfterScroll(DataSet: TDataSet);
var
  fpID: string;
begin
  fpID := det_FPID.Text;
  if (DataSet.State = dsBrowse) And (DataSet.RecordCount > 0) then
  begin
    ne_fpCount.Value := Finger.GetFingerCount(fpID);
  end;
end;

procedure TfrmFingerEnroll.btn_EnroolClick(Sender: TObject);
begin
  Biokey.StartEnroll();
  //mem_FingerLog.Lines.Add('请按下手指...');
  mem_FingerLog.Lines.Add(siLang.GetText('ENROLL_PUT'));
end;

//----- 录取指纹，需成功按三次手指
procedure TfrmFingerEnroll.ZKEngineFeatureInfo(ASender: TObject; AQuality: Integer);
var
  enIndex: Integer;
begin
  enIndex := Biokey.FeatureInfo(AQuality);
  if enIndex > 1 then
  begin
    //mem_FingerLog.Lines.Add('还需读取同一手指: '+ IntToStr(enIndex -1) +'次..' );
    //mem_FingerLog.Lines.Add('Still need to read the same finger: '+ IntToStr(enIndex -1) +'次..' );
    mem_FingerLog.Lines.Add(format(siLang.GetText('ENROLL_FEATURE'),[enIndex -1]));
  end;
end;

//----- 成功录取指纹，保存数据
procedure TfrmFingerEnroll.ZKEngineEnroll(ASender: TObject; ActionResult: WordBool; ATemplate: OleVariant);
var
  fpID: string;
  fmData : String;
begin
  fpID := det_FPID.Text;
  if ActionResult then
  begin       
    fmData := ZKEngine.EncodeTemplate1(ATemplate);
    Finger.AddFMData(fpID, fmData);
    //mem_FingerLog.Lines.Add('成功注册指纹。');
    mem_FingerLog.Lines.Add(siLang.GetText('ENROLL_SUCCEED'));
    ne_fpCount.Value := Finger.GetFingerCount( fpID );
  end
  else
  begin
   // mem_FingerLog.Lines.Add('停止登记指纹。');
   mem_FingerLog.Lines.Add(siLang.GetText('ENROLL_FAIL'));
  end;
end;

//----- 验证
procedure TfrmFingerEnroll.ZKEngineCapture(ASender: TObject; ActionResult: WordBool; ATemplate: OleVariant);
var
  fpID: String;
begin
  fpID :=  Biokey.Capture(ATemplate);
  if fpID <> '' then
  begin
     mem_FingerLog.Lines.Add('pfID: ' + fpID);
    //staffID := dmLocal.GetStaffID(fpID);
    //ShowStaffInfo(staffID);
  end;
end;

function TfrmFingerEnroll.ChangeLanguage: Boolean;
begin
  ShowAreaMas();
  cb_StoreCode.Items.Clear;
  mt_Staff.EmptyTable;
end;

end.
