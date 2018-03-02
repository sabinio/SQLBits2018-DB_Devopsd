param(
	[string]$Server="LOCALHOST",
	[string]$Database="WideWorldImporters-LOCALDEV"
	)


Describe "Functions" {
    It "Function 1 add 1 should work" {
        $Query = "SELECT [Application].[OneAddOne](1,1) Result"
        $Result = Invoke-Sqlcmd -ServerInstance $Server -Database $Database -Query $Query
        $Result.Result | Should be 2
    }    
}
