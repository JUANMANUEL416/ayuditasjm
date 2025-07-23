@echo off
setlocal enabledelayedexpansion
set "nombre_fijo=900986941"

for /d %%d in (*) do (
    cd "%%d"
    for /f "tokens=1 delims=_" %%a in ("%%~nd") do (
        "C:\Program Files\7-Zip\7z.exe" a -tzip "..\%nombre_fijo%_%%a.zip" "*.*" -r- -mx5
        echo ZIP creado: "%nombre_fijo%_%%a.zip"
    )
    cd..
)
pause