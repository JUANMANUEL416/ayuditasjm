@echo off
for %%F in (*.zip) do (
    mkdir "%%~nF"
    7z x "%%F" -o"%%~nF"
)