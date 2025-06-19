program DelphiRestJsonOptional;

uses
  madExcept,
  madLinkDisAsm,
  madListHardware,
  madListProcesses,
  madListModules,
  Vcl.Forms,
  Main.Demo in 'Main.Demo.pas' {MainDemo},
  Model.Lancamento in 'Model.Lancamento.pas',
  API.Types.Optional in 'API.Types.Optional.pas',
  Service.JSONUtils in 'Service.JSONUtils.pas',
  API.Abstract.Service in 'API.Abstract.Service.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMainDemo, FormMainDemo);
  Application.Run;
end.
