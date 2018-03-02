param(
	[string]$Server="LOCALHOST",
	[string]$Database="WideWorldImporters-LocalDev",
	[boolean]$Debug=$true
)


Invoke-Pester -Script @{Path = './tests/tests.ps1'; Parameters = @{Server = $Server; Database = $Database} } -EnableExit:(!$Debug) -OutputFile bin/debug/tests.testoutput.xml -OutputFormat NUnitXML

