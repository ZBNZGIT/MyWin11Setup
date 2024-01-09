@echo off
setlocal enabledelayedexpansion
mode con lines=20 cols=125
chcp 65001 >nul 2>&1
cd /d "%~dp0"
title ZBNZ Toolbox

call:SETCONSTANTS >nul 2>&1

openfiles >nul 2>&1
if !ERRORLEVEL! neq 0 (
    echo !S_GRAY!You are not running as !RED!Administrator!S_GRAY!...
    echo This batch cannot do it's job without elevation!
    echo.
    echo Right-click and select !S_GREEN!^'Run as Administrator^' !S_GRAY!and try again...
    echo.
    echo Press any key to exit . . .
    pause >nul && exit
)

ping -n 1 "google.com" >nul 2>&1
if !ERRORLEVEL! neq 0 (
    echo !RED!ERROR: !S_GRAY!No internet connection found
    echo.
    echo Please make sure you are connected to the internet and try again . . .
    pause >nul && exit
)

:MAIN_MENU
mode con lines=26 cols=125
echo.
echo.
echo.
echo !S_MAGENTA!             ███████╗██████╗ ███╗   ██╗███████╗    ████████╗ ██████╗  ██████╗ ██╗     ██████╗  ██████╗ ██╗  ██╗
echo !S_MAGENTA!             ╚══███╔╝██╔══██╗████╗  ██║╚══███╔╝    ╚══██╔══╝██╔═══██╗██╔═══██╗██║     ██╔══██╗██╔═══██╗╚██╗██╔╝
echo !S_MAGENTA!               ███╔╝ ██████╔╝██╔██╗ ██║  ███╔╝        ██║   ██║   ██║██║   ██║██║     ██████╔╝██║   ██║ ╚███╔╝ 
echo !S_MAGENTA!              ███╔╝  ██╔══██╗██║╚██╗██║ ███╔╝         ██║   ██║   ██║██║   ██║██║     ██╔══██╗██║   ██║ ██╔██╗ 
echo !S_MAGENTA!             ███████╗██████╔╝██║ ╚████║███████╗       ██║   ╚██████╔╝╚██████╔╝███████╗██████╔╝╚██████╔╝██╔╝ ██╗
echo !S_MAGENTA!             ╚══════╝╚═════╝ ╚═╝  ╚═══╝╚══════╝       ╚═╝    ╚═════╝  ╚═════╝ ╚══════╝╚═════╝  ╚═════╝ ╚═╝  ╚═╝
echo.
echo.
echo                    !S_MAGENTA!╔═════════════════════════════════════════════════════════════════════════════════════╗
echo                                                          !UNDERLINE!!S_GREEN!Welcome %username%!S_GREEN!!_UNDERLINE!
echo                    !S_MAGENTA!╚═════════════════════════════════════════════════════════════════════════════════════╝
echo.
echo                                  [ !S_GREEN!1!S_MAGENTA! ] !S_WHITE!SYSTEM TWEAKS!S_MAGENTA!                   [ !S_GREEN!2!S_MAGENTA! ] !S_WHITE!SOFTWARE INSTALLER!S_MAGENTA!
echo.
echo.
echo.
echo                                               !S_GRAY!Make your choices AND press !S_GREEN!{ENTER}!S_GRAY!
echo.
set choice=
set /p "choice=!S_GREEN!                                                              "
if "!choice!"=="1" goto SYSTWEAKS
if "!choice!"=="2" goto APPS_MENU_CLEAR
echo                                            !RED!ERROR: !S_GREEN!"!choice!"!S_GRAY! is not a valid choice...
timeout /t 3 /nobreak >nul 2>&1
goto MAIN_MENU

:SYSTWEAKS
cls

call:ECHOX Remove Microsoft Edge
cd %temp%
curl -o RemoveEdge.bat https://raw.githubusercontent.com/ZBNZGIT/RemoveEdge/main/RemoveEdge.bat >nul 2>&1
if %ERRORLEVEL% neq 0 (
    echo Failed to download RemoveEdge.bat. Exiting script.
    timeout /t 5 /nobreak >nul 2>&1
    exit /b
)
call RemoveEdge.bat
del RemoveEdge.bat >nul 2>&1

call:ECHOX Hide Widgets Icon On Taskbar
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v TaskbarDa /t REG_DWORD /d 0 /f >nul 2>&1
timeout 1 > nul 2>&1

call:ECHOX Hide Search Box On Taskbar
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Search" /v SearchboxTaskbarMode /t REG_DWORD /d 0 /f >nul 2>&1
timeout 1 > nul 2>&1

call:ECHOX Hide Task View Button On Taskbar
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v ShowTaskViewButton /t REG_DWORD /d 0 /f >nul 2>&1
timeout 1 > nul 2>&1

call:ECHOX Move Taskbar To Left
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v TaskbarAl /t REG_DWORD /d 0 /f >nul 2>&1
timeout 1 > nul 2>&1

call:ECHOX Setting desktop background to solid color
reg add "HKU\!USER_SID!\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Wallpapers" /v "BackgroundType" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKU\!USER_SID!\Control Panel\Desktop" /v "Wallpaper" /t REG_SZ /d "" /f >nul 2>&1
reg add "HKU\!USER_SID!\Control Panel\Colors" /v "Background" /t REG_SZ /d "40 42 54" /f >nul 2>&1
timeout 1 > nul 2>&1

call:ECHOX Disabling startup sound
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Authentication\LogonUI\BootAnimation" /v "DisableStartupSound" /t REG_DWORD /d "1" /f >nul 2>&1
timeout 1 > nul 2>&1

call:ECHOX Disabling mouse acceleration
reg add "HKU\!USER_SID!\Control Panel\Mouse" /v "MouseSensitivity" /t REG_SZ /d "10" /f >nul 2>&1
reg add "HKU\!USER_SID!\Control Panel\Mouse" /v "MouseSpeed" /t REG_SZ /d "0" /f >nul 2>&1
reg add "HKU\!USER_SID!\Control Panel\Mouse" /v "MouseThreshold1" /t REG_SZ /d "0" /f >nul 2>&1
reg add "HKU\!USER_SID!\Control Panel\Mouse" /v "MouseThreshold2" /t REG_SZ /d "0" /f >nul 2>&1
timeout 1 > nul 2>&1

