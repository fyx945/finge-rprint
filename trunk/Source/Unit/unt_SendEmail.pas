unit unt_SendEmail;

interface

uses
  Classes, 
  IdMessage, IdBaseComponent, IdComponent, IdAttachmentFile, IdAttachment,
  IdTCPConnection, IdTCPClient, IdExplicitTLSClientServerBase, IdEMailAddress,
  IdMessageClient, IdSMTPBase, IdSMTP;

Type
  TSendEmail = class(TComponent)   
  private
    IdMsg: TIdMessage;
    IdSMTP: TIdSMTP;
    FReadReceipt: Boolean;
    FPriority: Integer;
    FSMTPHost: string;
    FCCList: String;
    FSMTPPassword: string;
    FSubject: String;
    FSMTPUsername: string;
    FBCCList: String;
    FSenderAddress: String;
    FSenderName: String;
    FReceipient: String;
    FMailBody: TStrings;
    FAttachment: TStrings;
    procedure SetAttachment(const Value: TStrings);
    procedure SetBCCList(const Value: String);
    procedure SetCCList(const Value: String);
    procedure SetMailBody(const Value: TStrings);
    procedure SetPriority(const Value: Integer);
    procedure SetReadReceipt(const Value: Boolean);
    procedure SetReceipient(const Value: String);
    procedure SetSenderAddress(const Value: String);
    procedure SetSenderName(const Value: String);
    procedure SetSubject(const Value: String);
    procedure SetSMTPHost(const Value: string);
    procedure SetSMTPPassword(const Value: string);
    procedure SetSMTPUsername(const Value: string);
  protected
    //Author: JackyZhou at 2007-01-25             //Effect: 连接邮件服务器
    function ConnectSMTP(): Boolean;   
  public
    //constructor Create(Host, UserName, Password: String); virtual;
    constructor Create(); virtual;
    destructor Destroy; override;

    //--------------------------------------------//Effect: 发送邮件
    //Author: JackyZhou at 2007-11-22             //Remerk:
    function SendEmail(): Boolean;

  published
    property SMTPHost: string read FSMTPHost write SetSMTPHost;
    property SMTPUsername: string read FSMTPUsername write SetSMTPUsername;
    property SMTPPassword: string read FSMTPPassword write SetSMTPPassword;
    property SenderName: String read FSenderName write SetSenderName;
    property SenderAddress: String read FSenderAddress write SetSenderAddress;
    property Receipient: String read FReceipient write SetReceipient;
    property CCList: String read FCCList write SetCCList;
    property BCCList: String read FBCCList write SetBCCList;
    property ReadReceipt: Boolean read FReadReceipt write SetReadReceipt;
    property Priority: Integer read FPriority write SetPriority;
    property Subject: String read FSubject write SetSubject;
    property MailBody: TStrings read FMailBody write SetMailBody;
    property Attachment: TStrings read FAttachment write SetAttachment;
  end;

implementation

uses
  unt_Config, unt_DataVar;

{ TSendEmail }

//=================================== Published ===================================//
procedure TSendEmail.SetSMTPHost(const Value: string);
begin
  FSMTPHost := Value;
  IdSMTP.Host := FSMTPHost;
end;

procedure TSendEmail.SetSMTPUsername(const Value: string);
begin
  FSMTPUsername := Value;
  IdSMTP.Username := FSMTPUsername;
end;

procedure TSendEmail.SetSMTPPassword(const Value: string);
begin
  FSMTPPassword := Value;
  IdSMTP.Password := FSMTPPassword;
end;

procedure TSendEmail.SetSenderName(const Value: String);
begin
  FSenderName := Value;
  IdMsg.From.Name := FSenderName;
end;

procedure TSendEmail.SetSenderAddress(const Value: String);
begin
  FSenderAddress := Value;
  IdMsg.From.Address := FSenderAddress;
end;          

