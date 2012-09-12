unit unt_bulletinUtils;

interface

uses unt_BbsConfig,classes;

type

IBulletinObserver = interface(IInterface)
  procedure refresh(blts:TStrings);
end;

TBulletin = class(TObject)
  private
    FId:String;
    FPublishTime:TDateTime;
    FTitle:String;
  public
    property Id:String read FId write FId;
    property PublishTime:TDateTime read FPublishTime write FPublishTime;
    property Title:String read FTitle write FTitle;
end;

TBulletinService = class(TObject)
  private
    FBbsConfig:TBbsConfig;
    FObserver:IBulletinObserver;
  public
    property BbsConfig:TBbsConfig read FBbsConfig write FBbsConfig;
    property Observer: IBulletinObserver read FObserver write FObserver;
    function getFreshBulletin(BbsConfig:TBbsConfig):TStrings;
    procedure refresh();
end;



implementation

uses dm_server;  

{ TBulletinUtil }

procedure TBulletinService.refresh;
var
  blts:TStrings;
begin
  blts := getFreshBulletin(FBbsCOnfig);
  if blts <> nil then begin
    FObserver.refresh(blts);
  end;
end;

function TBulletinService.getFreshBulletin(BbsConfig: TBbsConfig): TStrings;
begin
  result := dmServer.GetFreshBlt(BbsConfig.StoreCode,BbsConfig.BltShowAmount);
end;

end.