call:ECHOX Removing Microsoft Store bloatware
call:POWERSHELL "$ExcludedAppxPackages=@('Microsoft.DesktopAppInstaller','Microsoft.WindowsStore','Microsoft.StorePurchaseApp','Microsoft.WebMediaExtensions','Microsoft.HEVCVideoExtension','Microsoft.Windows.CapturePicker','Microsoft.XboxIdentityProvider','Microsoft.XboxTCUI','Microsoft.XboxSpeechToTextOverlay','Microsoft.XboxGamingOverlay','Microsoft.XboxGameOverlay','Microsoft.GamingServices','AppUp.IntelGraphicsControlPanel','AppUp.IntelGraphicsExperience','NVIDIACorp.NVIDIAControlPanel','AdvancedMicroDevicesInc-2.AMDRadeonSoftware','RealtekSemiconductorCorp.RealtekAudioControl');$AppxPackages=(Get-AppxPackage -PackageTypeFilter Bundle -AllUsers).Name|Select-String $ExcludedAppxPackages -NotMatch;foreach($AppxPackage in $AppxPackages){Get-AppxPackage -PackageTypeFilter Bundle -AllUsers|Where-Object -FilterScript {$_.Name -cmatch $AppxPackage}|Remove-AppxPackage -AllUsers}" >nul 2>&1
timeout 1 > nul 2>&1

call:ECHOX Turning On Dark Mode
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v SystemUsesLightTheme /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v AppsUseLightTheme /t REG_DWORD /d 0 /f >nul 2>&1
timeout 1 > nul 2>&1

call:ECHOX Disabling Transparency
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v EnableTransparency /t REG_DWORD /d 0 /f >nul 2>&1
timeout 1 > nul 2>&1

call:ECHOX Setting Windows 10 Context Menu
reg add "HKCU\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32" /f /ve >nul 2>&1
timeout 1 > nul 2>&1

call:ECHOX Settings File Explorer To Open To This PC
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v LaunchTo /t REG_DWORD /d 1 /f >nul 2>&1
timeout 1 > nul 2>&1

call:ECHOX Disabling Search Box Suggestions
reg add "HKEY_CURRENT_USER\Software\Policies\Microsoft\Windows\Explorer" /v DisableSearchBoxSuggestions /t REG_DWORD /d 1 /f >nul 2>&1
timeout 1 > nul 2>&1

call:ECHOX Removing Pin To Quick Access From Context Menu
reg delete HKEY_CLASSES_ROOT\AllFilesystemObjects\shell\pintohome /f >nul 2>&1
reg delete HKEY_CLASSES_ROOT\Drive\shell\pintohome /f >nul 2>&1
reg delete HKEY_CLASSES_ROOT\Folder\shell\pintohome /f >nul 2>&1
reg delete HKEY_CLASSES_ROOT\Network\shell\pintohome /f >nul 2>&1
timeout 1 > nul 2>&1

call:ECHOX Disabling background apps
reg add "HKU\!USER_SID!\SOFTWARE\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications" /v "GlobalUserDisabled" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKU\!USER_SID!\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" /v "BackgroundAppGlobalToggle" /t REG_DWORD /d "0" /f >nul 2>&1
timeout 1 > nul 2>&1

call:ECHOX Hiding recently added apps in start menu
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Explorer" /v "HideRecentlyAddedApps" /t REG_DWORD /d "1" /f >nul 2>&1
timeout 1 > nul 2>&1

call:ECHOX Show file extensions
reg add "HKU\!USER_SID!\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "HideFileExt" /t REG_DWORD /d "0" /f >nul 2>&1
timeout 1 > nul 2>&1

call:ECHOX  Removing OneDrive
taskkill /f /im OneDrive.exe >nul 2>&1
%SystemRoot%\System32\OneDriveSetup.exe /uninstall /silent >nul 2>&1
rd "%UserProfile%\OneDrive" /s /q >nul 2>&1
rd "%LocalAppData%\Microsoft\OneDrive" /s /q >nul 2>&1
rd "%ProgramData%\Microsoft OneDrive" /s /q >nul 2>&1
rd "C:\OneDriveTemp" /s /q >nul 2>&1
del "%USERPROFILE%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\OneDrive.lnk" /s /f /q >nul 2>&1
timeout 1 > nul 2>&1

call:ECHOX Removing Accessibility Features From Start Menu
rmdir /s /q "C:\Users\%username%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Accessibility" >nul 2>&1
rmdir /s /q "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Accessibility" >nul 2>&1
timeout 1 > nul 2>&1

call:ECHOX Removing Temp Files
del /s /q C:\Users\%username%\AppData\Local\Temp\* >nul 2>&1
timeout 1 > nul 2>&1

call:ECHOX Restarting Explorer
taskkill /f /im "explorer.exe" >nul 2>&1
timeout /t 5 /nobreak >nul 2>&1
start explorer.exe >nul 2>&1

call:ECHOX System tweaks complete

call:MSGBOX "Registry changes may require a reboot to take effect.\n\nWould you like to restart now ?" vbYesNo+vbExclamation "Restart Windows"
if !ERRORLEVEL! equ 6 shutdown -r -f -t 0
timeout /t 1 /nobreak >nul 2>&1
goto MAIN_MENU

:APPS_MENU_CLEAR
set APPS_MENU="Google Chrome" "Mozilla Firefox" "Brave" "Opera GX" "Microsoft Edge" "Vivaldi" "Deezer" "Spotify" "iTunes" "PotPlayer" "VLC media player" "Audacity" "OBS Studio" "ImageGlass" "ShareX" "GIMP" "Discord" "TeamSpeak" "Teams" "Zoom" "Slack" "Adobe Acrobat Reader" "Foxit Reader" "Microsoft Office" "Libre Office" "7zip" "Winrar" "Visual Studio Code" "Notepad++" "Github" "Git" "FileZilla" "WinSCP" "PuTTY" "Python 3" "Java Runtime Environment 8" "Node.JS" "Steam" "GOG Galaxy" "Epic Games" "Uplay" "Battle.net" "Origin" "VirtualBox" "VMware Workstation Pro" "VMware Workstation Player" "TeamViewer" "AnyDesk" "qBittorrent" "Bulk Crap Uninstaller" "Everything" "MSI Afterburner" "Visual C++ Redistributables" "DirectX" ".NET Framework 4.8"
for %%i in (!APPS_MENU!) do set "%%~i=!S_MAGENTA![ ]!S_WHITE! %%~i"

