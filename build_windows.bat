@echo off
cd /d "%~dp0"
if not exist Logs mkdir Logs

echo Deleting old build...
if exist Builds\Test rmdir /s /q Builds\Test

start "" /wait "C:\Program Files\Unity\Hub\Editor\6000.3.20f1\Editor\Unity.exe" -batchmode -nographics -quit -projectPath "C:\Unity\Test_Unity\UnityProject" -buildTarget Win64 -executeMethod ExpeditionCamp.EditorTools.BuildScript.BuildForTest -logFile "%~dp0Logs\build_windows.log"

if errorlevel 1 (
  echo BUILD FAILED
  powershell -NoProfile -Command "Get-Content Logs\build_windows.log -Tail 30"
  exit /b 1
)

if exist Builds\Test\ExpeditionCamp.exe (
  echo BUILD SUCCEEDED: Builds\Test\ExpeditionCamp.exe
) else (
  echo BUILD FAILED: exe not found
  exit /b 1
)
