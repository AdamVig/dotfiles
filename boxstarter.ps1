# Based on:
# - https://gist.github.com/jessfraz/7c319b046daa101a4aaef937a20ff41f
# - https://gist.github.com/NickCraver/7ebf9efbfd0c3eab72e9
#
# Install boxstarter:
# 	. { iwr -useb http://boxstarter.org/bootstrapper.ps1 } | iex; get-boxstarter -Force
#
# You might need to set: Set-ExecutionPolicy RemoteSigned
#
# Run this boxstarter by calling the following from an **elevated** command-prompt:
# 	start http://boxstarter.org/package/nr/url?<URL-TO-RAW-FILE>
# OR
# 	Install-BoxstarterPackage -PackageName <URL-TO-RAW-FILE> -DisableReboots

#---- TEMPORARY ---
Disable-UAC

#--- Windows Settings ---
Disable-BingSearch
Disable-GameBarTips
Enable-RemoteDesktop

# TODO this resulted in a weird Explorer experience, needs revisiting
# Set-WindowsExplorerOptions -DisableShowProtectedOSFiles -EnableShowFileExtensions -DisableShowRecentFilesInQuickAccess -DisableShowFrequentFoldersInQuickAccess -DisableShowRibbon -DisableOpenFileExplorerToQuickAccess -EnableExpandToOpenFolder
Set-TaskbarOptions -Size Small -Dock Bottom -Combine Full -Lock

#--- Windows Subsystems/Features ---
# Uncomment to re-enable WSL
# choco install Microsoft-Hyper-V-All -source windowsFeatures
# choco install Microsoft-Windows-Subsystem-Linux -source windowsfeatures

# Remove preinstalled applications
Get-AppxPackage *Autodesk* | Remove-AppxPackage
Get-AppxPackage *BubbleWitch* | Remove-AppxPackage
Get-AppxPackage Clipchamp.Clipchamp | Remove-AppxPackage
Get-AppxPackage *Dell* | Remove-AppxPackage
Get-AppxPackage *Dropbox* | Remove-AppxPackage
Get-AppxPackage *Facebook* | Remove-AppxPackage
Get-AppxPackage *Keeper* | Remove-AppxPackage
Get-AppxPackage *MarchofEmpires* | Remove-AppxPackage
Get-AppxPackage *McAfee* | Remove-AppxPackage
Get-AppxPackage *Minecraft* | Remove-AppxPackage
Get-AppxPackage *Netflix* | Remove-AppxPackage
Get-AppxPackage *Plex* | Remove-AppxPackage
Get-AppxPackage *Solitaire* | Remove-AppxPackage
Get-AppxPackage *Twitter* | Remove-AppxPackage
Get-AppxPackage king.com.CandyCrush* | Remove-AppxPackage
Get-AppxPackage Microsoft.3DBuilder | Remove-AppxPackage
Get-AppxPackage Microsoft.BingFinance | Remove-AppxPackage
Get-AppxPackage Microsoft.BingNews | Remove-AppxPackage
Get-AppxPackage Microsoft.BingSports | Remove-AppxPackage
Get-AppxPackage Microsoft.BingSearch | Remove-AppxPackage
Get-AppxPackage Microsoft.BingWeather | Remove-AppxPackage
Get-AppxPackage Microsoft.CommsPhone | Remove-AppxPackage
Get-AppxPackage Microsoft.Copilot | Remove-AppxPackage
Get-AppxPackage Microsoft.Getstarted | Remove-AppxPackage
Get-AppxPackage Microsoft.Messaging | Remove-AppxPackage
Get-AppxPackage Microsoft.Microsoft3DViewer | Remove-AppxPackage
Get-AppxPackage Microsoft.MicrosoftOfficeHub | Remove-AppxPackage
Get-AppxPackage Microsoft.MicrosoftSolitaireCollection | Remove-AppxPackage
Get-AppxPackage Microsoft.MicrosoftStickyNotes | Remove-AppxPackage
Get-AppxPackage Microsoft.MixedReality.Portal | Remove-AppxPackage
Get-AppxPackage Microsoft.Office.OneNote | Remove-AppxPackage
Get-AppxPackage Microsoft.Office.Sway | Remove-AppxPackage
Get-AppxPackage Microsoft.OneConnect | Remove-AppxPackage
Get-AppxPackage Microsoft.People | Remove-AppxPackage
Get-AppxPackage Microsoft.Print3D | Remove-AppxPackage
Get-AppxPackage Microsoft.SkypeApp | Remove-AppxPackage
Get-AppxPackage Microsoft.Wallet | Remove-AppxPackage
Get-AppxPackage Microsoft.Windows.Photos | Remove-AppxPackage
Get-AppxPackage Microsoft.WindowsAlarms | Remove-AppxPackage
Get-AppxPackage microsoft.windowscommunicationsapps | Remove-AppxPackage
Get-AppxPackage Microsoft.WindowsPhone | Remove-AppxPackage
Get-AppxPackage Microsoft.WindowsSoundRecorder | Remove-AppxPackage
# note: Microsoft.XboxGameCallableUI cannot be removed
# TODO experimenting with which of these are necessary in order to use Xbox Live
# Get-AppxPackage Microsoft.XboxApp | Remove-AppxPackage
# Get-AppxPackage Microsoft.XboxIdentityProvider | Remove-AppxPackage
Get-AppxPackage Microsoft.YourPhone | Remove-AppxPackage
Get-AppxPackage Microsoft.Zune* | Remove-AppxPackage
Get-AppxPackage MSTeams | Remove-AppxPackage