:APPS_MENU
cls
mode con lines=47 cols=143
echo.
echo !S_MAGENTA!
echo                             ╔═════════════════════════════════════════════════════════════════════════════════════╗
echo                             ║                                  !S_GREEN!SOFTWARE INSTALLER!S_MAGENTA!                                 ║
echo                             ╚═════════════════════════════════════════════════════════════════════════════════════╝
echo.
echo              !S_YELLOW!WEB BROWSERS                                 MEDIA                                        IMAGING
echo              ------------                                 -----                                        -------
echo               !S_GREEN!1 !Google Chrome!                          !S_GREEN!7 !Deezer!                                !S_GREEN!14 !ImageGlass!
echo               !S_GREEN!2 !Mozilla Firefox!                        !S_GREEN!8 !Spotify!                               !S_GREEN!15 !ShareX!
echo               !S_GREEN!3 !Brave!                                  !S_GREEN!9 !iTunes!                                !S_GREEN!16 !GIMP!
echo               !S_GREEN!4 !Opera GX!                              !S_GREEN!10 !PotPlayer!
echo               !S_GREEN!5 !Microsoft Edge!                        !S_GREEN!11 !VLC media player!
echo               !S_GREEN!6 !Vivaldi!                               !S_GREEN!12 !Audacity!
echo                                                           !S_GREEN!13 !OBS Studio!
echo.
echo              !S_YELLOW!MESSAGING                                    DOCUMENTS                                    COMPRESSION
echo              ---------                                    ---------                                    -----------
echo              !S_GREEN!17 !Discord!                               !S_GREEN!22 !Adobe Acrobat Reader!                  !S_GREEN!26 !7zip!
echo              !S_GREEN!18 !TeamSpeak!                             !S_GREEN!23 !Foxit Reader!                          !S_GREEN!27 !Winrar!
echo              !S_GREEN!19 !Teams!                                 !S_GREEN!24 !Microsoft Office!
echo              !S_GREEN!20 !Zoom!                                  !S_GREEN!25 !Libre Office!
echo              !S_GREEN!21 !Slack!
echo.
echo              !S_YELLOW!DEVELOPER TOOLS                              GAMES LAUNCHER                               OTHERS
echo              ---------------                              --------------                               ------
echo              !S_GREEN!28 !Visual Studio Code!                    !S_GREEN!38 !Steam!                                 !S_GREEN!44 !VirtualBox!
echo              !S_GREEN!29 !Notepad++!                             !S_GREEN!39 !GOG Galaxy!                            !S_GREEN!45 !VMware Workstation Pro!
echo              !S_GREEN!30 !Github!                                !S_GREEN!40 !Epic Games!                            !S_GREEN!46 !VMware Workstation Player!
echo              !S_GREEN!31 !Git!                                   !S_GREEN!41 !Uplay!                                 !S_GREEN!47 !TeamViewer!
echo              !S_GREEN!32 !FileZilla!                             !S_GREEN!42 !Battle.net!                            !S_GREEN!48 !AnyDesk!
echo              !S_GREEN!33 !WinSCP!                                !S_GREEN!43 !Origin!                                !S_GREEN!49 !qBittorrent!
echo              !S_GREEN!34 !PuTTY!                                                                              !S_GREEN!50 !Bulk Crap Uninstaller!
echo              !S_GREEN!35 !Python 3!                                                                           !S_GREEN!51 !Everything!
echo              !S_GREEN!36 !Java Runtime Environment 8!                                                         !S_GREEN!52 !MSI Afterburner!
echo              !S_GREEN!37 !Node.JS!
echo.
echo              !S_RED!Recommended to install
echo              ----------------------
echo              !S_GREEN!53 !Visual C++ Redistributables!
echo              !S_GREEN!54 !DirectX!
echo              !S_GREEN!55 !.NET Framework 4.8!
echo.
echo                                                  !S_GRAY!Make your choices OR "!S_GREEN!BACK!S_GRAY!" AND press !S_GREEN!{ENTER}!S_GRAY!
echo.
set choice=
set /p "choice=!S_GREEN!                                                                       "
REM WEB BROWSERS
if "!choice!"=="1" if "!Google Chrome!"=="!S_MAGENTA![ ]!S_WHITE! Google Chrome" (set "Google Chrome=!S_MAGENTA![!S_GREEN!x!S_MAGENTA!]!S_WHITE! Google Chrome") else set "Google Chrome=!S_MAGENTA![ ]!S_WHITE! Google Chrome"
if "!choice!"=="2" if "!Mozilla Firefox!"=="!S_MAGENTA![ ]!S_WHITE! Mozilla Firefox" (set "Mozilla Firefox=!S_MAGENTA![!S_GREEN!x!S_MAGENTA!]!S_WHITE! Mozilla Firefox") else set "Mozilla Firefox=!S_MAGENTA![ ]!S_WHITE! Mozilla Firefox"
if "!choice!"=="3" if "!Brave!"=="!S_MAGENTA![ ]!S_WHITE! Brave" (set "Brave=!S_MAGENTA![!S_GREEN!x!S_MAGENTA!]!S_WHITE! Brave") else set "Brave=!S_MAGENTA![ ]!S_WHITE! Brave"
if "!choice!"=="4" if "!Opera GX!"=="!S_MAGENTA![ ]!S_WHITE! Opera GX" (set "Opera GX=!S_MAGENTA![!S_GREEN!x!S_MAGENTA!]!S_WHITE! Opera GX") else set "Opera GX=!S_MAGENTA![ ]!S_WHITE! Opera GX"
if "!choice!"=="5" if "!Microsoft Edge!"=="!S_MAGENTA![ ]!S_WHITE! Microsoft Edge" (set "Microsoft Edge=!S_MAGENTA![!S_GREEN!x!S_MAGENTA!]!S_WHITE! Microsoft Edge") else set "Microsoft Edge=!S_MAGENTA![ ]!S_WHITE! Microsoft Edge"
if "!choice!"=="6" if "!Vivaldi!"=="!S_MAGENTA![ ]!S_WHITE! Vivaldi" (set "Vivaldi=!S_MAGENTA![!S_GREEN!x!S_MAGENTA!]!S_WHITE! Vivaldi") else set "Vivaldi=!S_MAGENTA![ ]!S_WHITE! Vivaldi"
REM MEDIA
if "!choice!"=="7" if "!Deezer!"=="!S_MAGENTA![ ]!S_WHITE! Deezer" (set "Deezer=!S_MAGENTA![!S_GREEN!x!S_MAGENTA!]!S_WHITE! Deezer") else set "Deezer=!S_MAGENTA![ ]!S_WHITE! Deezer"
if "!choice!"=="8" if "!Spotify!"=="!S_MAGENTA![ ]!S_WHITE! Spotify" (set "Spotify=!S_MAGENTA![!S_GREEN!x!S_MAGENTA!]!S_WHITE! Spotify") else set "Spotify=!S_MAGENTA![ ]!S_WHITE! Spotify"
if "!choice!"=="9" if "!iTunes!"=="!S_MAGENTA![ ]!S_WHITE! iTunes" (set "iTunes=!S_MAGENTA![!S_GREEN!x!S_MAGENTA!]!S_WHITE! iTunes") else set "iTunes=!S_MAGENTA![ ]!S_WHITE! iTunes"
if "!choice!"=="10" if "!PotPlayer!"=="!S_MAGENTA![ ]!S_WHITE! PotPlayer" (set "PotPlayer=!S_MAGENTA![!S_GREEN!x!S_MAGENTA!]!S_WHITE! PotPlayer") else set "PotPlayer=!S_MAGENTA![ ]!S_WHITE! PotPlayer"
if "!choice!"=="11" if "!VLC media player!"=="!S_MAGENTA![ ]!S_WHITE! VLC media player" (set "VLC media player=!S_MAGENTA![!S_GREEN!x!S_MAGENTA!]!S_WHITE! VLC media player") else set "VLC media player=!S_MAGENTA![ ]!S_WHITE! VLC media player"
if "!choice!"=="12" if "!Audacity!"=="!S_MAGENTA![ ]!S_WHITE! Audacity" (set "Audacity=!S_MAGENTA![!S_GREEN!x!S_MAGENTA!]!S_WHITE! Audacity") else set "Audacity=!S_MAGENTA![ ]!S_WHITE! Audacity"
if "!choice!"=="13" if "!OBS Studio!"=="!S_MAGENTA![ ]!S_WHITE! OBS Studio" (set "OBS Studio=!S_MAGENTA![!S_GREEN!x!S_MAGENTA!]!S_WHITE! OBS Studio") else set "OBS Studio=!S_MAGENTA![ ]!S_WHITE! OBS Studio"
REM IMAGING
if "!choice!"=="14" if "!ImageGlass!"=="!S_MAGENTA![ ]!S_WHITE! ImageGlass" (set "ImageGlass=!S_MAGENTA![!S_GREEN!x!S_MAGENTA!]!S_WHITE! ImageGlass") else set "ImageGlass=!S_MAGENTA![ ]!S_WHITE! ImageGlass"
if "!choice!"=="15" if "!ShareX!"=="!S_MAGENTA![ ]!S_WHITE! ShareX" (set "ShareX=!S_MAGENTA![!S_GREEN!x!S_MAGENTA!]!S_WHITE! ShareX") else set "ShareX=!S_MAGENTA![ ]!S_WHITE! ShareX"
if "!choice!"=="16" if "!GIMP!"=="!S_MAGENTA![ ]!S_WHITE! GIMP" (set "GIMP=!S_MAGENTA![!S_GREEN!x!S_MAGENTA!]!S_WHITE! GIMP") else set "GIMP=!S_MAGENTA![ ]!S_WHITE! GIMP"
REM MESSAGING
if "!choice!"=="17" if "!Discord!"=="!S_MAGENTA![ ]!S_WHITE! Discord" (set "Discord=!S_MAGENTA![!S_GREEN!x!S_MAGENTA!]!S_WHITE! Discord") else set "Discord=!S_MAGENTA![ ]!S_WHITE! Discord"
if "!choice!"=="18" if "!TeamSpeak!"=="!S_MAGENTA![ ]!S_WHITE! TeamSpeak" (set "TeamSpeak=!S_MAGENTA![!S_GREEN!x!S_MAGENTA!]!S_WHITE! TeamSpeak") else set "TeamSpeak=!S_MAGENTA![ ]!S_WHITE! TeamSpeak"
if "!choice!"=="19" if "!Teams!"=="!S_MAGENTA![ ]!S_WHITE! Teams" (set "Teams=!S_MAGENTA![!S_GREEN!x!S_MAGENTA!]!S_WHITE! Teams") else set "Teams=!S_MAGENTA![ ]!S_WHITE! Teams"
if "!choice!"=="20" if "!Zoom!"=="!S_MAGENTA![ ]!S_WHITE! Zoom" (set "Zoom=!S_MAGENTA![!S_GREEN!x!S_MAGENTA!]!S_WHITE! Zoom") else set "Zoom=!S_MAGENTA![ ]!S_WHITE! Zoom"
if "!choice!"=="21" if "!Slack!"=="!S_MAGENTA![ ]!S_WHITE! Slack" (set "Slack=!S_MAGENTA![!S_GREEN!x!S_MAGENTA!]!S_WHITE! Slack") else set "Slack=!S_MAGENTA![ ]!S_WHITE! Slack"
REM DOCUMENTS
if "!choice!"=="22" if "!Adobe Acrobat Reader!"=="!S_MAGENTA![ ]!S_WHITE! Adobe Acrobat Reader" (set "Adobe Acrobat Reader=!S_MAGENTA![!S_GREEN!x!S_MAGENTA!]!S_WHITE! Adobe Acrobat Reader") else set "Adobe Acrobat Reader=!S_MAGENTA![ ]!S_WHITE! Adobe Acrobat Reader"
if "!choice!"=="23" if "!Foxit Reader!"=="!S_MAGENTA![ ]!S_WHITE! Foxit Reader" (set "Foxit Reader=!S_MAGENTA![!S_GREEN!x!S_MAGENTA!]!S_WHITE! Foxit Reader") else set "Foxit Reader=!S_MAGENTA![ ]!S_WHITE! Foxit Reader"
if "!choice!"=="24" if "!Microsoft Office!"=="!S_MAGENTA![ ]!S_WHITE! Microsoft Office" (set "Microsoft Office=!S_MAGENTA![!S_GREEN!x!S_MAGENTA!]!S_WHITE! Microsoft Office") else set "Microsoft Office=!S_MAGENTA![ ]!S_WHITE! Microsoft Office"
if "!choice!"=="25" if "!Libre Office!"=="!S_MAGENTA![ ]!S_WHITE! Libre Office" (set "Libre Office=!S_MAGENTA![!S_GREEN!x!S_MAGENTA!]!S_WHITE! Libre Office") else set "Libre Office=!S_MAGENTA![ ]!S_WHITE! Libre Office"
REM COMPRESSION
if "!choice!"=="26" if "!7zip!"=="!S_MAGENTA![ ]!S_WHITE! 7zip" (set "7zip=!S_MAGENTA![!S_GREEN!x!S_MAGENTA!]!S_WHITE! 7zip") else set "7zip=!S_MAGENTA![ ]!S_WHITE! 7zip"
if "!choice!"=="27" if "!Winrar!"=="!S_MAGENTA![ ]!S_WHITE! Winrar" (set "Winrar=!S_MAGENTA![!S_GREEN!x!S_MAGENTA!]!S_WHITE! Winrar") else set "Winrar=!S_MAGENTA![ ]!S_WHITE! Winrar"
REM DEVELOPER TOOLS
if "!choice!"=="28" if "!Visual Studio Code!"=="!S_MAGENTA![ ]!S_WHITE! Visual Studio Code" (set "Visual Studio Code=!S_MAGENTA![!S_GREEN!x!S_MAGENTA!]!S_WHITE! Visual Studio Code") else set "Visual Studio Code=!S_MAGENTA![ ]!S_WHITE! Visual Studio Code"
if "!choice!"=="29" if "!Notepad++!"=="!S_MAGENTA![ ]!S_WHITE! Notepad++" (set "Notepad++=!S_MAGENTA![!S_GREEN!x!S_MAGENTA!]!S_WHITE! Notepad++") else set "Notepad++=!S_MAGENTA![ ]!S_WHITE! Notepad++"
if "!choice!"=="30" if "!Github!"=="!S_MAGENTA![ ]!S_WHITE! Github" (set "Github=!S_MAGENTA![!S_GREEN!x!S_MAGENTA!]!S_WHITE! Github") else set "Github=!S_MAGENTA![ ]!S_WHITE! Github"
if "!choice!"=="31" if "!Git!"=="!S_MAGENTA![ ]!S_WHITE! Git" (set "Git=!S_MAGENTA![!S_GREEN!x!S_MAGENTA!]!S_WHITE! Git") else set "Git=!S_MAGENTA![ ]!S_WHITE! Git"
if "!choice!"=="32" if "!FileZilla!"=="!S_MAGENTA![ ]!S_WHITE! FileZilla" (set "FileZilla=!S_MAGENTA![!S_GREEN!x!S_MAGENTA!]!S_WHITE! FileZilla") else set "FileZilla=!S_MAGENTA![ ]!S_WHITE! FileZilla"
if "!choice!"=="33" if "!WinSCP!"=="!S_MAGENTA![ ]!S_WHITE! WinSCP" (set "WinSCP=!S_MAGENTA![!S_GREEN!x!S_MAGENTA!]!S_WHITE! WinSCP") else set "WinSCP=!S_MAGENTA![ ]!S_WHITE! WinSCP"
if "!choice!"=="34" if "!PuTTY!"=="!S_MAGENTA![ ]!S_WHITE! PuTTY" (set "PuTTY=!S_MAGENTA![!S_GREEN!x!S_MAGENTA!]!S_WHITE! PuTTY") else set "PuTTY=!S_MAGENTA![ ]!S_WHITE! PuTTY"
if "!choice!"=="35" if "!Python 3!"=="!S_MAGENTA![ ]!S_WHITE! Python 3" (set "Python 3=!S_MAGENTA![!S_GREEN!x!S_MAGENTA!]!S_WHITE! Python 3") else set "Python 3=!S_MAGENTA![ ]!S_WHITE! Python 3"
if "!choice!"=="36" if "!Java Runtime Environment 8!"=="!S_MAGENTA![ ]!S_WHITE! Java Runtime Environment 8" (set "Java Runtime Environment 8=!S_MAGENTA![!S_GREEN!x!S_MAGENTA!]!S_WHITE! Java Runtime Environment 8") else set "Java Runtime Environment 8=!S_MAGENTA![ ]!S_WHITE! Java Runtime Environment 8"
if "!choice!"=="37" if "!Node.JS!"=="!S_MAGENTA![ ]!S_WHITE! Node.JS" (set "Node.JS=!S_MAGENTA![!S_GREEN!x!S_MAGENTA!]!S_WHITE! Node.JS") else set "Node.JS=!S_MAGENTA![ ]!S_WHITE! Node.JS"
REM GAMES LAUNCHE
if "!choice!"=="38" if "!Steam!"=="!S_MAGENTA![ ]!S_WHITE! Steam" (set "Steam=!S_MAGENTA![!S_GREEN!x!S_MAGENTA!]!S_WHITE! Steam") else set "Steam=!S_MAGENTA![ ]!S_WHITE! Steam"
if "!choice!"=="39" if "!GOG Galaxy!"=="!S_MAGENTA![ ]!S_WHITE! GOG Galaxy" (set "GOG Galaxy=!S_MAGENTA![!S_GREEN!x!S_MAGENTA!]!S_WHITE! GOG Galaxy") else set "GOG Galaxy=!S_MAGENTA![ ]!S_WHITE! GOG Galaxy"
if "!choice!"=="40" if "!Epic Games!"=="!S_MAGENTA![ ]!S_WHITE! Epic Games" (set "Epic Games=!S_MAGENTA![!S_GREEN!x!S_MAGENTA!]!S_WHITE! Epic Games") else set "Epic Games=!S_MAGENTA![ ]!S_WHITE! Epic Games"
if "!choice!"=="41" if "!Uplay!"=="!S_MAGENTA![ ]!S_WHITE! Uplay" (set "Uplay=!S_MAGENTA![!S_GREEN!x!S_MAGENTA!]!S_WHITE! Uplay") else set "Uplay=!S_MAGENTA![ ]!S_WHITE! Uplay"
if "!choice!"=="42" if "!Battle.net!"=="!S_MAGENTA![ ]!S_WHITE! Battle.net" (set "Battle.net=!S_MAGENTA![!S_GREEN!x!S_MAGENTA!]!S_WHITE! Battle.net") else set "Battle.net=!S_MAGENTA![ ]!S_WHITE! Battle.net"
if "!choice!"=="43" if "!Origin!"=="!S_MAGENTA![ ]!S_WHITE! Origin" (set "Origin=!S_MAGENTA![!S_GREEN!x!S_MAGENTA!]!S_WHITE! Origin") else set "Origin=!S_MAGENTA![ ]!S_WHITE! Origin"
REM OTHERS
if "!choice!"=="44" if "!VirtualBox!"=="!S_MAGENTA![ ]!S_WHITE! VirtualBox" (set "VirtualBox=!S_MAGENTA![!S_GREEN!x!S_MAGENTA!]!S_WHITE! VirtualBox") else set "VirtualBox=!S_MAGENTA![ ]!S_WHITE! VirtualBox"
if "!choice!"=="45" if "!VMware Workstation Pro!"=="!S_MAGENTA![ ]!S_WHITE! VMware Workstation Pro" (set "VMware Workstation Pro=!S_MAGENTA![!S_GREEN!x!S_MAGENTA!]!S_WHITE! VMware Workstation Pro") else set "VMware Workstation Pro=!S_MAGENTA![ ]!S_WHITE! VMware Workstation Pro"
if "!choice!"=="46" if "!VMware Workstation Player!"=="!S_MAGENTA![ ]!S_WHITE! VMware Workstation Player" (set "VMware Workstation Player=!S_MAGENTA![!S_GREEN!x!S_MAGENTA!]!S_WHITE! VMware Workstation Player") else set "VMware Workstation Player=!S_MAGENTA![ ]!S_WHITE! VMware Workstation Player"
if "!choice!"=="47" if "!TeamViewer!"=="!S_MAGENTA![ ]!S_WHITE! TeamViewer" (set "TeamViewer=!S_MAGENTA![!S_GREEN!x!S_MAGENTA!]!S_WHITE! TeamViewer") else set "TeamViewer=!S_MAGENTA![ ]!S_WHITE! TeamViewer"
if "!choice!"=="48" if "!AnyDesk!"=="!S_MAGENTA![ ]!S_WHITE! AnyDesk" (set "AnyDesk=!S_MAGENTA![!S_GREEN!x!S_MAGENTA!]!S_WHITE! AnyDesk") else set "AnyDesk=!S_MAGENTA![ ]!S_WHITE! AnyDesk"
if "!choice!"=="49" if "!qBittorrent!"=="!S_MAGENTA![ ]!S_WHITE! qBittorrent" (set "qBittorrent=!S_MAGENTA![!S_GREEN!x!S_MAGENTA!]!S_WHITE! qBittorrent") else set "qBittorrent=!S_MAGENTA![ ]!S_WHITE! qBittorrent"
if "!choice!"=="50" if "!Bulk Crap Uninstaller!"=="!S_MAGENTA![ ]!S_WHITE! Bulk Crap Uninstaller" (set "Bulk Crap Uninstaller=!S_MAGENTA![!S_GREEN!x!S_MAGENTA!]!S_WHITE! Bulk Crap Uninstaller") else set "Bulk Crap Uninstaller=!S_MAGENTA![ ]!S_WHITE! Bulk Crap Uninstaller"
if "!choice!"=="51" if "!Everything!"=="!S_MAGENTA![ ]!S_WHITE! Everything" (set "Everything=!S_MAGENTA![!S_GREEN!x!S_MAGENTA!]!S_WHITE! Everything") else set "Everything=!S_MAGENTA![ ]!S_WHITE! Everything"
if "!choice!"=="52" if "!MSI Afterburner!"=="!S_MAGENTA![ ]!S_WHITE! MSI Afterburner" (set "MSI Afterburner=!S_MAGENTA![!S_GREEN!x!S_MAGENTA!]!S_WHITE! MSI Afterburner") else set "MSI Afterburner=!S_MAGENTA![ ]!S_WHITE! MSI Afterburner"
REM Recommended to install
if "!choice!"=="53" if "!Visual C++ Redistributables!"=="!S_MAGENTA![ ]!S_WHITE! Visual C++ Redistributables" (set "Visual C++ Redistributables=!S_MAGENTA![!S_GREEN!x!S_MAGENTA!]!S_WHITE! Visual C++ Redistributables") else set "Visual C++ Redistributables=!S_MAGENTA![ ]!S_WHITE! Visual C++ Redistributables"
if "!choice!"=="54" if "!DirectX!"=="!S_MAGENTA![ ]!S_WHITE! DirectX" (set "DirectX=!S_MAGENTA![!S_GREEN!x!S_MAGENTA!]!S_WHITE! DirectX") else set "DirectX=!S_MAGENTA![ ]!S_WHITE! DirectX"
if "!choice!"=="55" if "!.NET Framework 4.8!"=="!S_MAGENTA![ ]!S_WHITE! .NET Framework 4.8" (set ".NET Framework 4.8=!S_MAGENTA![!S_GREEN!x!S_MAGENTA!]!S_WHITE! .NET Framework 4.8") else set ".NET Framework 4.8=!S_MAGENTA![ ]!S_WHITE! .NET Framework 4.8"
for /l %%i in (1,1,55) do if "!choice!"=="%%i" goto APPS_MENU
if "!choice!"=="" (
    for %%i in (!APPS_MENU!) do if "!%%~i!"=="!S_MAGENTA![!S_GREEN!x!S_MAGENTA!]!S_WHITE! %%~i" goto APPS_INSTALL
    echo                                                      !RED!ERROR: !S_GREEN!"!choice!"!S_GRAY! is not a valid choice...
    timeout /t 3 /nobreak >nul 2>&1
    goto APPS_MENU
)
if /i "!choice!"=="b" goto MAIN_MENU
if /i "!choice!"=="back" goto MAIN_MENU
echo                                                      !RED!ERROR: !S_GREEN!"!choice!"!S_GRAY! is not a valid choice...
timeout /t 3 /nobreak >nul 2>&1
goto APPS_MENU

