@echo off
SETLOCAL EnableDelayedExpansion
for /F "tokens=1,2 delims=#" %%a in ('"prompt #$H#$E# & echo on & for %%b in (1) do     rem"') do (
  set "DEL=%%a"
)

ren Umineko5to8.exe Umineko5to8_old.exe > nul
ren 0.utf 0_old.utf > nul

call :colorEcho a0 "Downloading all files. You can close and reopen this at any time, your progress will be saved."
echo.
timeout /t 1 > nul
.\temp\aria2c --file-allocation=none --continue=true --max-resume-failure-tries=5 --check-integrity=true --max-concurrent-downloads=1 -x 8 chiru_patch_1.0.meta4
timeout /t 1 > nul

call :colorEcho a0 "Checking for incomplete downloads..."
echo.
timeout /t 1 > nul
.\temp\aria2c --file-allocation=none --continue=true --max-resume-failure-tries=5 --check-integrity=true --max-concurrent-downloads=1 -x 8 chiru_patch_1.0.meta4
timeout /t 1 > nul

call :colorEcho a0 "Extracting files..."
echo.
timeout /t 1 > nul
.\temp\7za.exe x UminekoChiru-Graphics.7z.001 -aoa
.\temp\7za.exe x UminekoChiru-Voices.zip
timeout /t 1 > nul

call :colorEcho a0 "Deleting useless files..."
echo.
timeout /t 1 > nul
rmdir /S /Q .\temp > nul
del .\UminekoChiru-Graphics.7z.00* > nul
del .\UminekoChiru-Voices.zip > nul
timeout /t 1 > nul

call :colorEcho a0 "All done, finishing in three seconds..."
timeout /t 3 > nul

exit
:colorEcho
echo off
<nul set /p ".=%DEL%" > "%~2"
findstr /v /a:%1 /R "^$" "%~2" nul
del "%~2" > nul 2>&1i