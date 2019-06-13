<#
    Expand a user-supplied registry path and display all reg key properties and values
#>
function Expand-key($regPath) {
    Write-Host "Checking properties of Reg Key at: $regPath"
    Push-Location
    Set-Location -path $regPath
    # Totally mooching off of 'https://devblogs.microsoft.com/scripting/use-powershell-to-enumerate-registry-property-values/'
    $regObject = Get-Item . | Select-Object -ExpandProperty property | ForEach-Object { 
        New-Object psobject -Property @{"Property"=$_; "Value"=(Get-ItemProperty -Path . -Name $_).$_}
    } | Format-Table property, value -AutoSize

    Pop-Location

    return $regObject
}

$regObject = New-Object psobject
$regPath = $Args[0]

# If the reg path was not supplied, request it from user. HCI blah blah blah...
if($regPath) {
    $regObject=Expand-Key $regPath
} else {
    $regPath = Read-Host "Registry Key"
    $regObject=Expand-Key $regPath
}

$regObject | Select-Object

return $regObject