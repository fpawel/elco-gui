unit exn;

interface

uses sysutils;

implementation

uses Winapi.Windows, forms;

procedure SaveExceptionToFile(E: Exception);
var
    FErrorLog, FStackTrace: TextFile;
    ErrorLogFileName: string;
    StackTraceFileName: string;
    StackTraceFileDir: string;
    StackTraceFileName1: string;
    time_now: TDAteTime;
begin
    time_now := now;
    StackTraceFileDir := ExtractFileDir(paramstr(0)) + '\stack_trace';

    if not ForceDirectories(StackTraceFileDir) then
    begin
        MessageBox(Application.handle, 'Не удалось создать каталог stack_trace',
          'Критический сбой', MB_OK or MB_ICONERROR);
        exit;
    end;

    StackTraceFileName1 := formatDateTime('dd_mm_yyyy_hh_nn_ss_zzz', time_now) +
      '.stacktrace';
    StackTraceFileName := StackTraceFileDir + '\' + StackTraceFileName1;
    ErrorLogFileName := ExtractFileDir(paramstr(0)) + '\errors.log';

    AssignFile(FErrorLog, ErrorLogFileName, CP_UTF8);
    if FileExists(ErrorLogFileName) then
        Append(FErrorLog)
    else
        Rewrite(FErrorLog);
    Writeln(FErrorLog, formatDateTime('dd.mm.yyyy.hh:nn:ss.zzz', time_now),
      'MSK ', E.ClassName, ' ', stringreplace(Trim(E.Message), #13, ' ',
      [rfReplaceAll, rfIgnoreCase]));
    Flush(FErrorLog);
    CloseFile(FErrorLog);

    AssignFile(FStackTrace, StackTraceFileName, CP_UTF8);
    Rewrite(FStackTrace);
    Writeln(FStackTrace, E.ClassName);
    Writeln(FStackTrace, E.Message);
    Writeln(FStackTrace, E.StackTrace);
    Flush(FStackTrace);
    CloseFile(FStackTrace);


    Application.MessageBox(PChar(E.Message), 'Анкат: произошла ошибка',
      MB_OK or MB_ICONERROR);


end;

end.
