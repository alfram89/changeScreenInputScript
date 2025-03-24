#Install module if not precent
Install-Module -Name MonitorConfig -RequiredVersion 2.0

#Get current value
try {
    $GetValueScreen1 = Get-MonitorVCPResponse -monitor \\.\DISPLAY1 -VCPcode 0x60
    $GetValueScreen2 = Get-MonitorVCPResponse -monitor \\.\DISPLAY2 -VCPcode 0x60
} catch {
    Write-Host "Failed to get response from monitor. $_ "
}
## Switch between two input sources

## DISPLAY 2
if ($GetValueScreen2.CurrentValue -eq 15) {
    Set-MonitorVCPValue -monitor \\.\DISPLAY2 -VCPcode 0x60 -Value 17
}
if ($GetValueScreen2.CurrentValue -eq 17) {
    Set-MonitorVCPValue -monitor \\.\DISPLAY2 -VCPcode 0x60 -Value 15
}

<#
 # {## DISPLAY 1
if ($GetValueScreen1.CurrentValue -eq 15) {
    Set-MonitorVCPValue -monitor \\.\DISPLAY1 -VCPcode 0x60 -Value 17
}
if ($GetValueScreen1.CurrentValue -eq 17) {
    Set-MonitorVCPValue -monitor \\.\DISPLAY1 -VCPcode 0x60 -Value 15
}:Enter a comment or description}
#>