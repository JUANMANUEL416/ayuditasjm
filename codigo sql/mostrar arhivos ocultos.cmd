attrib -s -h *.*

dir /ad /b> a.txt

FOR /F "delims==" %%i in (a.txt) do ( attrib -s -h "%%i" )

del a.txt

pause 