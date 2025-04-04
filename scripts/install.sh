#!/bin/bash

# Installeer .NET SDK 8
wget https://download.visualstudio.microsoft.com/download/pr/dotnet-sdk-8.0.100-linux-x64.tar.gz -O dotnet-sdk.tar.gz
mkdir -p $HOME/dotnet && tar zxf dotnet-sdk.tar.gz -C $HOME/dotnet
export DOTNET_ROOT=$HOME/dotnet
export PATH=$HOME/dotnet:$PATH

# Installeer Git
sudo apt update && sudo apt install -y git

# Clone de repository
git clone https://github.com/Rikkert2000/EasyDevOpsV2.git
cd EasyDevOps/frontend

# Run de .NET frontend applicatie
dotnet run
