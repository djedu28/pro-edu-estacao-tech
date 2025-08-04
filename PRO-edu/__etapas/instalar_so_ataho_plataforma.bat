echo off
cd ..

cls||clear

echo Instalando Atalhos

xcopy ".\InovOnline_vercel_app\" "%USERPROFILE%\InovOnline_vercel_app\" /e /h /r /y /q
xcopy ".\InovOnline_vercel_app\at\*" "%USERPROFILE%\Desktop\" /e /h /r /y /q

echo Atalhos Instalados com sucesso!
pause
