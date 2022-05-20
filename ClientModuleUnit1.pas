unit ClientModuleUnit1;

interface

uses
  System.SysUtils, System.Classes, ClientClassesUnit1, Datasnap.DSClientRest,
  REST.Response.Adapter, System.IOUtils, System.IniFiles;

type
  TClientModule1 = class(TDataModule)
    DSRestConnection1: TDSRestConnection;
  private
    id : string;
    PW : string;
    FInstanceOwner: Boolean;
    FServerMethods1Client: TServerMethods1Client;
    function GetServerMethods1Client: TServerMethods1Client;
    function TestConnect(var ErrorMsg: String): Boolean;
    { Private declarations }
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property InstanceOwner: Boolean read FInstanceOwner write FInstanceOwner;
    property ServerMethods1Client: TServerMethods1Client read GetServerMethods1Client write FServerMethods1Client;
    procedure Write_LoginInfo_INIFiles(PackageNm, userID, userPW: String; userAuto: Boolean);
    procedure Read_LoginInfo_INIFiles(PackageNm:string; var  userID,  userPW: String;var userAuto: Boolean);
    function login():Boolean ;

end;

const
  C_INI_FNAME = 'HIS_UTIL.INI';

var
  CM1: TClientModule1;

implementation

uses
  TabbedFormwithNavigation;

{%CLASSGROUP 'FMX.Controls.TControl'}

{$R *.dfm}

constructor TClientModule1.Create(AOwner: TComponent);
var
  errMsg :string;
begin
  inherited;
  FInstanceOwner := True;
  {
  if not TestConnect(errMsg) then
  begin
    errMsg := 'CM1: '+ errMsg;
  end;
  }
end;

destructor TClientModule1.Destroy;
begin
  FServerMethods1Client.Free;
  inherited;
end;

function TClientModule1.GetServerMethods1Client: TServerMethods1Client;
begin
  if FServerMethods1Client = nil then
    FServerMethods1Client:= TServerMethods1Client.Create(DSRestConnection1, FInstanceOwner);
  Result := FServerMethods1Client;
end;

function TClientModule1.login: Boolean;
var
  eMsg :string;
begin
  result := TestConnect(eMsg);
  if eMsg <> '' then
    raise Exception.Create(eMsg);
end;

function TClientModule1.TestConnect(var ErrorMsg: String): Boolean;
var
  returned: String;
begin
  Result := True;
    try
      DSRestConnection1.UserName := id;
      DSRestConnection1.Password := pw ; //'MYruP+2MnQQNNaf8H6d2+zEwODOqLeiFNU3fPUTY+2k=';
      DSRestConnection1.TestConnection([toNoLoginPrompt]);
    except
      on e: exception do
      begin
        Result := False;
        ErrorMsg := e.Message;
      end
    end;
end;

procedure TClientModule1.Write_LoginInfo_INIFiles(PackageNm, userID, userPW : String; userAuto : Boolean);
var
    sPath : String;
    iniFile : TIniFile;
begin
    // TPath.GetDocumentsPath

    // https://docwiki.embarcadero.com/RADStudio/Rio/en/Standard_RTL_Path_Functions_across_the_Supported_Target_Platforms

    // OSX : /Users/<username>/Documents
    // iOS : /var/mobile/Applications/<application ID>/Documents  (시뮬레이터는 다름)
    // Android : GetFilesDir -> Internal Memory
    // Window : CSIDL_PERSONAL

    try
      sPath := TPath.GetDocumentsPath + TPath.DirectorySeparatorChar + C_INI_FNAME;
      iniFile := TIniFile.Create( sPath );
    except on E: Exception do
      raise Exception.Create(e.Message + '| Fail to Create INIFile' + #13#10 + sPath );
    end;


    iniFile.WriteString( 'HIS_UTIL', 'POS_TYPE', PackageNm );
    iniFile.WriteString( 'HIS_UTIL', 'USER_ID' , userID    );
    iniFile.WriteString( 'HIS_UTIL', 'USER_PW' , userPW    );
    if userAuto = True then
        iniFile.WriteString( 'HIS_UTIL', 'AUTO', 'T' )
    else
        iniFile.WriteString( 'HIS_UTIL', 'AUTO', 'F' );

    iniFile.Free;
end;

procedure TClientModule1.Read_LoginInfo_INIFiles(PackageNm:string; var userID,  userPW : String;var userAuto : Boolean);
var
  iniFile : TIniFile;
  sPath : string;
begin
  Try
    //sPath := TPath.GetDocumentsPath + System.SysUtils.PathDelim+ 'HIS_UTIL' + System.SysUtils.PathDelim+ C_INI_FNAME;
    sPath := TPath.GetDocumentsPath + System.SysUtils.PathDelim+ C_INI_FNAME;
    iniFile := TIniFile.Create( sPath);
    // Windows10 : C:\Users\Administrator\Documents\HIS_UTIL.INI
  except on E: Exception do
    raise Exception.Create(e.Message + '| Fail to Create INIFile' + #13#10 + sPath);
  end;

  try
    userID := iniFile.ReadString('HIS_UTIL', 'USER_ID', '');
    userPW := iniFile.ReadString('HIS_UTIL', 'USER_PW', '');
    userAuto := ('T' = iniFile.ReadString('HIS_UTIL', 'AUTO', 'F'));

    id := userID;
    PW := userPW;

  finally
    iniFile.Free;
  end;
end;

end.
