#$num = Read-Host -Prompt "Enter a decimal number to convert to hex" 
$result = ''

function Get-Hex {
    param(
        $num
    )
    $remainder = $num / 16
    $modulus = $num % 16
    $rounded = [Math]::Round($num)
    if ($rounded -eq 0) {
        exit
    }
    if ($modulus -gt 0) {
        $result += [Math]::Round($modulus)
    }
    else {
        $result += "0"
    }    
    Get-Hex $r
}
#$num = Read-Host -Prompt "Enter a decimal number to convert to hex" 
#Get-Hex $num

Get-Hex 1000
write-output $result
