@echo off
SETLOCAL EnableDelayedExpansion

REM Controleer of Chocolatey geïnstalleerd is
where choco >nul 2>&1
if %errorlevel% neq 0 (
    echo Chocolatey is not installed. Installing now...
    powershell -Command "Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))"
) else (
    echo Chocolatey is already installed.
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
    echo Failed to download .NET SDK archive. Check the download URL and internet connection.
    exit 1
)

REM Stel omgevingsvariabelen in
set DOTNET_ROOT="%DOTNET_INSTALL_DIR%"
set PATH="%DOTNET_INSTALL_DIR%;%PATH%"
setx DOTNET_ROOT "%DOTNET_INSTALL_DIR%"
setx PATH "%DOTNET_INSTALL_DIR%;%PATH%"

REM Installatie
