unit dm_Main;

interface

uses
  SysUtils, Classes, ImgList, Controls, siComp, MemDS, DBAccess, MyAccess, DB, ADODB, Forms,comobj;

type
  TdmMain = class(TDataModule)
    MyC_Server: TMyConnection;
    MyQ_Server: TMyQuery;
    siLang: TsiLang;
    siLangDispatcher: TsiLangDispatcher;
    ImageList: TImageList;
    ac_Local: TADOConnection;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    //Author: JackyZhou at 2008-03-06             //Effect: 连接/关闭数据库
    function OpenLocalDatabase(): Boolean;
    function CloseLocalDatabase(): Boolean;
    function ConnetServerDatabase(): Boolean;
    function CloseServerDatabase(): Boolean;
    PROCEDURE CompactDatabase;
  end;

type
  TControlDB = class
  private

  public
    constructor Create(); virtual;

    function Local_OpenDatabase(): Boolean;
    function Local_CloseDatabase(): Boolean;
    procedure Local_StartTransaction();
    procedure Local_Commit();
    procedure Local_Rollback();

    function Server_OpenDatabase(): Boolean;
    function Server_CloseDatabase(): Boolean;
    procedure Server_StartTransaction();
    procedure Server_Commit();
    procedure Server_Rollback();
  end;

var
  dmMain: TdmMain;

implementation
uses
  unt_Control;

const
  ConnLocalStr = 'Provider=Microsoft.Jet.OLEDB.4.0;Password="%S";Data Source=%S;Persist Security Info=True';

{$R *.dfm}

{ TControlDB }

constructor TControlDB.Create;
begin

end;

function TControlDB.Local_OpenDatabase: Boolean;
begin
  Result := dmMain.OpenLocalDatabase();
end;

function TControlDB.Local_CloseDatabase: Boolean;
begin
  Result := dmMain.CloseLocalDatabase();
end;   

procedure TControlDB.Local_StartTransaction;
begin
  dmMain.ac_Local.BeginTrans;
end;

procedure TControlDB.Local_Commit;
begin
  dmMain.ac_Local.CommitTrans;;
end;

procedure TControlDB.Local_Rollback;
begin
  dmMain.ac_Local.RollbackTrans;
end;

function TControlDB.Server_OpenDatabase: Boolean;
begin
  Result := dmMain.ConnetServerDatabase();
end;

function TControlDB.Server_CloseDatabase: Boolean;
begin
  Result := dmMain.CloseServerDatabase();
end;

procedure TControlDB.Server_StartTransaction;
begin
  dmMain.MyC_Server.StartTransaction;
end;

procedure TControlDB.Server_Commit;
begin
  dmMain.MyC_Server.Commit;
end;

procedure TControlDB.Server_Rollback;
begin
  dmMain.MyC_Server.Rollback;
end;

{ TdmMain }

procedure TdmMain.DataModuleCreate(Sender: TObject);
begin
  CompactDatabase;
  ac_Local.Close;
  ac_Local.ConnectionString := 'Provider=Microsoft.Jet.OLEDB.4.0;Data Source=Data\FPData.mdb;Persist Security Info=False';
  ac_Local.Open();
  Control := TControl.Create( ExtractFileDir(Application.ExeName) );
end;

function TdmMain.CloseLocalDatabase: Boolean;
begin
  try
    OpenLocalDatabase;
    ac_Local.LoginPrompt := False;
    ac_Local.ConnectionString := Format(ConnLocalStr, [Config.LDBPassword, Config.LDBFile]);
    ac_Local.Connected := true;
    Result := true;
  except
    Raise ERangeError.CreateFmt(siLang.GetText('NOT_OPEN_LOCAL_DB'), [Config.LDBFile]);
  end;
end;

function TdmMain.OpenLocalDatabase: Boolean;
begin
  try
    if ac_Local.Connected then
      ac_Local.Connected := false;
    Result := true;
  except
    Raise ERangeError.CreateFmt(siLang.GetText('NOT_CLOSE_LOCAL_DB'), []);
    Result := false;
  end;
end;

procedure TdmMain.CompactDatabase;
var
  DaoVar: OLEVariant;
  spath,scurrdb,stmpdb:string;
begin 
  //if DM.con1.Connected then DM.con1.Connected := false; //如果数据模块中的数据库连接打开，请先关闭 
  spath := getcurrentdir + '\data\';
  scurrdb := spath + 'FPData.mdb';
  stmpDB := spath + 'temp.mdb';

    try
      try
        DaoVar := CreateOleObject('DAO.DBEngine.36');
        if FileExists(stmpDB) then DeleteFile(stmpDB); //删除临时数据库文件\\\"temp.mdb\\\"
          DaoVar.CompactDatabase(scurrdb, stmpDB); //压缩\\\"dbName\\\" 到\\\"temp.mdb\\\"
        if DeleteFile(PChar(scurrdb)) then //删除文件\\\"dbName\\\"
          RenameFile(stmpDB, scurrdb); //将\\\"temp.mdb\\\"改名为\\\"dbName \\\"
//        ShowMessage('压缩成功');

      except 

      end; 
    finally 
     // DM.con1.Connected := true; //为了其它操作能够正常执行，还要打开数据库连接 
    end;
end;

function TdmMain.ConnetServerDatabase: Boolean;
begin
  try
    MyC_Server.Server := Config.SDBServer;
    MyC_Server.Username := Config.SDBUserName;
    MyC_Server.Password := Config.SDBPassword;
    MyC_Server.Database := Config.SDBDatabase;
    MyC_Server.Connect;
  except
    Raise ERangeError.Create(siLang.GetText('NOT_CONNNET_SERVER_DB'));
  end;
  Result := MyC_Server.Connected;
end;

function TdmMain.CloseServerDatabase: Boolean;
begin
  try
    MyC_Server.Disconnect;
  except
    Raise ERangeError.Create(siLang.GetText('NOT_CLOSE_SERVER_DB'));
  end;
  Result := not(MyC_Server.Connected);
end;

end.
