unit API.LoggerHelper;

interface

uses
  System.SysUtils,
  System.Classes,
  System.IOUtils,
  System.DateUtils,
  System.Net.HttpClient,
  System.Net.URLClient;

procedure EnsureLogDir(const BaseSubDir: string);
function GenerateLogFileName(const Prefix, Method: string): string;
procedure SaveLogJSON(const BaseSubDir, FilePrefix, Suffix, Content: string; const Method: string);
procedure AppendToLogFile(const BaseSubDir, Text: string);
procedure SaveHttpMeta(const BaseSubDir, FilePrefix: string; const Response: IHTTPResponse; const Method: string);

implementation

function GetBasePath(const BaseSubDir: string): string;
begin
  Result := TPath.Combine(ExtractFilePath(ParamStr(0)), BaseSubDir);
end;

function GetCurrentLogSubDir: string;
begin
  Result := FormatDateTime('yyyy-mm', Now); // Exemplo: "2025-05"
end;

procedure EnsureLogDir(const BaseSubDir: string);
var
  Dir: string;
begin
  Dir := TPath.Combine(GetBasePath(BaseSubDir), GetCurrentLogSubDir);
  if not TDirectory.Exists(Dir) then
    TDirectory.CreateDirectory(Dir);
end;

function GenerateLogFileName(const Prefix, Method: string): string;
begin
  Result := Format('%s_%s_%s', [Prefix, Method, FormatDateTime('yyyy-mm-dd_hh-nn-ss-zzz', Now)]);
end;

procedure SaveLogJSON(const BaseSubDir, FilePrefix, Suffix, Content: string; const Method: string);
var
  FilePath: string;
begin
  EnsureLogDir(BaseSubDir);
  FilePath := TPath.Combine(GetBasePath(BaseSubDir), GetCurrentLogSubDir);
  FilePath := TPath.Combine(FilePath, FilePrefix + '_' + Suffix + '.json');
  TFile.WriteAllText(FilePath, Content, TEncoding.UTF8);
end;

procedure AppendToLogFile(const BaseSubDir, Text: string);
var
  LogPath: string;
  Line: string;
begin
  EnsureLogDir(BaseSubDir);
  LogPath := TPath.Combine(GetBasePath(BaseSubDir), GetCurrentLogSubDir);
  LogPath := TPath.Combine(LogPath, 'aplicacao.log');
  Line := FormatDateTime('[yyyy-mm-dd hh:nn:ss.zzz] ', Now) + Text + sLineBreak;
  TFile.AppendAllText(LogPath, Line);
end;

procedure SaveHttpMeta(const BaseSubDir, FilePrefix: string; const Response: IHTTPResponse; const Method: string);
var
  MetaPath: string;
  MetaContent: string;
  Header: TNameValuePair;
begin
  EnsureLogDir(BaseSubDir);
  MetaPath := TPath.Combine(GetBasePath(BaseSubDir), GetCurrentLogSubDir);
  MetaPath := TPath.Combine(MetaPath, FilePrefix + '_' + Method + '_meta.txt');

  MetaContent := 'Status: ' + Response.StatusCode.ToString + sLineBreak + 'Headers:' + sLineBreak;

  for Header in Response.Headers do
    MetaContent := MetaContent + Header.Name + ': ' + Header.Value + sLineBreak;

  TFile.WriteAllText(MetaPath, MetaContent, TEncoding.UTF8);
end;

end.
