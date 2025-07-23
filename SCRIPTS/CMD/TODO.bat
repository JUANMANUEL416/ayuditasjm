@echo off
setlocal enabledelayedexpansion

:: =============================================
:: CONFIGURACIONES INICIALES
:: =============================================
set "nombre_fijo=900986941"
set "ruta_7zip=C:\Program Files\7-Zip\7z.exe"

:: =============================================
:: PASO 1: Extraer archivos ZIP
:: =============================================
echo.
echo [PASO 1] Extrayendo archivos ZIP...
echo.

for %%F in (*.zip) do (
    echo Extrayendo: %%~nF.zip
    if not exist "%%~nF" mkdir "%%~nF"
    "%ruta_7zip%" x "%%F" -o"%%~nF" -y
)
echo Extraccion completada.
echo.

:: =============================================
:: PASO 2: Eliminar archivos XML y PDF
:: =============================================
echo [PASO 2] Limpiando archivos temporales...
echo.

for /d %%d in (*) do (
    if exist "%%d\*.xml" (
        echo Eliminando XML en: %%d
        del "%%d\*.xml" /f /q
    )
    if exist "%%d\*.pdf" (
        echo Eliminando PDF en: %%d
        del "%%d\*.pdf" /f /q
    )
)
echo Limpieza completada.
echo.

:: =============================================
:: PASO 3: Renombrar archivos JSON
:: =============================================
echo [PASO 3] Renombrando archivos JSON...
echo.

for /d %%d in (*) do (
    set "fullname=%%~nxd"
    for /f "tokens=1 delims=_" %%a in ("!fullname!") do (
        set "nombre=%%a"
        echo Procesando carpeta: %%d
        
        :: Renombrar _CUV.json
        if exist "%%d\!nombre!_CUV.json" (
            echo Renombrando: !nombre!_CUV.json
            ren "%%d\!nombre!_CUV.json" "900986941_!nombre!_CUV.json"
        ) else (
            echo No se encontro: !nombre!_CUV.json
        )
        
        :: Renombrar .json (RIPS)
        if exist "%%d\!nombre!.json" (
            echo Renombrando: !nombre!.json
            ren "%%d\!nombre!.json" "900986941_!nombre!_RIPS.json"
        ) else (
            echo No se encontro: !nombre!.json
        )
    )
    echo.
)
echo Renombrado completado.
echo.

:: =============================================
:: PASO 4: Comprimir carpetas procesadas
:: =============================================
echo [PASO 4] Comprimiendo carpetas procesadas...
echo.

for /d %%d in (*) do (
    cd "%%d"
    for /f "tokens=1 delims=_" %%a in ("%%~nd") do (
        echo Comprimiendo: %%d
        "%ruta_7zip%" a -tzip "..\%nombre_fijo%_%%a.zip" "*.*" -r- -mx5
        echo Archivo creado: %nombre_fijo%_%%a.zip
    )
    cd..
    echo.
)
echo Compresion finalizada.
echo.

:: =============================================
:: FINALIZACION
:: =============================================
echo Proceso completo. Presione cualquier tecla para salir...
pause