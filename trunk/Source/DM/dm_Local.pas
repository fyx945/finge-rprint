unit dm_Local;

interface

uses
  unt_XML, SysUtils, Classes, DB, ADODB;

type
  TdmLocal = class(TDataModule)
    aq_Staff: TADOQuery;
    aq_User: TADOQuery;
    procedure DataModuleCreate(Sender: TObject);
  private
    FLocalSQL : TKXML;
  public
    //======================================== Staff ========================================//
    //----------------------------------------//Effect: 获得地区信息
    //Author: JackyZhou at 2007-10-17         //Remark:
    function LoadAreaMas(): TDataSet;
    function LoadStoreMas(Area_Code: String): TDataSet;
    function LoadStoreStaff(StoreCode: String): TDataSet;

    //----------------------------------------//Effect: 获得店铺员工的已录指纹的数据
    //Author: JackyZhou at 2008-03-05         //Remark:
    function LoadStaffFingerCount(StoreCode: String): TDataSet;

    //======================================== User ========================================//
    //----------------------------------------//Effect: 增加用户
    //Author: JackyZhou at 2008-03-07         //Remark:
    procedure AddUser_Pwd(UserID, Pwd, AreaCode, StroeCdoe: string);
    procedure AddUser_FMD(UserID, FMD, AreaCode, StroeCdoe: string);

    //----------------------------------------//Effect: 重置密码
    //Author: JackyZhou at 2008-03-07         //Remark:
    procedure ResetPwd(UserID, Pwd: string);
    procedure ResetFMD(UserID, FMD: string);

    //----------------------------------------//Effect: 获得用户信息
    //Author: JackyZhou at 2008-03-08         //Remark:
    function GetUserInfo(UserID: String): TDataSet;
  end;

var
  dmLocal: TdmLocal;

implementation

uses
  dm_Main, unt_Control;

{$R *.dfm}


procedure TdmLocal.DataModuleCreate(Sender: TObject);
begin
  FLocalSQL := TKXML.Create(Control.AppPath + '\SQL\Local.xml');
end;

function TdmLocal.LoadAreaMas: TDataSet;
begin
  with aq_Staff do
  begin
    SQL.Text := FLocalSQL.GetNodeValue('Local.Staff.AreaMas');
    Open;
  end;
  Result := aq_Staff;
end;

function TdmLocal.LoadStoreMas(Area_Code: String): TDataSet;
begin
   with aq_Staff do
  begin
    SQL.Text := FLocalSQL.GetNodeValue('Local.Staff.SotreMas');
    Parameters.ParamByName('pArea_Code').Value := Area_Code;
    Open;
  end;
  Result := aq_Staff;
end;

function TdmLocal.LoadStoreStaff(StoreCode: String): TDataSet;
begin
  with aq_Staff do
  begin
    SQL.Text := FLocalSQL.GetNodeValue('Local.Staff.StoreStaff');
    Parameters.ParamByName('pStore_Code').Value := StoreCode;
    Open;
  end;
  Result := aq_Staff;
end;



function TdmLocal.LoadStaffFingerCount(StoreCode: String): TDataSet;
begin
  with aq_Staff do
  begin
    SQL.Text := FLocalSQL.GetNodeValue('Local.Staff.LoadStaffFingerCount');
    Parameters.ParamByName('pStoreCode').Value := StoreCode;
    Open;
  end;
  Result := aq_Staff;
end;

//======================================== User ========================================//
procedure TdmLocal.AddUser_Pwd(UserID, Pwd, AreaCode, StroeCdoe: string);
begin
  with aq_User do
  begin
    SQL.Text := FLocalSQL.GetNodeValue('Local.User.AddUser_Pwd');
    Parameters.ParamByName('pUserID').Value := UserID;
    Parameters.ParamByName('pPwd').Value := Pwd;
    Parameters.ParamByName('pAreaCode').Value := AreaCode;
    Parameters.ParamByName('pStoreCode').Value := StroeCdoe;
    ExecSQL;
  end;
end;

procedure TdmLocal.AddUser_FMD(UserID, FMD, AreaCode, StroeCdoe: string);
begin
  with aq_User do
  begin
    SQL.Text := FLocalSQL.GetNodeValue('Local.User.AddUser_FMD');
    Parameters.ParamByName('pUserID').Value := UserID;
    Parameters.ParamByName('pFMData').Value := FMD;
    Parameters.ParamByName('pAreaCode').Value := AreaCode;
    Parameters.ParamByName('pStoreCode').Value := StroeCdoe;
    ExecSQL;
  end;
end;

procedure TdmLocal.ResetPwd(UserID, Pwd: string);
begin
  with aq_User do
  begin
    SQL.Text := FLocalSQL.GetNodeValue('Local.User.ResetPwd');
    Parameters.ParamByName('pUserID').Value := UserID;
    Parameters.ParamByName('pPwd').Value := Pwd;
    ExecSQL;
  end;
end;

procedure TdmLocal.ResetFMD(UserID, FMD: string);
begin
  with aq_User do
  begin
    SQL.Text := FLocalSQL.GetNodeValue('Local.User.ResetFMD');
    Parameters.ParamByName('pUserID').Value := UserID;
    Parameters.ParamByName('pFMData').Value := FMD;
    ExecSQL;
  end;
end;

function TdmLocal.GetUserInfo(UserID: String): TDataSet;
begin
  with aq_User do
  begin
    Close;
    SQL.Text := FLocalSQL.GetNodeValue('Local.User.UserInfo');
    Parameters.ParamByName('pUserID').Value := UserID;
    Open;
    ExecSQL;
  end;
  Result := aq_User;
end;


end.
