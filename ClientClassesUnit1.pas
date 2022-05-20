//
// Created by the DataSnap proxy generator.
// 2022-04-26 ¿ÀÈÄ 4:02:40
// 

unit ClientClassesUnit1;

interface

uses System.JSON, Datasnap.DSProxyRest, Datasnap.DSClientRest, Data.DBXCommon, Data.DBXClient, Data.DBXDataSnap, Data.DBXJSON, Datasnap.DSProxy, System.Classes, System.SysUtils, Data.DB, Data.SqlExpr, Data.DBXDBReaders, Data.DBXCDSReaders, Data.DBXJSONReflect;

type
  TServerMethods1Client = class(TDSAdminRestClient)
  private
    FEchoStringCommand: TDSRestCommand;
    FReverseStringCommand: TDSRestCommand;
    FGetDeptTelCommand: TDSRestCommand;
    FGetUserInfoCommand: TDSRestCommand;
  public
    constructor Create(ARestConnection: TDSRestConnection); overload;
    constructor Create(ARestConnection: TDSRestConnection; AInstanceOwner: Boolean); overload;
    destructor Destroy; override;
    function EchoString(Value: string; const ARequestFilter: string = ''): string;
    function ReverseString(Value: string; const ARequestFilter: string = ''): string;
    function GetDeptTel(Value: string; const ARequestFilter: string = ''): string;
    function GetUserInfo(Value: string; const ARequestFilter: string = ''): string;
  end;

const
  TServerMethods1_EchoString: array [0..1] of TDSRestParameterMetaData =
  (
    (Name: 'Value'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: ''; Direction: 4; DBXType: 26; TypeName: 'string')
  );

  TServerMethods1_ReverseString: array [0..1] of TDSRestParameterMetaData =
  (
    (Name: 'Value'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: ''; Direction: 4; DBXType: 26; TypeName: 'string')
  );

  TServerMethods1_GetDeptTel: array [0..1] of TDSRestParameterMetaData =
  (
    (Name: 'Value'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: ''; Direction: 4; DBXType: 26; TypeName: 'string')
  );

  TServerMethods1_GetUserInfo: array [0..1] of TDSRestParameterMetaData =
  (
    (Name: 'Value'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: ''; Direction: 4; DBXType: 26; TypeName: 'string')
  );

implementation

function TServerMethods1Client.EchoString(Value: string; const ARequestFilter: string): string;
begin
  if FEchoStringCommand = nil then
  begin
    FEchoStringCommand := FConnection.CreateCommand;
    FEchoStringCommand.RequestType := 'GET';
    FEchoStringCommand.Text := 'TServerMethods1.EchoString';
    FEchoStringCommand.Prepare(TServerMethods1_EchoString);
  end;
  FEchoStringCommand.Parameters[0].Value.SetWideString(Value);
  FEchoStringCommand.Execute(ARequestFilter);
  Result := FEchoStringCommand.Parameters[1].Value.GetWideString;
end;

function TServerMethods1Client.ReverseString(Value: string; const ARequestFilter: string): string;
begin
  if FReverseStringCommand = nil then
  begin
    FReverseStringCommand := FConnection.CreateCommand;
    FReverseStringCommand.RequestType := 'GET';
    FReverseStringCommand.Text := 'TServerMethods1.ReverseString';
    FReverseStringCommand.Prepare(TServerMethods1_ReverseString);
  end;
  FReverseStringCommand.Parameters[0].Value.SetWideString(Value);
  FReverseStringCommand.Execute(ARequestFilter);
  Result := FReverseStringCommand.Parameters[1].Value.GetWideString;
end;

function TServerMethods1Client.GetDeptTel(Value: string; const ARequestFilter: string): string;
begin     // http://localhost:8080/datasnap/rest/TServerMethods1/getDeptTel/%7B%22TELNM%22:%22%EC%9E%A5%22%7D
  if FGetDeptTelCommand = nil then
  begin
    FGetDeptTelCommand := FConnection.CreateCommand;
    FGetDeptTelCommand.RequestType := 'GET';
    FGetDeptTelCommand.Text := 'TServerMethods1.GetDeptTel';
    FGetDeptTelCommand.Prepare(TServerMethods1_GetDeptTel);
  end;
  FGetDeptTelCommand.Parameters[0].Value.SetWideString(Value);
  FGetDeptTelCommand.Execute(ARequestFilter);
  Result := FGetDeptTelCommand.Parameters[1].Value.GetWideString;
end;

function TServerMethods1Client.GetUserInfo(Value: string; const ARequestFilter: string): string;
begin
  if FGetUserInfoCommand = nil then
  begin
    FGetUSerInfoCommand := FConnection.CreateCommand;
    FGetUSerInfoCommand.RequestType := 'GET';
    FGetUSerInfoCommand.Text := 'TServerMethods1.GetUserInfo';
    FGetUSerInfoCommand.Prepare(TServerMethods1_GetUserInfo);
  end;
  FGetUSerInfoCommand.Parameters[0].Value.SetWideString(Value);
  FGetUSerInfoCommand.Execute(ARequestFilter);
  Result := FGetUSerInfoCommand.Parameters[1].Value.GetWideString;
end;

constructor TServerMethods1Client.Create(ARestConnection: TDSRestConnection);
begin
  inherited Create(ARestConnection);
end;

constructor TServerMethods1Client.Create(ARestConnection: TDSRestConnection; AInstanceOwner: Boolean);
begin
  inherited Create(ARestConnection, AInstanceOwner);
end;

destructor TServerMethods1Client.Destroy;
begin
  FEchoStringCommand.DisposeOf;
  FReverseStringCommand.DisposeOf;
  FGetDeptTelCommand.DisposeOf;
  inherited;
end;

end.
