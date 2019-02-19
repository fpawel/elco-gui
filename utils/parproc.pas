unit parproc;

interface

function GetParentProcessName(): String;

function AttachConsole(dwProcessID: Integer): Boolean; stdcall;
  external 'kernel32.dll';
function FreeConsole(): Boolean; stdcall; external 'kernel32.dll';

implementation

uses winapi.windows, TlHelp32, PsAPI;



function GetParentProcessName(): String;
const
    BufferSize = 4096;
var
    HandleSnapShot: THandle;
    EntryParentProc: TProcessEntry32;
    CurrentProcessId: THandle;
    HandleParentProc: THandle;
    ParentProcessId: THandle;
    ParentProcessFound: Boolean;
    ParentProcPath: String;
begin
    ParentProcessFound := False;
    HandleSnapShot := CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);
    if HandleSnapShot <> INVALID_HANDLE_VALUE then
    begin
        EntryParentProc.dwSize := SizeOf(EntryParentProc);
        if Process32First(HandleSnapShot, EntryParentProc) then
        begin
            CurrentProcessId := GetCurrentProcessId();
            repeat
                if EntryParentProc.th32ProcessID = CurrentProcessId then
                begin
                    ParentProcessId := EntryParentProc.th32ParentProcessID;
                    HandleParentProc := OpenProcess(PROCESS_QUERY_INFORMATION or
                      PROCESS_VM_READ, False, ParentProcessId);
                    if HandleParentProc <> 0 then
                    begin
                        ParentProcessFound := True;
                        SetLength(ParentProcPath, BufferSize);
                        GetModuleFileNameEx(HandleParentProc, 0,
                          PChar(ParentProcPath), BufferSize);
                        ParentProcPath := PChar(ParentProcPath);
                        CloseHandle(HandleParentProc);
                    end;
                    Break;
                end;
            until not Process32Next(HandleSnapShot, EntryParentProc);
        end;
        CloseHandle(HandleSnapShot);
    end;
    if ParentProcessFound then
        Result := ParentProcPath
    else
        Result := '';
end;

end.
