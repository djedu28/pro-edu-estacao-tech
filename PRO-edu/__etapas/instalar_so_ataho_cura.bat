echo off
cd ..

cls||clear

echo Instalando Atalhos

xcopy ".\CURA\*.lnk" "%USERPROFILE%\Desktop\" /e /h /r /y /q

echo Atalhos Instalados com sucesso!
pause
