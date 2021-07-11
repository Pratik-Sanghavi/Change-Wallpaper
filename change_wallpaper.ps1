cd C:\Users\sangh\Desktop\Projects\Cycle_Wallpaper\;
bash ./Cycle.sh;
# Set wallpaper (failsafe built in)
function Set-Wallpaper ([string]$desktopImage)
{
    Remove-ItemProperty -path "HKCU:\Control Panel\Desktop" -name WallPaper 
    set-itemproperty -path "HKCU:\Control Panel\Desktop" -name WallPaper -value $desktopImage
        
    RUNDLL32.EXE USER32.DLL,UpdatePerUserSystemParameters ,1 ,True
}

$desktopImage = Get-Content -Path .\curr_wallpaper.txt;
Set-Wallpaper "C:\Users\sangh\Desktop\Projects\Cycle_Wallpaper$desktopImage";
Write-Host "C:\Users\sangh\Desktop\Projects\Cycle_Wallpaper$desktopImage";