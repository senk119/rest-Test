unit EntTypes;

interface

uses System.JSON.Types, System.JSON.Serializers;

type


  TEntResp = record
    rCode : integer;
    rMsg : string;
  end;

  TDeptTel = record
    GUBN_NM   : String;
    DEPT_NM   : String;
    TEL_NM    : String;
    TEL       : String;
    TEL2      : String;
    TEL_PLACE : String;
    TEL_TYPE  : String;
    PM_GUBN   : String;
    TEL_NM2   : String;
    SORT      : String;
    ETC       : String;
  end;
  TDeptTelResp = record
    rc : Integer;
    deptTel : Tarray<TDeptTel>;
  end;
  Tcs_d_03_cctelmt = TDeptTelResp;

  TUserInfo = record
     HOSPI_CLS
   , PASSWD
   , DEPT_CD
   , TRT_DEPT
   , NM
   , TRDPNM
   , SLIP
   , GRADE     : string;
  end;
  TUserInfoResp = record
    rc : Integer;
    userInfo : TArray<TUserInfo>;
  end;
  Tcs_d_03_user_info = TUserInfoResp;

const
// Dept Tel  ColmunIndex
  CI_DT_GUBN_NM   = 0;
  CI_DT_DEPT_NM   = CI_DT_GUBN_NM   + 1;
  CI_DT_TEL_NM    = CI_DT_DEPT_NM   + 1;
  CI_DT_TEL       = CI_DT_TEL_NM    + 1;
  CI_DT_TEL2      = CI_DT_TEL       + 1;
  CI_DT_TEL_PLACE = CI_DT_TEL2      + 1;
  CI_DT_TEL_TYPE  = CI_DT_TEL_PLACE + 1;
  CI_DT_PM_GUBN   = CI_DT_TEL_TYPE  + 1;
  CI_DT_TEL_NM2   = CI_DT_PM_GUBN   + 1;
  CI_DT_SORT      = CI_DT_TEL_NM2   + 1;
  CI_DT_ETC       = CI_DT_SORT      + 1;

function ReadJsonBySerializer1(aJson : string) : Tcs_d_03_cctelmt;
function ReadJsonBySerializerUserInfo(aJson : string) : TUserInfoResp;


implementation

function ReadJsonBySerializer1(aJson : string) : Tcs_d_03_cctelmt;
begin
  var S := TJsonSerializer.Create;
  try
    // JSON의 내용 읽어와서 구조체에 Assign
    var aRec  := S.Deserialize<Tcs_d_03_cctelmt>(aJson);
    result := aRec;
    {  // 데이터 사용
    Writeln(aRec.foo);
    Writeln(aRec.bar);
    for var V in aRec.baz do
      Writeln(V);
    }
  finally
    S.DisposeOf;
  end;
end;

function ReadJsonBySerializerUserInfo(aJson : string) : TUserInfoResp;
begin
  var S := TJsonSerializer.Create;
  try
    result  := S.Deserialize<TUserInfoResp>(aJson);
  finally
    S.DisposeOf;
  end;
end;



end.
