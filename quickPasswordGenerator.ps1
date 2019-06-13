<#
    Shitty password generator! 
#>

$maxStringLength = 64
$minStringLength = 32

$lowercaseCheck = $False
$uppercaseCheck = $False
$symbolCheck = $False
$digitCheck = $False

function addLowerChar($password, $lowercaseCheck){
    # Write-Host "Adding lowercase character"
    $additive = Get-Random -Minimum 97 -maximum 122
    Write-Host "Appending $additive to $password"
    $password = ($password + [char]$additive)
    $global:lowercaseCheck = $True
    return $password
    return $lowercaseCheck
}

function addUpperChar($password, $uppercaseCheck){
    # Write-Host "Adding uppercase character"
    $additive = Get-Random -Minimum 65 -maximum 90
    Write-Host "Appending $additive to $password"
    $password = ($password + [char]$additive)
    $global:uppercaseCheck = $True
    return $password
    return $uppercaseCheck
}

function addSymbol($password, $symbolCheck){
    # Write-Host "Adding symbol"
    $additive = (33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 58, 59, 60, 61, 62, 63, 64, 91, 92, 93, 94, 95, 96, 123, 124, 125, 126 | Get-Random)
    Write-Host "Appending $additive to $password"
    $password = ($password + [char]$additive)
    $global:symbolCheck = $True
    return $password
    return $symbolCheck
}

function addDigit($password, $digitCheck){
    # Write-Host "Adding digit"
    $additive = Get-Random -Minimum 48 -maximum 57
    Write-Host "Appending $additive to $password"
    $password = ($password + [char]$additive)
    $global:digitCheck = $True
    return $password
    return $digitCheck
}

$passwordLength = Get-Random -Minimum $minStringLength -Maximum $maxStringLength
$keepTrying = $True
$failCountdown = 3
$password = ""

# Main processing loop
while($keepTrying) {
    for(($i=0); ($i -lt $passwordLength); $i++) {
        $timer=Get-Random -Maximum 25
        Start-Sleep -Milliseconds $timer
        $indexChoice = Get-Random -Maximum 4

        if($indexChoice -eq 0) {
            $returns = addLowerChar $password $lowercaseCheck
            $password = $returns[0]
            $lowercaseCheck = $returns[1]
            Write-Host "special password is $password"
            Write-Host "special lowercaseCheck is $lowercaseCheck"
        }elseif($indexChoice -eq 1) {
            $password = addUpperChar $password $uppercaseCheck
        } elseif($indexChoice -eq 2) {
            $password = addSymbol $password $symbolCheck
        }elseif($indexChoice -eq 3) {
            $password = addDigit $password $digitCheck
        }else{
            Write-Host "how did you get here? o_0"
        }
    }

    if(($lowercaseCheck) -and ($uppercaseCheck) -and ($symbolCheck) -and ($digitCheck)) {
        Write-Host "`n`nPassword is $password"
        $password | clip
        msg $env:username "Password copied to clipboard..."
        exit
    } elseif($failcountdown -ne 0) {
        Write-Host "password creation failed checks. Will try again $failCountdown more times"
        $failcountdown--
        Write-Host "------"
        Write-Host "$lowercaseCheck"
        Write-Host "$uppercaseCheck"
        Write-Host "$symbolCheck"
        Write-Host "$digitCheck"
        Write-Host "------"
    } else {
        Write-Host "Failed too many times because probability is a bitch!"
        Write-Host "`n`nI'm amazed you even got here!"
        timeout 5
        exit
    }
}