procedure TSendEmail.SetReceipient(const Value: String);
var
  addItem : TIdEMailAddressItem;
  addList : TStringList;
  i : integer;
begin
  FReceipient := Value;
  addList := TStringList.Create;
  addList := KString.DisasStr(FReceipient, ';');
  IdMsg.Recipients.Clear;
  for i := 0 to addList.Count -1 do
  begin
    addItem := IdMsg.Recipients.Add;
    addItem.Address := addList[i];
  end;
end;

procedure TSendEmail.SetCCList(const Value: String);
var
  addItem : TIdEMailAddressItem;
  addList : TStringList;
  i : integer;
begin
  FCCList := Value;
  addList := TStringList.Create;
  addList := KString.DisasStr(FCCList, ';');
  IdMsg.CCList.Clear;
  for i := 0 to addList.Count -1 do
  begin
    addItem := IdMsg.CCList.Add;
    addItem.Address := addList[i];
  end;
end;

procedure TSendEmail.SetBCCList(const Value: String);
var
  addItem : TIdEMailAddressItem;
  addList : TStringList;
  i : integer;
begin
  FBCCList := Value;
  addList := TStringList.Create;
  addList := KString.DisasStr(FBCCList, ';');
  IdMsg.BccList.Clear;
  for i := 0 to addList.Count -1 do
  begin
    addItem := IdMsg.BccList.Add;
    addItem.Address := addList[i];
  end;
end;

procedure TSendEmail.SetReadReceipt(const Value: Boolean);
begin
  FReadReceipt := Value;
  if FReadReceipt then
    IdMsg.ReceiptRecipient.Text := SenderAddress;
end;

procedure TSendEmail.SetPriority(const Value: Integer);
begin
  FPriority := Value;
  IdMsg.Priority := TIdMessagePriority(FPriority);
end;

procedure TSendEmail.SetSubject(const Value: String);
begin
  FSubject := Value;
  IdMsg.Subject := FSubject;
end;

procedure TSendEmail.SetMailBody(const Value: TStrings);
begin
  FMailBody := Value;
  IdMsg.Body := FMailBody;
end;

procedure TSendEmail.SetAttachment(const Value: TStrings);
var
  iLoop : integer;
  attFile: String;
begin
  FAttachment := Value;
  IdMsg.MessageParts.Clear;
  for iLoop := 0 to Attachment.Count -1 do
  begin
    attFile := Attachment.ValueFromIndex[iLoop];
    TIdAttachmentFile.Create( IdMsg.MessageParts, attFile );
  end;
end;

//=================================== protected ===================================//
function TSendEmail.ConnectSMTP: Boolean;
begin
  try
    with IdSMTP do
    begin
      Host := FSMTPHost;
      Username := FSMTPUsername;
      Password := FSMTPPassword;
      Connect;
    end;
  finally
    Result := IdSMTP.Connected;
  end;
end;

//=================================== public ===================================//

constructor TSendEmail.Create();
begin
  IdSMTP := TIdSMTP.Create(Self);
  IdSMTP.AuthType := atDefault;
  IdMsg := TIdMessage.Create(Self);
  IdMsg.CharSet := 'UTF-8';

  {FSMTPHost := Host;
  FSMTPUsername := UserName;
  FSMTPPassword := Password;      }

  {SMTPHost := Config.Email.Host;
  SMTPUsername := Config.Email.User;
  SMTPPassword := KH_Utils.DecryptString( Config.Email.Password, '' );

  SenderName := Config.Email.Sender;;
  SenderAddress := Config.Email.FromAdd;;          }
end;

destructor TSendEmail.Destroy;
begin

  inherited;
end;

function TSendEmail.SendEmail(): Boolean;
begin
  if ConnectSMTP() then
  begin
    try
      IdSMTP.Send(IdMsg);
    finally
      IdSMTP.Disconnect;
      Result := True;
    end;
  end
  else
  begin
    Result := false;
  end;
end;

end.
 