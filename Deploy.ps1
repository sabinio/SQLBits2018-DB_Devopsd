param(
    $Server = "LOCALHOST",
    $DatabaseName = "WideWorldImporters-LOCALDEV",
	$DBVersion = "0"
)
  
# Statics
$Dacpac = "bin\debug\WideWorldImporters.dacpac"
$PubProfile = "WideWorldImporters.publish.xml"
$libFolder = "bin\lib"  # Note we should exclude this folder in gitignore
$NugetUrl = "https://dist.nuget.org/win-x86-commandline/latest/nuget.exe"

# cd to the folder this script is in
Set-Location $PSScriptRoot

# Validate
if ((Test-Path $Dacpac) -eq $false){
    throw "dacpac not found - have you built your project?"}
if ((Test-Path $PubProfile) -eq $false){
    throw "PublishProfile.xml not found - it must be named $PubProfile and saved to the root of your project with this script"}

# If the lib folder does not exist create it
if (!(Test-Path $libFolder -PathType Container)){
	New-Item -Path $libFolder -ItemType Directory -Force | Out-Null
}

# Download nuget.exe if required
$libFolder = Resolve-Path $libFolder
$nugetExe = "$libFolder\nuget.exe"
if (!(Test-Path $nugetExe)){
	$wc = New-Object Net.WebClient
	$wc.DownloadFile($NugetUrl, $nugetExe)
}

# Download SQL Data Tools if required
$SQLPackage = @(Get-ChildItem -Path $libFolder -Filter "SQLPackage.exe" -Recurse)[0].FullName  # This searches the lib folder for SQLPackage.exe and returns the file path (if found)
If (!$SQLPackage){
	$arguments = "install","Microsoft.Data.Tools.Msbuild","-ExcludeVersion","-OutputDirectory","$libFolder"
    &$nugetExe $arguments
	$SQLPackage = @(Get-ChildItem -Path $libFolder -Filter "SQLPackage.exe" -Recurse)[0].FullName
}

# Finally deploy database using SQLPackage.exe
# Added the passing in of Environment Name
$arguments = "/Action:Publish", "/TargetServerName:$Server", "/TargetDatabaseName:$DatabaseName", "/SourceFile:$Dacpac", "/Profile:$PubProfile", "/Variables:DBVersion=$DBVersion"
&$SQLPackage $arguments






