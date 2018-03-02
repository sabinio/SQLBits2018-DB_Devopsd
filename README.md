# SQLBits2018-DB_Devopsd
Scripts used in the SQLBits 2018 session "How to get your DB DevOps'd"


Examples of how these were used in the Demos:

Deploy.ps1 and RunTests.ps1 where copied into the root of the project structure.
Tests.ps1 was copied into a folder called Tests inside the project.

The ps1 files were included in the artefacts and then executed using these commands:

Deploy.ps1: -Server LOCALHOST -DatabaseName "WideWorldImporters-QA" -DBVersion $(Release.ReleaseName)
RunTests.ps1: -Server LOCALHOST -Database WideWorldImporters-UnitTest -Debug $false 

After the tests are run a "publish test results" task was used in the release looking for: **\*.testoutput.xml