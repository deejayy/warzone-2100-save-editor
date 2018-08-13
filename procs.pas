{$O-}
unit procs;

interface

uses shlobj, activex, ole2, comobj, windows, defs, inifiles, sysutils;

function BrowseForFolder(Handle: HWND; var FolderName: String; const ATitle: String): Boolean;

procedure loadsettings( fname: string; var st: settings );
procedure savesettings( fname: string; st: settings );

procedure log( fname: string; s: string );

function bufgetstr( var buf: array of byte; bfrom, bto: longword ): string;
function bufgetint( var buf: array of byte; bfrom: longword ): longword;

implementation

(*                                         *
 *  Browsing in folders with a winapi call *
 *                                         *)

function BrowseCallbackProc(wnd: HWND; Msg: DWORD; lP: LPARAM; lpData: LPARAM): Integer; stdcall;
begin
  if Msg=BFFM_INITIALIZED then begin
    if (lpData>0) and (Length(PChar(lpData))>1) then
      SendMessage(wnd, BFFM_SETSELECTION, ord(TRUE), lpData);
  end;
  Result:=0;
end;

function BrowseForFolder(Handle: HWND; var FolderName: String; const ATitle: String): Boolean;
const
  BIF_NEWDIALOGSTYLE = $0040;
var
  TempPath: array[0..MAX_PATH] of char;
  DisplayName: array[0..MAX_PATH] of char;
  BrowseInfo: TBrowseInfo;
  ItemID: PItemIDList;
  Malloc: activex.IMAlloc;
begin
  FillChar(BrowseInfo, sizeof(BrowseInfo), 0);
  BrowseInfo.hwndOwner := Handle;
  BrowseInfo.pszDisplayName := DisplayName;
  BrowseInfo.lpszTitle := PChar(ATitle);
  BrowseInfo.ulFlags := BIF_RETURNONLYFSDIRS or BIF_NEWDIALOGSTYLE;
  BrowseInfo.lpfn:=BrowseCallbackProc;
  BrowseInfo.lParam:=Integer(PChar(FolderName));
  ItemID := SHBrowseForFolder(BrowseInfo);
  Result := Assigned(ItemId);
  if Result then begin
    Result:=SHGetPathFromIDList(ItemID, TempPath);
    FolderName := TempPath;
    OleCheck(SHGetMalloc(Malloc));
    Malloc.Free(ItemID);
  end;
end;


(*                         *
 *  Save and load settings *
 *                         *)

procedure loadsettings( fname: string; var st: settings );
var ini: tinifile;
begin
  ini := tinifile.create( fname );
  st.path := ini.readstring( 'Settings', 'SavegamePath', extractfilepath( paramstr( 0 ) ) );
  st.savegame := ini.readstring( 'Settings', 'CurrentSavegame', '' );
  st.logfile := ini.readstring( 'Settings', 'LogFile', 'program.log' );
  ini.destroy;
end;

procedure savesettings( fname: string; st: settings );
var ini: tinifile;
begin
  ini := tinifile.create( fname );
  ini.writestring( 'Settings', 'Savegamepath', st.path );
  ini.writestring( 'Settings', 'CurrentSavegame', st.savegame );
  ini.writestring( 'Settings', 'LogFile', st.logfile );
  ini.destroy;
end;

(*          *
 *  Logging *
 *          *)

procedure log( fname: string; s: string );
var f: textfile;
begin
  assignfile( f, fname );
  if fileexists( fname ) then append( f ) else rewrite( f );
  writeln( f, format( '[%s] - %s', [timetostr( now ), s] ) );
  closefile( f );
end;

(*                        *
 *  Get data from buffers *
 *                        *)

function bufgetstr( var buf: array of byte; bfrom, bto: longword ): string;
var i: longword;
begin
  result := '';
  for i := bfrom to bto do
    result := result + chr( buf[i] );
  result := pchar( result );
end;

function bufgetint( var buf: array of byte; bfrom: longword ): longword;
begin
  result := buf[bfrom] + buf[bfrom+1]*$100 + buf[bfrom+2]*$10000 + buf[bfrom+3]*$1000000;
end;


end.
