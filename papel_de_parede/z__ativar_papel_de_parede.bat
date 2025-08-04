@echo off
cls

REM Define o caminho completo para a imagem
set "imagePath=%~dp0z_logo_estacao.jpg"

REM Verifica se o arquivo da imagem existe
if not exist "%imagePath%" (
    echo Erro: A imagem "z_logo_estacao.jpg" nao foi encontrada em "%~dp0".
    pause
    exit /b 1
)

REM Define o papel de parede
REM Para Windows 7/8/10/11
reg add "HKCU\Control Panel\Desktop" /v Wallpaper /t REG_SZ /d "%imagePath%" /f
reg add "HKCU\Control Panel\Desktop" /v TileWallpaper /t REG_SZ /d "0" /f
reg add "HKCU\Control Panel\Desktop" /v WallpaperStyle /t REG_SZ /d "2" /f REM 2 = Stretch, 0 = Center, 6 = Fit, 10 = Fill
RUNDLL32.EXE user32.dll,UpdatePerUserSystemParameters

echo Papel de parede "z_logo_estacao.jpg" configurado com sucesso!
