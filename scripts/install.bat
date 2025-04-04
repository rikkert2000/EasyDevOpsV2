@echo off
SETLOCAL EnableDelayedExpansion

REM Controleren op de aanwezigheid van Chocolatey
where choco >nul 2>&1
if %errorlevel% neq 0 (
    echo Installing Chocolatey...
    powershell -Command "Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))"
)

REM Definieer paden en bestandsnamen
set DOTNET_SDK_URL=https://download.visualstudio.microsoft.com/download/pr/dotnet-sdk-8.0.100-win-x64.zip
set DOTNET_SDK_ZIP=dotnet-sdk.zip
set DOTNET_INSTALL_DIR=%USERPROFILE%\dotnet

REM Maak een directory voor .NET SDK en verplaats daarheen
if not exist "%DOTNET_INSTALL_DIR%" mkdir "%DOTNET_INSTALL_DIR%"
cd "%DOTNET_INSTALL_DIR%"

REM Download de .NET SDK
echo Downloading .NET SDK...
powershell -command "try { Invoke-WebRequest -Uri '%DOTNET_SDK_URL%' -OutFile '%DOTNET_SDK_ZIP%' } catch { Write-Host $_.Exception.Message; exit 1 }"

REM Pak het .NET SDK archief uit
echo Extracting .NET SDK...
if exist "%DOTNET_SDK_ZIP%" (
    powershell -command "try { Expand-Archive -Path '%DOTNET_SDK_ZIP%' -DestinationPath '%DOTNET_INSTALL_DIR%' -Force } catch { Write-Host $_.Exception.Message; exit 1 }"
) else (
    echo Failed to download .NET SDK archive.
    exit 1
)

REM Stel omgevingsvariabelen in voor de huidige sessie en toekomstige sessies
set DOTNET_ROOT="%DOTNET_INSTALL_DIR%"
set PATH="%DOTNET_INSTALL_DIR%;%PATH%"
setx DOTNET_ROOT "%DOTNET_INSTALL_DIR%"
setx PATH "%DOTNET_INSTALL_DIR%;%PATH%"

REM Installatie van Git
echo Installing Git...
choco install git -y

REM Kloon de repository, verwijder eerst een bestaande map indien aanwezig
if exist "EasyDevOpsV2" (
    echo Removing existing EasyDevOpsV2 directory...
    rmdir /s /q EasyDevOpsV2
)
echo Cloning repository...
git clone https://github.com/Rikkert2000/EasyDevOpsV2.git
cd EasyDevOpsV2\frontend

REM Run de .NET frontend applicatie
echo Running .NET application...
dotnet restore
dotnet build
dotnet run

echo Installation and setup complete!
pause
ENDLOCAL
