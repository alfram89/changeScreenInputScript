# Change screen input script
This PowerShell script allows you to toggle the input source of one or two connected monitors using VCP (Virtual Control Panel) codes. It is especially useful for users who frequently switch between different input sources (e.g., HDMI, DisplayPort) on the same monitor.

## Features
- Automatically detects current input source on each monitor.
- Switches between two predefined input sources:
  -    15 (e.g., DisplayPort)
  -    17 (e.g., HDMI)
- Supports multiple displays (e.g., DISPLAY1, DISPLAY2).
- Simple toggle logic based on current input state.
- Graceful error handling if the monitor does not respond.
- Optional code block for extending to additional displays.

## Prerequisites
- PowerShell
- [MonitorConfig PowerShell module](https://www.powershellgallery.com/packages/MonitorConfig/2.0)

Install the required module (if not already present):
`` Install-Module -Name MonitorConfig -RequiredVersion 2.0 -Scope CurrentUser ``

You might need to run PowerShell as Administrator and allow script execution policies if required.

## Usage

Simply run the script to toggle between input source 15 and 17 on DISPLAY2.
Optional code for DISPLAY1 is included but commented out—uncomment to use it as well.
Example
``` powershell
# Get current input source for each monitor
try {
    $GetValueScreen1 = Get-MonitorVCPResponse -monitor \\.\DISPLAY1 -VCPcode 0x60
    $GetValueScreen2 = Get-MonitorVCPResponse -monitor \\.\DISPLAY2 -VCPcode 0x60
} catch {
    Write-Host "Failed to get response from monitor. $_ "
}
``` 
``` powershell
# Toggle input source for DISPLAY2
if ($GetValueScreen2.CurrentValue -eq 15) {
    Set-MonitorVCPValue -monitor \\.\DISPLAY2 -VCPcode 0x60 -Value 17
}
if ($GetValueScreen2.CurrentValue -eq 17) {
    Set-MonitorVCPValue -monitor \\.\DISPLAY2 -VCPcode 0x60 -Value 15
}
```
### Optional: Toggle input for DISPLAY1
``` powershell
# Optional: Toggle input for DISPLAY1
<#
if ($GetValueScreen1.CurrentValue -eq 15) {
    Set-MonitorVCPValue -monitor \\.\DISPLAY1 -VCPcode 0x60 -Value 17
}
if ($GetValueScreen1.CurrentValue -eq 17) {
    Set-MonitorVCPValue -monitor \\.\DISPLAY1 -VCPcode 0x60 -Value 15
}
#>
```
## Notes
- VCP code 0x60 corresponds to the monitor's input source setting.
- The actual values (15, 17) may differ depending on your monitor's model. Check your monitor’s DDC/CI documentation if necessary.