:APPS_INSTALL
REM WEB BROWSERS
if "!Google Chrome!"=="!S_MAGENTA![!S_GREEN!x!S_MAGENTA!]!S_WHITE! Google Chrome" call:CHOCO googlechrome
if "!Mozilla Firefox!"=="!S_MAGENTA![!S_GREEN!x!S_MAGENTA!]!S_WHITE! Mozilla Firefox" call:CHOCO firefox
if "!Brave!"=="!S_MAGENTA![!S_GREEN!x!S_MAGENTA!]!S_WHITE! Brave" call:CHOCO brave
if "!Opera GX!"=="!S_MAGENTA![!S_GREEN!x!S_MAGENTA!]!S_WHITE! Opera GX" call:CHOCO opera-gx
if "!Microsoft Edge!"=="!S_MAGENTA![!S_GREEN!x!S_MAGENTA!]!S_WHITE! Microsoft Edge" call:CHOCO microsoft-edge
if "!Vivaldi!"=="!S_MAGENTA![!S_GREEN!x!S_MAGENTA!]!S_WHITE! Vivaldi" call:CHOCO vivaldi
REM MEDIA
if "!Deezer!"=="!S_MAGENTA![!S_GREEN!x!S_MAGENTA!]!S_WHITE! Deezer" call:CHOCO deezer
if "!Spotify!"=="!S_MAGENTA![!S_GREEN!x!S_MAGENTA!]!S_WHITE! Spotify" call:CHOCO spotify
if "!iTunes!"=="!S_MAGENTA![!S_GREEN!x!S_MAGENTA!]!S_WHITE! iTunes" call:CHOCO itunes
if "!PotPlayer!"=="!S_MAGENTA![!S_GREEN!x!S_MAGENTA!]!S_WHITE! PotPlayer" call:CHOCO potplayer
if "!VLC media player!"=="!S_MAGENTA![!S_GREEN!x!S_MAGENTA!]!S_WHITE! VLC media player" call:CHOCO vlc
if "!Audacity!"=="!S_MAGENTA![!S_GREEN!x!S_MAGENTA!]!S_WHITE! Audacity" call:CHOCO audacity
if "!OBS Studio!"=="!S_MAGENTA![!S_GREEN!x!S_MAGENTA!]!S_WHITE! OBS Studio" call:CHOCO obs-studio
REM IMAGING
if "!ImageGlass!"=="!S_MAGENTA![!S_GREEN!x!S_MAGENTA!]!S_WHITE! ImageGlass" call:CHOCO imageglass
if "!ShareX!"=="!S_MAGENTA![!S_GREEN!x!S_MAGENTA!]!S_WHITE! ShareX" call:CHOCO sharex
if "!GIMP!"=="!S_MAGENTA![!S_GREEN!x!S_MAGENTA!]!S_WHITE! GIMP" call:CHOCO gimp
REM MESSAGING
if "!Discord!"=="!S_MAGENTA![!S_GREEN!x!S_MAGENTA!]!S_WHITE! Discord" call:CHOCO discord
if "!TeamSpeak!"=="!S_MAGENTA![!S_GREEN!x!S_MAGENTA!]!S_WHITE! TeamSpeak" call:CHOCO teamspeak
if "!Teams!"=="!S_MAGENTA![!S_GREEN!x!S_MAGENTA!]!S_WHITE! Teams" call:CHOCO microsoft-teams
if "!Zoom!"=="!S_MAGENTA![!S_GREEN!x!S_MAGENTA!]!S_WHITE! Zoom" call:CHOCO zoom
if "!Slack!"=="!S_MAGENTA![!S_GREEN!x!S_MAGENTA!]!S_WHITE! Slack" call:CHOCO slack
REM DOCUMENTS
if "!Adobe Acrobat Reader!"=="!S_MAGENTA![!S_GREEN!x!S_MAGENTA!]!S_WHITE! Adobe Acrobat Reader" call:CHOCO adobereader
if "!Foxit Reader!"=="!S_MAGENTA![!S_GREEN!x!S_MAGENTA!]!S_WHITE! Foxit Reader" call:CHOCO foxitreader
if "!Microsoft Office!"=="!S_MAGENTA![!S_GREEN!x!S_MAGENTA!]!S_WHITE! Microsoft Office" call:CHOCO office-tool & call:SHORTCUT "Office Tool Plus" "%UserProfile%\desktop" "%LocalAppData%\office-tool\Office Tool\Office Tool Plus.exe" "%LocalAppData%\office-tool\Office Tool"
if "!Libre Office!"=="!S_MAGENTA![!S_GREEN!x!S_MAGENTA!]!S_WHITE! Libre Office" call:CHOCO libreoffice-fresh
REM COMPRESSION
if "!7zip!"=="!S_MAGENTA![!S_GREEN!x!S_MAGENTA!]!S_WHITE! 7zip" call:CHOCO 7zip.install
if "!Winrar!"=="!S_MAGENTA![!S_GREEN!x!S_MAGENTA!]!S_WHITE! Winrar" call:CHOCO winrar
REM DEVELOPER TOOLS
if "!Visual Studio Code!"=="!S_MAGENTA![!S_GREEN!x!S_MAGENTA!]!S_WHITE! Visual Studio Code" call:CHOCO vscode
if "!Notepad++!"=="!S_MAGENTA![!S_GREEN!x!S_MAGENTA!]!S_WHITE! Notepad++" call:CHOCO notepadplusplus
if "!Github!"=="!S_MAGENTA![!S_GREEN!x!S_MAGENTA!]!S_WHITE! Github" call:CHOCO github-desktop
if "!Git!"=="!S_MAGENTA![!S_GREEN!x!S_MAGENTA!]!S_WHITE! Git" call:CHOCO git
if "!FileZilla!"=="!S_MAGENTA![!S_GREEN!x!S_MAGENTA!]!S_WHITE! FileZilla" call:CHOCO filezilla
if "!WinSCP!"=="!S_MAGENTA![!S_GREEN!x!S_MAGENTA!]!S_WHITE! WinSCP" call:CHOCO winscp
if "!PuTTY!"=="!S_MAGENTA![!S_GREEN!x!S_MAGENTA!]!S_WHITE! PuTTY" call:CHOCO putty & call:SHORTCUT "PuTTY" "%UserProfile%\desktop" "%ProgramData%\chocolatey\bin\PUTTY.exe" "\ProgramData\chocolatey\bin"
if "!Python 3!"=="!S_MAGENTA![!S_GREEN!x!S_MAGENTA!]!S_WHITE! Python 3" call:CHOCO python
if "!Java Runtime Environment 8!"=="!S_MAGENTA![!S_GREEN!x!S_MAGENTA!]!S_WHITE! Java Runtime Environment 8" call:CHOCO jre8
if "!Node.JS!"=="!S_MAGENTA![!S_GREEN!x!S_MAGENTA!]!S_WHITE! Node.JS" call:CHOCO nodejs
REM GAMES LAUNCHER
if "!Steam!"=="!S_MAGENTA![!S_GREEN!x!S_MAGENTA!]!S_WHITE! Steam" call:CHOCO steam
if "!GOG Galaxy!"=="!S_MAGENTA![!S_GREEN!x!S_MAGENTA!]!S_WHITE! GOG Galaxy" call:CHOCO goggalaxy
if "!Epic Games!"=="!S_MAGENTA![!S_GREEN!x!S_MAGENTA!]!S_WHITE! Epic Games" call:CHOCO epicgameslauncher
if "!Uplay!"=="!S_MAGENTA![!S_GREEN!x!S_MAGENTA!]!S_WHITE! Uplay" call:CHOCO uplay
if "!Battle.net!"=="!S_MAGENTA![!S_GREEN!x!S_MAGENTA!]!S_WHITE! Battle.net" call:CHOCO battle.net
if "!Origin!"=="!S_MAGENTA![!S_GREEN!x!S_MAGENTA!]!S_WHITE! Origin" call:CHOCO origin & call:SHORTCUT "Origin" "%UserProfile%\desktop" "\Program Files (x86)\Origin\Origin.exe" "\Program Files (x86)\Origin"
REM OTHERS
if "!VirtualBox!"=="!S_MAGENTA![!S_GREEN!x!S_MAGENTA!]!S_WHITE! VirtualBox" call:CHOCO virtualbox
if "!VMware Workstation Pro!"=="!S_MAGENTA![!S_GREEN!x!S_MAGENTA!]!S_WHITE! VMware Workstation Pro" call:CHOCO vmwareworkstation
if "!VMware Workstation Player!"=="!S_MAGENTA![!S_GREEN!x!S_MAGENTA!]!S_WHITE! VMware Workstation Player" call:CHOCO vmware-workstation-player
if "!TeamViewer!"=="!S_MAGENTA![!S_GREEN!x!S_MAGENTA!]!S_WHITE! TeamViewer" call:CHOCO teamviewer
if "!AnyDesk!"=="!S_MAGENTA![!S_GREEN!x!S_MAGENTA!]!S_WHITE! AnyDesk" call:CHOCO anydesk
if "!qBittorrent!"=="!S_MAGENTA![!S_GREEN!x!S_MAGENTA!]!S_WHITE! qBittorrent" call:CHOCO qbittorrent & call:SHORTCUT "qBittorrent" "%UserProfile%\desktop" "\Program Files\qBittorrent\qbittorrent.exe" "\Program Files\qBittorrent"
if "!Bulk Crap Uninstaller!"=="!S_MAGENTA![!S_GREEN!x!S_MAGENTA!]!S_WHITE! Bulk Crap Uninstaller" call:CHOCO bulk-crap-uninstaller
if "!Everything!"=="!S_MAGENTA![!S_GREEN!x!S_MAGENTA!]!S_WHITE! Everything" call:CHOCO everything
if "!MSI Afterburner!"=="!S_MAGENTA![!S_GREEN!x!S_MAGENTA!]!S_WHITE! MSI Afterburner" call:CHOCO msiafterburner
REM Recommended to install
if "!Visual C++ Redistributables!"=="!S_MAGENTA![!S_GREEN!x!S_MAGENTA!]!S_WHITE! Visual C++ Redistributables" call:CHOCO vcredist-all
if "!DirectX!"=="!S_MAGENTA![!S_GREEN!x!S_MAGENTA!]!S_WHITE! DirectX" call:CHOCO directx
if "!.NET Framework 4.8!"=="!S_MAGENTA![!S_GREEN!x!S_MAGENTA!]!S_WHITE! .NET Framework 4.8" call:CHOCO dotnetfx
goto APPS_MENU_CLEAR

