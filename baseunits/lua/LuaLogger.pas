unit LuaLogger;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, {$ifdef luajit}lua{$else}{$ifdef lua54}lua54{$else}lua53{$endif}{$endif};

procedure luaLoggerRegister(L: Plua_State);

implementation

uses
  MultiLog, LuaClass, LuaUtils;

function logger_send(L: Plua_State): Integer; cdecl;
begin
  Result := 0;
  Logger.Send(luaGetString(L, 1));
end;

function logger_sendwarning(L: Plua_State): Integer; cdecl;
begin
  Result := 0;
  Logger.SendWarning(luaGetString(L, 1));
end;

function logger_senderror(L: Plua_State): Integer; cdecl;
begin
  Result := 0;
  Logger.SendError(luaGetString(L, 1));
end;

const
  methods: packed array [0..3] of luaL_Reg = (
    (name: 'Send'; func: @logger_send),
    (name: 'SendWarning'; func: @logger_sendwarning),
    (name: 'SendError'; func: @logger_senderror),
    (name: nil; func: nil)
    );

procedure luaLoggerRegister(L: Plua_State);
begin
  luaClassNewLib(L, 'LOGGER', methods);
end;

end.
