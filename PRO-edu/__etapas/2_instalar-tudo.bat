echo off
cd ..

cls||clear

echo Instalando Atalhos

xcopy ".\InovOnline_vercel_app\" "%USERPROFILE%\InovOnline_vercel_app\" /e /h /r /y /q
xcopy ".\InovOnline_vercel_app\at\*" "%USERPROFILE%\Desktop\" /e /h /r /y /q

echo Atalhos Instalados com sucesso!

echo Instalar programas

@REM echo arduino E driver
powershell -ExecutionPolicy Bypass -File "./2-a_instalar-arduino.ps1"

@REM # atalhos da plataforma
cmd /C ./2-b_instalar-ataho-plataforma.bat

@REM echo Cura
powershell -ExecutionPolicy Bypass -File "./2-c_instalar-cura.ps1"

echo Programas permitidos - iniciado instalação com sucesso!
pause