# Uninstall OneDrive
if (Test-Path $env:SystemRoot\SysWOW64\) {
  & $env:SystemRoot\SysWOW64\OneDriveSetup.exe /uninstall
} else {
  & $env:SystemRoot\System32\OneDriveSetup.exe /uninstall
}

# Tools
cinst 7zip
cinst procexp

# Apps
cinst battle.net --allow-empty-checksums
cinst bitwarden
cinst bluescreenview
cinst brave
cinst discord
cinst epicgameslauncher
cinst foxitreader
cinst hass-agent
cinst hwmonitor
cinst IrfanView
cinst mpvio.install
cinst signal
cinst spotify
cinst steam

# Privacy: Let apps use my advertising ID: Disable
If (-Not (Test-Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\AdvertisingInfo")) {
    New-Item -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\AdvertisingInfo | Out-Null
}
Set-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\AdvertisingInfo -Name Enabled -Type DWord -Value 0

# WiFi Sense: HotSpot Sharing: Disable
If (-Not (Test-Path "HKLM:\Software\Microsoft\PolicyManager\default\WiFi\AllowWiFiHotSpotReporting")) {
    New-Item -Path HKLM:\Software\Microsoft\PolicyManager\default\WiFi\AllowWiFiHotSpotReporting | Out-Null
}
Set-ItemProperty -Path HKLM:\Software\Microsoft\PolicyManager\default\WiFi\AllowWiFiHotSpotReporting -Name value -Type DWord -Value 0

# WiFi Sense: Shared HotSpot Auto-Connect: Disable
Set-ItemProperty -Path HKLM:\Software\Microsoft\PolicyManager\default\WiFi\AllowAutoConnectToWiFiSenseHotspots -Name value -Type DWord -Value 0

# Start Menu: Disable Bing Search Results
Set-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Search -Name BingSearchEnabled -Type DWord -Value 0
# To Restore (Enabled):
# Set-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Search -Name BingSearchEnabled -Type DWord -Value 1

# Disable Telemetry (requires a reboot to take effect)
Set-ItemProperty -Path HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection -Name AllowTelemetry -Type DWord -Value 0
Get-Service DiagTrack,Dmwappushservice | Stop-Service | Set-Service -StartupType Disabled

# Disable the Lock Screen (the one before password prompt - to prevent dropping the first character)
If (-Not (Test-Path HKLM:\SOFTWARE\Policies\Microsoft\Windows\Personalization)) {
	New-Item -Path HKLM:\SOFTWARE\Policies\Microsoft\Windows -Name Personalization | Out-Null
}
Set-ItemProperty -Path HKLM:\SOFTWARE\Policies\Microsoft\Windows\Personalization -Name NoLockScreen -Type DWord -Value 1
# To Restore:
# Set-ItemProperty -Path HKLM:\SOFTWARE\Policies\Microsoft\Windows\Personalization -Name NoLockScreen -Type DWord -Value 1

# Disable sleep
powercfg -change -monitor-timeout-ac 0
powercfg -change -standby-timeout-ac 0

# Disable Xbox Gamebar
Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\GameDVR" -Name AppCaptureEnabled -Type DWord -Value 0
Set-ItemProperty -Path "HKCU:\System\GameConfigStore" -Name GameDVR_Enabled -Type DWord -Value 0

# Turn off People in Taskbar
If (-Not (Test-Path "HKCU:SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced\People")) {
    New-Item -Path HKCU:SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced\People | Out-Null
}
Set-ItemProperty -Path "HKCU:SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced\People" -Name PeopleBand -Type DWord -Value 0

#--- Restore Temporary Settings ---
Enable-UAC
Enable-MicrosoftUpdate
Install-WindowsUpdate -acceptEula

# Rename computer (requires restart), set name before uncommenting
#$computername = ""
#if ($env:computername -ne $computername) {
#	Rename-Computer -NewName $computername
#}
