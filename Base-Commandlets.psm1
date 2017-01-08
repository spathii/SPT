function Test-SPTAdminRights {
    ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")
}


function Set-SPTENVPSModulePath {

<#This function will take a path from the user, and add it to the PSModulePath environment variable.  If it 
already exists, it will leave it alone #>
[CmdletBinding()]
param ($newpath)
    
    if (Test-SPTAdminRights) {
	    $CurrentValue = [Environment]::GetEnvironmentVariable("PSModulePath", "Machine")
        $NewValue = $CurrentValue + ";" + $newPath
	    if ($CurrentValue -match [regex]::escape($newPath)) {
            Write-Verbose "[INFO]Path already part of the environment variable"		
            Return 0
	    }
	    else {
	        [Environment]::SetEnvironmentVariable("PSModulePath", $NewValue, "Machine")
            Write-Verbose "[INFO]New path, $NewPath, added to PSModulePath environment variable"
            $RealNewValue = [Environment]::GetEnvironmentVariable("PSModulePath", "Machine")
            Write-Verbose "PSModulePath: $RealNewValue"
            Return 0
	    }
    }
    else {
        Write-Verbose "[ERROR]Administrative Rights required to perform this operation"
        Return 1
    }
}

Export-ModuleMember Test-SPTAdminRights,Set-SPTENVPSModulePath