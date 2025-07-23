@echo off
setlocal enabledelayedexpansion

for /d %%d in (*) do (
    set "fullname=%%~nxd"                 
    for /f "tokens=1 delims=_" %%a in ("!fullname!") do (
        set "nombre=%%a"                
        echo Carpeta: %%d → Nombre extraido: !nombre!
		echo estoy buscascando: "%%d\!nombre!_CUV.json"
	 ren "%%d\!nombre!_CUV.json" "900986941_!nombre!_CUV.json"
	 ren "%%d\!nombre!.json" "900986941_!nombre!_RIPS.json"
	
    )
	
)

endlocal

pause