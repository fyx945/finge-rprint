unit unt_Staff;

interface

uses
  unt_Control, SysUtils, DB, Classes;

Type
  TStaff = class
  private

  protected
    //----------------------------------------//Effect: 更新员工信息
    //Author: JackyZhou at 2007-10-24         //Remark:
    //class function GetUpdateTime(StoreCode: string): TDateTime;
    //class procedure GetUpdateTime(StroeCode: string; UpdateCount: Integer);

  public
    //----------------------------------------//Effect: 获得地区信息
    //Author: JackyZhou at 2007-10-20         //Remark:
    function LoadAreaMas(Lang: TLang): TStringList;
    function LoadStoreMas(Area_Code: String; Lang: TLang): TStringList;
    function LoadStoreStaff(StoreCode: String): TDataSet;

    //----------------------------------------//Effect: 获得店铺员工的已录指纹的数据
    //Author: JackyZhou at 2008-02-29         //Remark:
    function LoadStaffFingerCount(StoreCode: String): TDataSet;

    //----------------------------------------//Effect: 更新员工信息
    //Author: JackyZhou at 2007-10-24         //Remark:
    class function UpdateStaffInfo(StoreCode: string): Integer;
  end;

var
  Staff : TStaff;

implementation

uses
  dm_Local;

//============================== protected ==============================//
{class function TStaff.GetUpdateTime(StoreCode: string): TDateTime;
begin

end;

class procedure TStaff.GetUpdateTime(StroeCode: string; UpdateCount: Integer);
begin

end;   }

//============================== public ==============================//
function TStaff.LoadAreaMas(Lang: TLang): TStringList;
var
  iLoop: Integer;
  ADataSet: TDataSet;
  AreaList: TStringList;
  AreaCode, AreaName: String;
begin
  AreaList := TStringList.Create;
  ADataSet := dmLocal.LoadAreaMas();
  ADataSet.First;
  for iLoop := 0 to ADataSet.RecordCount - 1 do
  begin
    AreaCode := ADataSet.FieldByName('Area_Code').AsString;
    case Lang of
      ENG: AreaName := ADataSet.FieldByName('AreaNameE').AsString;
      CHS: AreaName := ADataSet.FieldByName('AreaNameS').AsString;
      GB5: AreaName := ADataSet.FieldByName('AreaNameC').AsString;
    else
      AreaName := ADataSet.FieldByName('AreaNameS').AsString;
    end;
    AreaList.Add(AreaCode +'- '+ AreaName);
    ADataSet.Next;
  end;
  Result :=  AreaList;
end;

function TStaff.LoadStoreMas(Area_Code: String; Lang: TLang): TStringList;
var
  iLoop: Integer;
  ADataSet: TDataSet;
  StoreList: TStringList;
  StoreCode, StoreName: String;
begin
  StoreList := TStringList.Create;
  ADataSet := dmLocal.LoadStoreMas(Area_Code);
  ADataSet.First;
  for iLoop := 0 to ADataSet.RecordCount - 1 do
  begin
    StoreCode := ADataSet.FieldByName('STORE_CODE').AsString;
    case Lang of
      ENG: StoreName := ADataSet.FieldByName('LOCATION_ENG').AsString;
      CHS: StoreName := ADataSet.FieldByName('LOCATION_CHS').AsString;
      GB5: StoreName := ADataSet.FieldByName('LOCATION_CHI').AsString;
    else
      StoreName := ADataSet.FieldByName('LOCATION_ENG').AsString;
    end;
    StoreList.Add(StoreCode +'- '+ StoreName);
    ADataSet.Next;
  end;
  Result :=  StoreList;
end;

function TStaff.LoadStoreStaff(StoreCode: String): TDataSet;
begin
  if StoreCode <> '' then
  begin
    Result := dmLocal.LoadStoreStaff(StoreCode);
  end;
end;

function TStaff.LoadStaffFingerCount(StoreCode: String): TDataSet;
begin
  if StoreCode <> '' then
  begin
    Result := dmLocal.LoadStaffFingerCount(StoreCode);
  end;
end;       

class function TStaff.UpdateStaffInfo(StoreCode: string): Integer;
begin

end;

end.
