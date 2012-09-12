unit unt_Sign;

interface
uses
  unt_SendEmail,
  Classes, Controls, DateUtils, SysUtils, kbmMemTable;

Type
  TFPSign = class
  private
    FPreStaff: String;        //上次打卡员工
    FPerSignType: String;     //上次打卡类型
    FPerSignTime: TTime;      //上次打卡时间
  protected
    //Author: JackyZhou at 2006-09-21             //Effect: 设置收件人等信息
    procedure SetupMail(SendEmail : TSendEmail);
    function PerpareSWL_Body(StaffID, SignType: String; SignTime: TDateTime): TStringList;
    
  public
    constructor Create(); virtual;

    //Author: JackyZhou at 2006-09-21             //Effect: 检查当时打卡类型
    // Modified by JackyZhou 2008-2-20 10:39:42   //Remark:
    function RuleSignType(): Integer;

    //Author: JackyZhou at 2006-09-21             //Effect: 检查打卡的有效性
    // Modified by JackyZhou 2008-2-20 10:39:42   //Remark:
    function CheckSign(StaffID, SignType: String): Boolean;

    //Author: JackyZhou at 2007-02-02             //Effect: 检查用餐间隔时间
    // Modified by JackyZhou 2008-2-20 10:57:03
    function CheckMealTime(StaffID: String; SignTime: TDateTime): Boolean;

    //Author: JackyZhou at 2006-09-22             //Effect: 检查打卡时间，判断是否非法打卡
    // Modified by JackyZhou 2008-2-20 10:44:35   //正常打卡返回Turn
    function CheckSignTime(SignTime: TDateTime): Boolean;

    //Author: JackyZhou at 2008-02-20            //Effect: 发打卡警告信  
    function SendSingWarningLetter(StaffID, SignType: String; SignTime: TDateTime): Boolean;
    
  end;

implementation
uses
  unt_DataVar, unt_System, unt_Control, dm_Local_old;

{ TFPSign }

procedure TFPSign.SetupMail(SendEmail: TSendEmail);
var
  addTable: TkbmMemTable;
  //Receipient, CCList, BCCList: TStringList;
  Address, SendType : String;
begin
  {Receipient := TStringList.Create;
  CCList := TStringList.Create;
  BCCList := TStringList.Create;  }
  addTable := TkbmMemTable.Create(nil);
  addTable.LoadFromDataSet( dmLocal_old.LoadRecipients( Config.StoreCode), [mtcpoStructure] );
  
  with  SendEmail do
  begin
    SMTPHost := Config.MailHost;
    SMTPUsername := Config.MailUsername;
    SMTPPassword := Config.MailPassword;

    SenderName := MAIL_SENDER_NAME;
    SenderAddress := MAIL_SENDER_ADD;
    Subject := MAIL_SWL_SUBJECT;

    addTable.First;
    while not(addTable.Eof) do
    begin
      SendType := addTable.FieldByName('SendType').AsString;
      Address := addTable.FieldByName('EAddress').AsString;
      if UpperCase(SendType) = 'TO' then
      begin
        //Receipient.Add(Address);
        Receipient := Receipient + Address + ';';
      end
      else
      begin
        if UpperCase(SendType) = 'CC' then
           CCList := CCList + Address + ';'
          //CCList.Add(Address)
        else
          BCCList := BCCList + Address + ';';
          //BCCList.Add(Address);
      end;
      addTable.Next;
    end;
    BCCList := BCCList + MAIL_SENDER_ADD;
  end;
end;

function TFPSign.PerpareSWL_Body(StaffID, SignType: String; SignTime: TDateTime): TStringList;
var
  Body: TStringList;
  sName, eName, staffName: String;
  lastSignTime: TDateTime;
begin
  sName := dmLocal_old.GetStaffName(FPreStaff, CHS);
  eName := dmLocal_old.GetStaffName(FPreStaff, ENG);
  staffName := sName;
  if eName <> '' then
  begin
    staffName := ', ' + eName
  end;
  lastSignTime := dmLocal_old.GetLastSignTime;

  Body := TStringList.Create;
  Body.Add(Config.StoreCode  +' 打卡出现异常，请查看：');
  Body.Add('    打卡员工: ' + staffID +'  ' +staffName);
  Body.Add('    打卡时间: ' + DateTimeToStr(signTime));
  Body.Add('    上次打卡: ' + DateTimeToStr(lastSignTime));
  Body.Add('    打卡类型: ' + signType);
  Body.Add('');
  Body.Add('当前电脑时间：' + DateTimeToStr(now) );
  Body.Add('邮件发送于：' + KSys.Get_ComputerName);
  Body.Add('IP地址为：' +KSys.GetLocalIP);

  Result := Body;
end;

//======================================== public ========================================//
constructor TFPSign.Create;
begin

end;    

function TFPSign.RuleSignType(): Integer;
var
  nTime: TDateTime;
begin
  nTime := Time();
  Result := 0;
  if (nTime >= StrToTime('08:00:00')) and (nTime <StrToTime('10:00:00')) then   //上班
    Result := 1;
  if (nTime >= StrToTime('10:00:00')) and (nTime <StrToTime('12:30:00')) then   //外出
    Result := 3;
  if (nTime >= StrToTime('12:30:00')) and (nTime <StrToTime('13:30:00')) then   //用餐
    Result := 5;
  if (nTime >= StrToTime('13:30:00')) and (nTime <StrToTime('14:30:00')) then   //用餐回
    Result := 6;
  if (nTime >= StrToTime('14:30:00')) and (nTime <StrToTime('17:50:00')) then   //外出回
    Result := 4;
  if (nTime >= StrToTime('17:50:00')) and (nTime <StrToTime('23:59:59')) then   //下班
    Result := 2;
  if (nTime >= StrToTime('00:00:00')) and (nTime <StrToTime('08:00:00')) then   //下班
    Result := 2;
end;

function TFPSign.CheckSign(StaffID, SignType: String): Boolean;
begin
  if (staffID = FPreStaff) and (SignType = FPerSignType) then
  begin
    if SecondsBetween(Time(), FPerSignTime) > 60 then       //同一员工相隔1分打同一类型卡
    begin
      FPerSignTime := Time();
      Result := True;
    end
    else
    begin
      Result := false;
    end;
  end
  else
  begin
    FPerSignTime := Time();
    FPreStaff := StaffID;
    FPerSignType := SignType;
    Result := True;
  end;   
end;

function TFPSign.CheckMealTime(StaffID: String; SignTime: TDateTime): Boolean;
var
  mealTime : TDateTime;
begin
  mealTime := dmLocal_old.GetMealTime(staffID);
  if IncMinute(mealTime , config.MealTime) >= signTime then
    Result := true
  else
    Result := false;
end;

function TFPSign.CheckSignTime(signTime: TDateTime): Boolean;
var
  lastSignTime : TDateTime;
  staffName, eName, sName : String;
const
  SIGN_SPACE_SEC = 100;
begin
  lastSignTime := dmLocal_old.GetLastSignTime;
  if (SignTime < lastSignTime) and (lastSignTime > 0) and
     (SecondsBetween(SignTime, lastSignTime) > SIGN_SPACE_SEC) then
    Result := False
  else
    Result := True;
end;

function TFPSign.SendSingWarningLetter(StaffID, SignType: String; SignTime: TDateTime): Boolean;
var
  SendEmail : TSendEmail;
begin
  SendEmail := TSendEmail.Create();
  SetupMail(SendEmail);
  SendEmail.MailBody := PerpareSWL_Body(StaffID, SignType, SignTime);

  Result := SendEmail.SendEmail();
end;           

end.
