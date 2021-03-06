unit LuaCrypto;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, {$ifdef luajit}lua{$else}{$ifdef lua54}lua54{$else}lua53{$endif}{$endif}, BaseCrypto;

procedure luaCryptoRegister(L: Plua_State);

implementation

uses
  LuaUtils;

function crypto_hextostr(L: Plua_State): Integer; cdecl;
begin
  lua_pushstring(L, HexToStr(luaGetString(L, 1)));
  Result := 1;
end;

function crypto_strtohexstr(L: Plua_State): Integer; cdecl;
begin
  lua_pushstring(L, StrToHexStr(luaGetString(L, 1)));
  Result := 1;
end;

function crypto_md5hex(L: Plua_State): Integer; cdecl;
begin
  lua_pushstring(L, MD5Hex(luaGetString(L, 1)));
  Result := 1;
end;

function crypto_aesdecryptcbc(L: Plua_State): Integer; cdecl;
begin
  lua_pushstring(L, AESDecryptCBC(luaGetString(L, 1), luaGetString(L, 2), luaGetString(L, 3)));
  Result := 1;
end;

function crypto_AESDecryptCBCSHA256Base64Pkcs7(L: Plua_State): Integer; cdecl;
begin
  lua_pushstring(L, AESDecryptCBCSHA256Base64Pkcs7(luaGetString(L, 1), luaGetString(L, 2), luaGetString(L, 3)));
  Result := 1;
end;

procedure luaCryptoRegister(L: Plua_State);
begin
  luaPushFunctionGlobal(L, 'HexToStr', @crypto_hextostr);
  luaPushFunctionGlobal(L, 'StrToHexStr', @crypto_strtohexstr);
  luaPushFunctionGlobal(L, 'MD5Hex', @crypto_md5hex);
  luaPushFunctionGlobal(L, 'AESDecryptCBC', @crypto_aesdecryptcbc);
  luaPushFunctionGlobal(L, 'AESDecryptCBCSHA256Base64Pkcs7', @crypto_AESDecryptCBCSHA256Base64Pkcs7);
end;

end.

