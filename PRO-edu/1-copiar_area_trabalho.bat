echo off

cls||clear
echo Copiando arquivos para a area de trabalho
xcopy ".\" "%USERPROFILE%\Desktop\est\" /e /h /r /y

echo Arquivos copiados com sucesso!
pause