REM =====================================================
REM ==================    FUNCTIONS    ==================
REM =====================================================

:SETCONSTANTS
REM Colors and text format
set "CMDLINE=RED=[31m,S_GRAY=[90m,S_RED=[91m,S_GREEN=[92m,S_YELLOW=[35m,S_MAGENTA=[95m,S_WHITE=[97m,B_BLACK=[40m,B_YELLOW=[43m,UNDERLINE=[4m,_UNDERLINE=[24m"
set "%CMDLINE:,=" & set "%"
REM ECHOX
for /f "tokens=2 delims==" %%I in ('wmic os get localdatetime /format:list') do set datetime=%%I
set datetime=!datetime:~0,8!-!datetime:~8,6!
REM User SID
for /f %%i in ('wmic path Win32_UserAccount where name^="%username%" get sid ^| findstr "S-"') do set "USER_SID=%%i"
goto:eof

:ECHOX
echo !S_WHITE!%time:~0,8% [!S_RED!INFO!S_WHITE!]:!S_GREEN! %*
goto:eof

:POWERSHELL
chcp 437 >nul 2>&1 & powershell -nop -noni -exec bypass -c %* >nul 2>&1 & chcp 65001 >nul 2>&1
goto:eof

:CHOCO [Package]
if not exist "%ProgramData%\chocolatey" call:POWERSHELL "iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))" && set "PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin" & call "%ProgramData%\chocolatey\bin\RefreshEnv.cmd"
choco install -y --limit-output --ignore-checksums %*
goto:eof

:MSGBOX [Text] [Argument] [Title]
echo WScript.Quit Msgbox(Replace("%~1","\n",vbCrLf),%~2,"%~3") >"%TMP%\msgbox.vbs"
cscript /nologo "%TMP%\msgbox.vbs"
set "exitCode=!ERRORLEVEL!" & del /f /q "%TMP%\msgbox.vbs" >nul 2>&1
exit /b %exitCode%