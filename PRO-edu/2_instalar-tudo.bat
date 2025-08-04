echo off

cls||clear

echo Instalando Atalhos

xcopy ".\InovOnline_vercel_app\" "%USERPROFILE%\InovOnline_vercel_app\" /e /h /r /y /q
xcopy ".\InovOnline_vercel_app\at\*" "%USERPROFILE%\Desktop\" /e /h /r /y /q

cls||clear
echo Atalhos Instalados com sucesso!

echo Instalar programas

echo arduino E driver
.\ARDUINO\arduino.exe
.\ARDUINO\CH341SER_35\SETUP.EXE

echo Cura
.\3D\Ultimaker-Cura.exe

echo Programas permitidos - iniciado instalação com sucesso!
pause
