<#
    Puke out all the contents of each key from a user-supplied registry folder 
#>
function Expand-key($regPath) {
    Write-Host "Checking properties of Reg Key at: $regPath"
    Push-Location
    Set-Location -path $regPath
    $regObject = Get-ChildItem $regPath -Recurse # Why is some powershell deceptively simple while other parts are ass backwards

    Pop-Location

    return $regObject
}

$regObject = New-Object psobject
$regPath = $Args[0]

# If the reg path was not supplied, request it from user. HCI blah blah blah...
if($regPath) {
    $regObject=Expand-Key $regPath
} else {
    # $regPath = Read-Host "Registry Key"
    $regPath="HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\"
    $regObject=Expand-Key $regPath
}

$regObject | Select-Object | out-gridview | Format-Table Name

return $regObject # If you want individual objects for each key... parse it yourself! 