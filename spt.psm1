
<#
.SYNOPSIS
This is the basic shell to import all of the functions related to MPSTools powershell module.
It will echo the process of importing the module back to the user, and then load all
nested modules.
  #>

function Get-SPT {

	Write-Host "Loading SPT (Spathii Tools) Module"

}

Export-ModuleMember -Function "Get-SPT"

