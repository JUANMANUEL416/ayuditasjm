@echo off
for /d %%d in (*) do (
    if exist "%%d\*.xml" (
        del "%%d\*.xml" /f /q
    )
    if exist "%%d\*.pdf" (
        del "%%d\*.pdf" /f /q
    )

)