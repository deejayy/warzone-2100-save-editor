{$O-}
unit mainunit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, ComCtrls, ExtCtrls, StdCtrls, CheckLst, procs, defs;

type
  tmainform = class(TForm)
    MainMenu1: TMainMenu;
    filemenu: TMenuItem;
    quit: TMenuItem;
    helpmenu: TMenuItem;
    about: TMenuItem;
    sep01: TMenuItem;
    csgd: TMenuItem;
    sep02: TMenuItem;
    opens: TMenuItem;
    closes: TMenuItem;
    Options1: TMenuItem;
    Preferences1: TMenuItem;
    sb: TStatusBar;
    Panel1: TPanel;
    Button1: TButton;
    Button2: TButton;
    CheckListBox1: TCheckListBox;
    procedure quitClick(Sender: TObject);
    procedure csgdClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure opensClick(Sender: TObject);
    procedure closesClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    procedure status(s: string);
    procedure complist(path: string);
    { Private declarations }
  public
    { Public declarations }
    clb: array[CL_BODY..CL_WEAPON] of tchecklistbox;
  end;

var
  mainform: tmainform;

implementation

{$R *.dfm}

var st: settings;

procedure tmainform.status( s: string );
begin
  sb.panels[0].text := s;
  sb.panels[1].text := 'Current save: ' + st.savegame;
  log( st.logfile, s );
end;

procedure tmainform.quitClick(Sender: TObject);
begin
  close;
  status( 'Quit' );
end;

procedure tmainform.csgdClick(Sender: TObject);
begin
  browseforfolder( mainform.handle, st.path, 'Select the warzone savegames'' directory'#13#10'Usually \warzone2100 installdir\savegame' );
  savesettings( st.inifile, st );
  status( 'Changed savegame folder' );
end;

procedure tmainform.FormCreate(Sender: TObject);
var i: integer;
    tts: ttabsheet;
begin
  st.inifile := extractfilepath( paramstr( 0 ) ) + 'settings.ini';
  loadsettings( st.inifile, st );
  status( '------------ start ------------ ' + datetostr( now ) );
  status( 'Settings loaded' );
end;

procedure tmainform.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  savesettings( st.inifile, st );
  status( 'Settings saved' );
end;

procedure tmainform.opensClick(Sender: TObject);
begin
  st.savegame := st.path;
  browseforfolder( mainform.handle, st.savegame, 'Select a savegame' );
  savesettings( st.inifile, st );
  closes.enabled := st.path <> st.savegame;
  status( 'Savegame opened' );
end;

procedure tmainform.closesClick(Sender: TObject);
begin
  st.savegame := '';
  savesettings( st.inifile, st );
  closes.enabled := false;
  status( 'Savegame closed' );
end;

procedure tmainform.complist( path: string );
var f: file of byte;
    buf: array of byte;
    cnt, i: integer;
    s: string;
begin
  assignfile( f, path + '\CompL.bjo' );
  if fileexists( path + '\CompL.bjo' ) then begin
    reset( f );
    setlength( buf, filesize( f ) + 1 );
    fillchar( buf[0], filesize( f ) + 1, 0 );
    blockread( f, buf[0], filesize( f ) );
    closefile( f );
    if bufgetstr( buf, 0, 4 ) = 'cmpl!' then begin
      cnt := bufgetint( buf, 8 );
      status( inttostr( cnt ) + ' components in file' );
      for i := 0 to cnt do begin
        s := bufgetstr( buf, 12+i*63, 12+i*63+60 );
        clb.Items.Add( 'player ' + inttostr(buf[12+i*63+62]) + ' - ' + s );
        if buf[12+i*63+61] = 01 then clb.Checked[clb.Count-1] := true;
        Application.ProcessMessages;
      end;
    end else begin
      status( 'Not a valid component list file' );
    end;
  end else begin
    status( path + '\CompL.bjo not found' ); 
  end;
end;

procedure tmainform.Button1Click(Sender: TObject);
begin
  complist( st.savegame ); 
end;

end.




