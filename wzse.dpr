program wzse;

uses
  Forms,
  mainunit in 'mainunit.pas' {mainform},
  procs in 'procs.pas',
  defs in 'defs.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Warzone savegame editor';
  Application.CreateForm(Tmainform, mainform);
  Application.Run;
end.
