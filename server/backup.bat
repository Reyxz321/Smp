@echo off
title SMP Backup
cd /d "%~dp0"

REM ============================================================
REM   Simple world backup script (run while the server is STOPPED,
REM   or type /save-all and /stop first). Copies world folders
REM   into .\backups\<world>_<timestamp> using robocopy.
REM ============================================================

set "DEST=%~dp0backups"
for /f "tokens=1-3 delims=/" %%a in ("%date%") do set "D=%%c%%a%%b"
set "TS=%D%_%time:~0,2%%time:~3,2%"
set "TS=%TS: =0%"

mkdir "%DEST%" 2>nul

echo Backing up worlds to %DEST% ...
robocopy "%~dp0world"          "%DEST%\world_%TS%"          /E /NFL /NDL /NJH /NJS >nul
robocopy "%~dp0world_nether"   "%DEST%\world_nether_%TS%"   /E /NFL /NDL /NJH /NJS >nul
robocopy "%~dp0world_the_end"  "%DEST%\world_the_end_%TS%"  /E /NFL /NDL /NJH /NJS >nul

echo.
echo Done. Backup saved to: %DEST%\world_%TS%
echo (Also back up the plugins folder + server.properties once in a while!)
pause
