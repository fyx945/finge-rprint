unit unt_domain;

interface

uses
  StrUtils, Windows, Messages, SysUtils, Variants, Classes;


type
  TStaff = class
  private
    FAreaCode: String;
    FStaffId: String;
    FUpdateTime: TDateTime;
    FNickname: String;
    FResignDate: TDateTime;
    FfpId: String;
    FDateOfJoin: TDateTime;
    FStaffNameCn: String;
    FStoreCode: String;
    FStaffNameEn: String;
    FStaffNameTw: String;
    procedure SetAreaCode(const Value: String);
    procedure SetDateOfJoin(const Value: TDateTime);
    procedure SetfpId(const Value: String);
    procedure SetNickname(const Value: String);
    procedure SetResignDate(const Value: TDateTime);
    procedure SetStaffId(const Value: String);
    procedure SetUpdateTime(const Value: TDateTime);
    procedure SetStaffNameCn(const Value: String);
    procedure SetStaffNameEn(const Value: String);
    procedure SetStaffNameTw(const Value: String);
    procedure SetStoreCode(const Value: String);
  published

  public
    property StaffId:String read FStaffId write SetStaffId;
    property fpId:String read FfpId write SetfpId;
    property AreaCode:String read FAreaCode write SetAreaCode;
    property StoreCode:String read FStoreCode write SetStoreCode;
    property StaffNameEn:String read FStaffNameEn write SetStaffNameEn;
    property StaffNameTw:String read FStaffNameTw write SetStaffNameTw;
    property StaffNameCn:String read FStaffNameCn write SetStaffNameCn;
    property Nickname:String read FNickname write SetNickname;
    property DateOfJoin:TDateTime read FDateOfJoin write SetDateOfJoin;
    property ResignDate:TDateTime read FResignDate write SetResignDate;
    property UpdateTime:TDateTime read FUpdateTime write SetUpdateTime;
  end;

implementation

{ TStaff }

procedure TStaff.SetAreaCode(const Value: String);
begin
  FAreaCode := Value;
end;

procedure TStaff.SetDateOfJoin(const Value: TDateTime);
begin
  FDateOfJoin := Value;
end;

procedure TStaff.SetfpId(const Value: String);
begin
  FfpId := Value;
end;

procedure TStaff.SetNickname(const Value: String);
begin
  FNickname := Value;
end;

procedure TStaff.SetResignDate(const Value: TDateTime);
begin
  FResignDate := Value;
end;

procedure TStaff.SetStaffId(const Value: String);
begin
  FStaffId := Value;
end;

procedure TStaff.SetStaffNameCn(const Value: String);
begin
  FStaffNameCn := Value;
end;

procedure TStaff.SetStaffNameEn(const Value: String);
begin
  FStaffNameEn := Value;
end;

procedure TStaff.SetStaffNameTw(const Value: String);
begin
  FStaffNameTw := Value;
end;

procedure TStaff.SetStoreCode(const Value: String);
begin
  FStoreCode := Value;
end;

procedure TStaff.SetUpdateTime(const Value: TDateTime);
begin
  FUpdateTime := Value;
end;

end.
