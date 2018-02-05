function Get-TargetResource
{
	[CmdletBinding()]
	[OutputType([System.Collections.Hashtable])]
	param
	(
		[parameter(Mandatory = $true)]
		[System.String]
		$EndpointName,
		[parameter(Mandatory = $true)]
		[PSCredential]
		$ConfigurationAccount
	)

	try {
		$SessionConfiguration = Get-PSSessionConfiguration -Name $EndpointName -ErrorAction SilentlyContinue -Verbose:$false
	}catch{
		Write-Host "Configuration not found"
		$SessionConfiguration = $null
	}  

	if ($SessionConfiguration -eq $null){
		Write-Host "Configuration not found"
	}else{
		Write-Host "Configuration $($SessionConfiguration.Name) found with $($SessionConfiguration.RunAsUser)"
	}
	$returnvalue = @{
		SessionConfiguration = $SessionConfiguration
	}

	$returnvalue
	
}

function Set-TargetResource
{
	[CmdletBinding()]
	[OutputType([System.Boolean])]
	param
	(
		[parameter(Mandatory = $true)]
		[System.String]
		$EndpointName,
		[parameter(Mandatory = $true)]
		[PSCredential]
		$ConfigurationAccount
	)

	$SessionConfiguration = Get-TargetResource -EndpointName $EndpointName -ConfigurationAccount $ConfigurationAccount
	If ($SessionConfiguration.SessionConfiguration -eq $null){
		Write-Host "Create a JEA Configuration endpoint called $EndpointName and username $($ConfigurationAccount.UserName)"
		Register-PSSessionConfiguration -Name $EndpointName -RunAsCredential $ConfigurationAccount -Force 
		
	}else{
		If ($SessionConfiguration.SessionConfiguration.RunAsUser -ne $ConfigurationAccount.UserName){
			Write-Host "JEA Configuration called $EndpointName found but with a different account."
			Write-Host "Former user was $($SessionConfiguration.SesssionConfiguration.RunAsUser)"
			Write-Host "Desired user is $($ConfigurationAccount.UserName)"
			Set-PSSessionConfiguration -Name $EndpointName -RunAsCredential $ConfigurationAccount -Force 
		}
	}
}

function Test-TargetResource
{
	[CmdletBinding()]
	[OutputType([System.Boolean])]
	param
	(
		[parameter(Mandatory = $true)]
		[System.String]
		$EndpointName,
		[parameter(Mandatory = $true)]
		[PSCredential]
		$ConfigurationAccount
	)

	$SessionConfiguration = Get-TargetResource -EndpointName $EndpointName -ConfigurationAccount $ConfigurationAccount
	If ($SessionConfiguration.SessionConfiguration -eq $null){
		Write-Host "JEA Configuration called $EndpointName not found on the server"
		return $false
	}else{
		If ($SessionConfiguration.SessionConfiguration.RunAsUser -ne $ConfigurationAccount.UserName){
			Write-Host "JEA Configuration called $EndpointName found but with a different account."
			Write-Host "Former user was $($SessionConfiguration.SesssionConfiguration.RunAsUser)"
			Write-Host "Desired user is $($ConfigurationAccount.UserName)"
			return $false
		} else {
			return $true
		}
	}
}

Export-ModuleMember -Function *-TargetResource