unit unt_User;

interface
uses
  unt_Control, DB;

type
  TUser = class
  private

  protected

  public
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
    function GetUserInfo(UserID: String): TUserInfo;

  published

  end;

implementation
uses
  unt_DataVar, dm_Local;

{ TUser }

procedure TUser.AddUser_Pwd(UserID, Pwd, AreaCode, StroeCdoe: string);
var
  EnPwd: String;
begin
  if (UserID <> '') and (Pwd <> '') then
  begin
    EnPwd := KString.EncryptStr(Pwd);
    dmLocal.AddUser_Pwd(UserID, EnPwd, AreaCode, StroeCdoe);
  end;
end;

procedure TUser.AddUser_FMD(UserID, FMD, AreaCode, StroeCdoe: string);
begin
  if (UserID <> '') and (FMD <> '') then
  begin
    dmLocal.AddUser_FMD(UserID, FMD, AreaCode, StroeCdoe);
  end;
end;

procedure TUser.ResetPwd(UserID, Pwd: string);
var
  EnPwd: String;
begin
  if (UserID <> '') and (Pwd <> '') then
  begin
    EnPwd := KString.EncryptStr(Pwd);
    dmLocal.ResetPwd(UserID, EnPwd);
  end;
end;

procedure TUser.ResetFMD(UserID, FMD: string);
begin
  if (UserID <> '') and (FMD <> '') then
  begin
    dmLocal.ResetFMD(UserID, FMD);
  end;
end;

function TUser.GetUserInfo(UserID: String): TUserInfo;
var
  ADataset: TDataset;
  pwd : String;
begin
  if UserID <> '' then
  begin
    ADataset := TDataset.Create(nil);
    ADataset := dmLocal.GetUserInfo(UserID);
    if ADataset.RecordCount = 1 then
    with ADataset do
    begin
      Result.UserID := UserID;
      pwd := FieldByName('Password').AsString;
      Result.PWD := KString.DecryptStr(pwd);
      Result.opArea := FieldByName('opArea').AsString;
      Result.opStore := FieldByName('opStore').AsString;
    end;
  end;
end;

end.
