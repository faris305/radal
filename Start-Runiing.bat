@echo off
setlocal

:: Set tanggal awal (format YYYYMMDD)
set "start_date=20240725"

:: Ambil tanggal hari ini
for /f "tokens=2 delims==" %%i in ('"wmic os get localdatetime /value"') do set "today=%%i"

:: Potong bagian tanggal dari nilai hari ini (YYYYMMDD)
set "today=%today:~0,8%"

:: Hitung selisih hari
call :DateDiff %start_date% %today% days_elapsed

set max_days=30

if %days_elapsed% gtr %max_days% (
    echo Masa aktif telah berakhir.
    pause
    exit /b
)

cd %~dp0
echo Running the radar
echo.
echo start package.json

call node app.js

pause
exit /b

:DateDiff
setlocal
set "start=%1"
set "end=%2"
set /a "start_yyyy=%start:~0,4%, start_mm=%start:~4,2%, start_dd=%start:~6,2%"
set /a "end_yyyy=%end:~0,4%, end_mm=%end:~4,2%, end_dd=%end:~6,2%"

set /a "start_date=(start_yyyy-1600)*365 + (start_yyyy-1600)/4 - (start_yyyy-1600)/100 + (start_yyyy-1600)/400 + (start_mm-1)*3055/100 + start_dd - 32075"
set /a "end_date=(end_yyyy-1600)*365 + (end_yyyy-1600)/4 - (end_yyyy-1600)/100 + (end_yyyy-1600)/400 + (end_mm-1)*3055/100 + end_dd - 32075"
set /a "days_diff=end_date - start_date"
(endlocal & set "%~3=%days_diff%")
exit /b

