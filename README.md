# Packer Repo

## Description: 

This Repository is for packer template files created for use with the ABRS Americas Team VMware Lab, but can be tailored to any Lab.

## Requirements:

1. Download the ADK: https://learn.microsoft.com/en-us/windows-hardware/get-started/adk-install
2. Set your environment variables

**Add this to your paths:** C:\Program Files (x86)\Windows Kits\10\Assessment and Deployment Kit\Deployment Tools\amd64\Oscdimg

**Add to your variables:**

Name: oscdimg 
Value: C:\Program Files (x86)\Windows Kits\10\Assessment and Deployment Kit\Deployment Tools\amd64\Oscdimg\oscdimg.exe

3. Update the Pkvars file you are deploying with your vSphere Information, you may need to upload an iso and point the template as well.

## How to Build:
packer build -var-file ".\<Folder>\<pkvars file>" .\<template directory\

EX:
packer build -var-file ".\Ubuntu2204\ubuntu.pkrvars.hcl" .\Ubuntu2204\
