@echo off

REM Installeer .NET SDK 8
REM Je zou .NET SDK 8 moeten downloaden van de officiële website of zorgen dat het geïnstalleerd is via een package manager zoals Chocolatey.

cd %USERPROFILE%
mkdir dotnet
curl -o dotnet-sdk.zip https://download.visualstudio.microsoft.com/download/pr/dotnet-sdk-8.0.100-win-x64.zip
tar -xf dotnet-sdk.zip -C %USERPROFILE%\dotnet

set DOTNET_ROOT=%USERPROFILE%\dotnet
set PATH=%USERPROFILE%\dotnet;%PATH%

REM Installeer Git
REM Git kan worden geïnstalleerd via Chocolatey (choco install git -y) of door een vooraf gedownload installer uit te voeren.

REM Clone de repository
git clone https://github.com/Rikkert2000/EasyDevOpsV2.git
cd EasyDevOpsV2\frontend

REM Run de .NET frontend applicatie
dotnet run
