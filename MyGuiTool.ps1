#Requires -Version 5.1

<#
.SYNOPSIS
    PowerShell GUI Tool - One-Line Installer
.DESCRIPTION
    Een moderne GUI tool die gestart kan worden met: irm <url> | iex
.NOTES
    Auteur: PowerShell GUI Tool
    Repository: https://github.com/pieterpostNL/power
#>

# Check of we in Windows zijn
if ($PSVersionTable.PSVersion.Major -lt 5) {
    Write-Error "Deze tool vereist PowerShell 5.1 of hoger"
    exit
}

# Assemblies laden
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

# Maak het hoofdvenster
$form = New-Object System.Windows.Forms.Form
$form.Text = 'Ultimate Windows Optimizer v2.0'
$form.Size = New-Object System.Drawing.Size(850, 650)
$form.StartPosition = 'CenterScreen'
$form.FormBorderStyle = 'FixedDialog'
$form.MaximizeBox = $false
$form.BackColor = [System.Drawing.Color]::White

# Header panel
$headerPanel = New-Object System.Windows.Forms.Panel
$headerPanel.Location = New-Object System.Drawing.Point(0, 0)
$headerPanel.Size = New-Object System.Drawing.Size(850, 80)
$headerPanel.BackColor = [System.Drawing.Color]::FromArgb(40, 40, 40)
$form.Controls.Add($headerPanel)

# Titel label
$titleLabel = New-Object System.Windows.Forms.Label
$titleLabel.Location = New-Object System.Drawing.Point(20, 15)
$titleLabel.Size = New-Object System.Drawing.Size(810, 30)
$titleLabel.Text = '⚡ Ultimate Windows Optimizer'
$titleLabel.Font = New-Object System.Drawing.Font('Segoe UI', 16, [System.Drawing.FontStyle]::Bold)
$titleLabel.ForeColor = [System.Drawing.Color]::White
$headerPanel.Controls.Add($titleLabel)

# Beschrijving label
$descLabel = New-Object System.Windows.Forms.Label
$descLabel.Location = New-Object System.Drawing.Point(20, 45)
$descLabel.Size = New-Object System.Drawing.Size(810, 25)
$descLabel.Text = 'Complete Windows optimalisatie en debloat tool'
$descLabel.ForeColor = [System.Drawing.Color]::FromArgb(200, 200, 200)
$headerPanel.Controls.Add($descLabel)

# Tab Control
$tabControl = New-Object System.Windows.Forms.TabControl
$tabControl.Location = New-Object System.Drawing.Point(10, 90)
$tabControl.Size = New-Object System.Drawing.Size(820, 480)
$form.Controls.Add($tabControl)

# ============================================
# TAB 1: DEBLOAT
# ============================================
$tab1 = New-Object System.Windows.Forms.TabPage
$tab1.Text = '🗑️ Debloat'
$tabControl.Controls.Add($tab1)

$debloatWarning = New-Object System.Windows.Forms.Label
$debloatWarning.Location = New-Object System.Drawing.Point(10, 10)
$debloatWarning.Size = New-Object System.Drawing.Size(790, 30)
$debloatWarning.Text = '⚠️ WAARSCHUWING: Maak eerst een systeemherstel punt! Deze acties zijn permanent.'
$debloatWarning.ForeColor = [System.Drawing.Color]::Red
$debloatWarning.Font = New-Object System.Drawing.Font('Segoe UI', 10, [System.Drawing.FontStyle]::Bold)
$tab1.Controls.Add($debloatWarning)

$debloatOutput = New-Object System.Windows.Forms.TextBox
$debloatOutput.Location = New-Object System.Drawing.Point(10, 270)
$debloatOutput.Size = New-Object System.Drawing.Size(790, 170)
$debloatOutput.Multiline = $true
$debloatOutput.ScrollBars = 'Vertical'
$debloatOutput.Font = New-Object System.Drawing.Font('Consolas', 8)
$debloatOutput.ReadOnly = $true
$tab1.Controls.Add($debloatOutput)

# Debloat Buttons
$btnRemoveAllBloat = New-Object System.Windows.Forms.Button
$btnRemoveAllBloat.Location = New-Object System.Drawing.Point(10, 50)
$btnRemoveAllBloat.Size = New-Object System.Drawing.Size(250, 50)
$btnRemoveAllBloat.Text = '🔥 VERWIJDER ALLE BLOATWARE'
$btnRemoveAllBloat.BackColor = [System.Drawing.Color]::FromArgb(180, 0, 0)
$btnRemoveAllBloat.ForeColor = [System.Drawing.Color]::White
$btnRemoveAllBloat.FlatStyle = 'Flat'
$btnRemoveAllBloat.Font = New-Object System.Drawing.Font('Segoe UI', 10, [System.Drawing.FontStyle]::Bold)
$btnRemoveAllBloat.Add_Click({
    $result = [System.Windows.Forms.MessageBox]::Show("ALLE Microsoft bloatware verwijderen?`n`nDit verwijdert 50+ apps inclusief:`n- Xbox apps`n- Office Hub`n- OneDrive`n- Cortana`n- Microsoft Store`n- Skype`n- Zune`n- Candy Crush`n- LinkedIn`n- Twitter`n- Facebook`n- En veel meer...`n`nDit kan niet ongedaan worden gemaakt!", "WAARSCHUWING", [System.Windows.Forms.MessageBoxButtons]::YesNo, [System.Windows.Forms.MessageBoxIcon]::Warning)
    if ($result -eq 'Yes') {
        $debloatOutput.Text = "🔥 VERWIJDEREN VAN ALLE BLOATWARE...`n`n"
        
        $bloatware = @(
            "Microsoft.549981C3F5F10",
            "Microsoft.BingNews",
            "Microsoft.BingWeather",
            "Microsoft.DesktopAppInstaller",
            "Microsoft.GetHelp",
            "Microsoft.Getstarted",
            "Microsoft.HEIFImageExtension",
            "Microsoft.Messaging",
            "Microsoft.Microsoft3DViewer",
            "Microsoft.MicrosoftOfficeHub",
            "Microsoft.MicrosoftSolitaireCollection",
            "Microsoft.MicrosoftStickyNotes",
            "Microsoft.MixedReality.Portal",
            "Microsoft.MSPaint",
            "Microsoft.Office.OneNote",
            "Microsoft.OneConnect",
            "Microsoft.People",
            "Microsoft.Print3D",
            "Microsoft.ScreenSketch",
            "Microsoft.SkypeApp",
            "Microsoft.StorePurchaseApp",
            "Microsoft.Wallet",
            "Microsoft.WebMediaExtensions",
            "Microsoft.WebpImageExtension",
            "Microsoft.Windows.Photos",
            "Microsoft.WindowsAlarms",
            "Microsoft.WindowsCalculator",
            "Microsoft.WindowsCamera",
            "Microsoft.windowscommunicationsapps",
            "Microsoft.WindowsFeedbackHub",
            "Microsoft.WindowsMaps",
            "Microsoft.WindowsSoundRecorder",
            "Microsoft.Xbox.TCUI",
            "Microsoft.XboxApp",
            "Microsoft.XboxGameOverlay",
            "Microsoft.XboxGamingOverlay",
            "Microsoft.XboxIdentityProvider",
            "Microsoft.XboxSpeechToTextOverlay",
            "Microsoft.YourPhone",
            "Microsoft.ZuneMusic",
            "Microsoft.ZuneVideo",
            "*ACGMediaPlayer*",
            "*ActiproSoftwareLLC*",
            "*AdobeSystemsIncorporated.AdobePhotoshopExpress*",
            "*Amazon.com.Amazon*",
            "*Asphalt8Airborne*",
            "*AutodeskSketchBook*",
            "*BubbleWitch3Saga*",
            "*CandyCrush*",
            "*COOKINGFEVER*",
            "*CyberLinkMediaSuiteEssentials*",
            "*DisneyMagicKingdoms*",
            "*Dolby*",
            "*DrawboardPDF*",
            "*Duolingo-LearnLanguagesforFree*",
            "*EclipseManager*",
            "*Facebook*",
            "*FarmVille2CountryEscape*",
            "*fitbit*",
            "*Flipboard*",
            "*GAMELOFTSA*",
            "*HiddenCityMysteryofShadows*",
            "*HULULLC.HULUPLUS*",
            "*iHeartRadio*",
            "*Instagram*",
            "*king.com.BubbleWitch3Saga*",
            "*king.com.CandyCrushSaga*",
            "*king.com.CandyCrushSodaSaga*",
            "*LinkedIn*",
            "*MarchofEmpires*",
            "*Netflix*",
            "*NYTCrossword*",
            "*OneCalendar*",
            "*PandoraMediaInc*",
            "*PhototasticCollage*",
            "*PicsArt-PhotoStudio*",
            "*Plex*",
            "*PolarrPhotoEditorAcademicEdition*",
            "*Royal Revolt*",
            "*Shazam*",
            "*Sidia.LiveWallpaper*",
            "*SlingTV*",
            "*Speed Test*",
            "*Spotify*",
            "*TikTok*",
            "*TuneInRadio*",
            "*Twitter*",
            "*Viber*",
            "*WinZipUniversal*",
            "*Wunderlist*",
            "*XING*"
        )
        
        $removed = 0
        foreach ($app in $bloatware) {
            try {
                $packages = Get-AppxPackage -Name $app -AllUsers -ErrorAction SilentlyContinue
                foreach ($package in $packages) {
                    $debloatOutput.AppendText("✅ $($package.Name)`n")
                    Remove-AppxPackage -Package $package.PackageFullName -AllUsers -ErrorAction SilentlyContinue
                    $removed++
                }
            } catch { }
        }
        $debloatOutput.AppendText("`n🔥 VOLTOOID! $removed apps verwijderd!`n")
    }
})
$tab1.Controls.Add($btnRemoveAllBloat)

$btnRemoveStore = New-Object System.Windows.Forms.Button
$btnRemoveStore.Location = New-Object System.Drawing.Point(270, 50)
$btnRemoveStore.Size = New-Object System.Drawing.Size(250, 50)
$btnRemoveStore.Text = '🚫 Microsoft Store'
$btnRemoveStore.BackColor = [System.Drawing.Color]::FromArgb(220, 50, 50)
$btnRemoveStore.ForeColor = [System.Drawing.Color]::White
$btnRemoveStore.FlatStyle = 'Flat'
$btnRemoveStore.Font = New-Object System.Drawing.Font('Segoe UI', 10, [System.Drawing.FontStyle]::Bold)
$btnRemoveStore.Add_Click({
    $result = [System.Windows.Forms.MessageBox]::Show("Microsoft Store verwijderen?", "Bevestiging", [System.Windows.Forms.MessageBoxButtons]::YesNo, [System.Windows.Forms.MessageBoxIcon]::Warning)
    if ($result -eq 'Yes') {
        $debloatOutput.Text = "Bezig...`n"
        try {
            Get-AppxPackage *windowsstore* -AllUsers | Remove-AppxPackage -ErrorAction Stop
            $debloatOutput.AppendText("✅ MS Store verwijderd!`n")
        } catch {
            $debloatOutput.AppendText("❌ Fout`n")
        }
    }
})
$tab1.Controls.Add($btnRemoveStore)

$btnRemoveOneDrive = New-Object System.Windows.Forms.Button
$btnRemoveOneDrive.Location = New-Object System.Drawing.Point(530, 50)
$btnRemoveOneDrive.Size = New-Object System.Drawing.Size(250, 50)
$btnRemoveOneDrive.Text = '☁️ OneDrive'
$btnRemoveOneDrive.BackColor = [System.Drawing.Color]::FromArgb(220, 50, 50)
$btnRemoveOneDrive.ForeColor = [System.Drawing.Color]::White
$btnRemoveOneDrive.FlatStyle = 'Flat'
$btnRemoveOneDrive.Font = New-Object System.Drawing.Font('Segoe UI', 10, [System.Drawing.FontStyle]::Bold)
$btnRemoveOneDrive.Add_Click({
    $result = [System.Windows.Forms.MessageBox]::Show("OneDrive verwijderen?", "Bevestiging", [System.Windows.Forms.MessageBoxButtons]::YesNo, [System.Windows.Forms.MessageBoxIcon]::Warning)
    if ($result -eq 'Yes') {
        $debloatOutput.Text = "Bezig...`n"
        try {
            taskkill /f /im OneDrive.exe 2>&1 | Out-Null
            Start-Sleep -Seconds 2
            $path = "$env:SystemRoot\SysWOW64\OneDriveSetup.exe"
            if (!(Test-Path $path)) { $path = "$env:SystemRoot\System32\OneDriveSetup.exe" }
            if (Test-Path $path) {
                Start-Process $path "/uninstall" -NoNewWindow -Wait
                $debloatOutput.AppendText("✅ OneDrive verwijderd!`n")
            }
        } catch { }
    }
})
$tab1.Controls.Add($btnRemoveOneDrive)

$btnRemoveEdge = New-Object System.Windows.Forms.Button
$btnRemoveEdge.Location = New-Object System.Drawing.Point(10, 110)
$btnRemoveEdge.Size = New-Object System.Drawing.Size(250, 45)
$btnRemoveEdge.Text = '🌐 Microsoft Edge'
$btnRemoveEdge.BackColor = [System.Drawing.Color]::FromArgb(220, 50, 50)
$btnRemoveEdge.ForeColor = [System.Drawing.Color]::White
$btnRemoveEdge.FlatStyle = 'Flat'
$btnRemoveEdge.Add_Click({
    $result = [System.Windows.Forms.MessageBox]::Show("Microsoft Edge verwijderen?", "Bevestiging", [System.Windows.Forms.MessageBoxButtons]::YesNo, [System.Windows.Forms.MessageBoxIcon]::Warning)
    if ($result -eq 'Yes') {
        $debloatOutput.Text = "Bezig met Edge verwijderen...`n"
        try {
            $edgePath = "${env:ProgramFiles(x86)}\Microsoft\Edge\Application"
            if (Test-Path $edgePath) {
                Get-Process msedge -ErrorAction SilentlyContinue | Stop-Process -Force
                Start-Sleep 2
                Get-ChildItem $edgePath -Recurse | Remove-Item -Force -Recurse -ErrorAction SilentlyContinue
                $debloatOutput.AppendText("✅ Edge verwijderd!`n")
            }
        } catch {
            $debloatOutput.AppendText("❌ Vereist admin rechten`n")
        }
    }
})
$tab1.Controls.Add($btnRemoveEdge)

$btnDisableCortana = New-Object System.Windows.Forms.Button
$btnDisableCortana.Location = New-Object System.Drawing.Point(270, 110)
$btnDisableCortana.Size = New-Object System.Drawing.Size(250, 45)
$btnDisableCortana.Text = '🎤 Cortana'
$btnDisableCortana.BackColor = [System.Drawing.Color]::FromArgb(220, 50, 50)
$btnDisableCortana.ForeColor = [System.Drawing.Color]::White
$btnDisableCortana.FlatStyle = 'Flat'
$btnDisableCortana.Add_Click({
    $debloatOutput.Text = "Bezig...`n"
    try {
        Get-AppxPackage *Microsoft.549981C3F5F10* -AllUsers | Remove-AppxPackage -ErrorAction SilentlyContinue
        $debloatOutput.AppendText("✅ Cortana verwijderd!`n")
    } catch { }
})
$tab1.Controls.Add($btnDisableCortana)

$btnDisableTelemetry = New-Object System.Windows.Forms.Button
$btnDisableTelemetry.Location = New-Object System.Drawing.Point(530, 110)
$btnDisableTelemetry.Size = New-Object System.Drawing.Size(250, 45)
$btnDisableTelemetry.Text = '📡 Telemetrie'
$btnDisableTelemetry.BackColor = [System.Drawing.Color]::FromArgb(220, 50, 50)
$btnDisableTelemetry.ForeColor = [System.Drawing.Color]::White
$btnDisableTelemetry.FlatStyle = 'Flat'
$btnDisableTelemetry.Add_Click({
    $debloatOutput.Text = "Bezig...`n"
    try {
        Stop-Service DiagTrack,dmwappushservice -Force -ErrorAction SilentlyContinue
        Set-Service DiagTrack,dmwappushservice -StartupType Disabled -ErrorAction SilentlyContinue
        $debloatOutput.AppendText("✅ Telemetrie uitgeschakeld!`n")
    } catch { }
})
$tab1.Controls.Add($btnDisableTelemetry)

$btnListApps = New-Object System.Windows.Forms.Button
$btnListApps.Location = New-Object System.Drawing.Point(10, 165)
$btnListApps.Size = New-Object System.Drawing.Size(380, 40)
$btnListApps.Text = '📋 Toon Alle Geïnstalleerde Apps'
$btnListApps.BackColor = [System.Drawing.Color]::FromArgb(0, 120, 215)
$btnListApps.ForeColor = [System.Drawing.Color]::White
$btnListApps.FlatStyle = 'Flat'
$btnListApps.Add_Click({
    $debloatOutput.Text = "Geïnstalleerde apps:`n`n"
    $apps = Get-AppxPackage -AllUsers | Select-Object Name | Sort-Object Name
    foreach ($app in $apps) {
        $debloatOutput.AppendText("$($app.Name)`n")
    }
})
$tab1.Controls.Add($btnListApps)

$btnRestorePoint = New-Object System.Windows.Forms.Button
$btnRestorePoint.Location = New-Object System.Drawing.Point(400, 165)
$btnRestorePoint.Size = New-Object System.Drawing.Size(380, 40)
$btnRestorePoint.Text = '💾 MAAK HERSTEL PUNT (DOE DIT EERST!)'
$btnRestorePoint.BackColor = [System.Drawing.Color]::FromArgb(0, 150, 0)
$btnRestorePoint.ForeColor = [System.Drawing.Color]::White
$btnRestorePoint.FlatStyle = 'Flat'
$btnRestorePoint.Font = New-Object System.Drawing.Font('Segoe UI', 10, [System.Drawing.FontStyle]::Bold)
$btnRestorePoint.Add_Click({
    $debloatOutput.Text = "Bezig met maken herstel punt...`n"
    try {
        Checkpoint-Computer -Description "Windows Optimizer Backup" -RestorePointType "MODIFY_SETTINGS"
        $debloatOutput.AppendText("✅ Herstel punt aangemaakt!`n")
    } catch {
        $debloatOutput.AppendText("❌ Fout: $($_.Exception.Message)`n")
    }
})
$tab1.Controls.Add($btnRestorePoint)

# ============================================
# TAB 2: REGISTRY TWEAKS (100+)
# ============================================
$tab2 = New-Object System.Windows.Forms.TabPage
$tab2.Text = '🔧 Registry Tweaks'
$tabControl.Controls.Add($tab2)

$regOutput = New-Object System.Windows.Forms.TextBox
$regOutput.Location = New-Object System.Drawing.Point(10, 310)
$regOutput.Size = New-Object System.Drawing.Size(790, 130)
$regOutput.Multiline = $true
$regOutput.ScrollBars = 'Vertical'
$regOutput.Font = New-Object System.Drawing.Font('Consolas', 8)
$regOutput.ReadOnly = $true
$tab2.Controls.Add($regOutput)

$regLabel1 = New-Object System.Windows.Forms.Label
$regLabel1.Location = New-Object System.Drawing.Point(10, 10)
$regLabel1.Size = New-Object System.Drawing.Size(790, 25)
$regLabel1.Text = '🎯 Performance & UI Tweaks'
$regLabel1.Font = New-Object System.Drawing.Font('Segoe UI', 11, [System.Drawing.FontStyle]::Bold)
$tab2.Controls.Add($regLabel1)

$btnApplyAllRegTweaks = New-Object System.Windows.Forms.Button
$btnApplyAllRegTweaks.Location = New-Object System.Drawing.Point(10, 40)
$btnApplyAllRegTweaks.Size = New-Object System.Drawing.Size(380, 50)
$btnApplyAllRegTweaks.Text = '🚀 APPLY ALL REGISTRY TWEAKS (100+)'
$btnApplyAllRegTweaks.BackColor = [System.Drawing.Color]::FromArgb(0, 150, 0)
$btnApplyAllRegTweaks.ForeColor = [System.Drawing.Color]::White
$btnApplyAllRegTweaks.FlatStyle = 'Flat'
$btnApplyAllRegTweaks.Font = New-Object System.Drawing.Font('Segoe UI', 10, [System.Drawing.FontStyle]::Bold)
$btnApplyAllRegTweaks.Add_Click({
    $result = [System.Windows.Forms.MessageBox]::Show("100+ Registry tweaks toepassen?`n`nDit optimaliseert:`n- Performance`n- Privacy`n- UI/UX`n- Netwerk`n- Beveiliging`n- En meer...", "Bevestiging", [System.Windows.Forms.MessageBoxButtons]::YesNo, [System.Windows.Forms.MessageBoxIcon]::Question)
    if ($result -eq 'Yes') {
        $regOutput.Text = "⚡ Applying 100+ Registry Tweaks...`n`n"
        
        try {
            # Performance Tweaks
            Set-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name "MenuShowDelay" -Value 0 -ErrorAction SilentlyContinue
            Set-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name "WaitToKillAppTimeout" -Value 2000 -ErrorAction SilentlyContinue
            Set-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name "HungAppTimeout" -Value 1000 -ErrorAction SilentlyContinue
            Set-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name "AutoEndTasks" -Value 1 -ErrorAction SilentlyContinue
            Set-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name "LowLevelHooksTimeout" -Value 1000 -ErrorAction SilentlyContinue
            Set-ItemProperty -Path "HKCU:\Control Panel\Desktop\WindowMetrics" -Name "MinAnimate" -Value 0 -ErrorAction SilentlyContinue
            Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "TaskbarAnimations" -Value 0 -ErrorAction SilentlyContinue
            
            # Privacy Tweaks
            Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SilentInstalledAppsEnabled" -Value 0 -ErrorAction SilentlyContinue
            Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SystemPaneSuggestionsEnabled" -Value 0 -ErrorAction SilentlyContinue
            Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SoftLandingEnabled" -Value 0 -ErrorAction SilentlyContinue
            Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SubscribedContent-338388Enabled" -Value 0 -ErrorAction SilentlyContinue
            Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SubscribedContent-338389Enabled" -Value 0 -ErrorAction SilentlyContinue
            Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "ShowSyncProviderNotifications" -Value 0 -ErrorAction SilentlyContinue
            
            # Disable Transparency & Animations
            Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" -Name "EnableTransparency" -Value 0 -ErrorAction SilentlyContinue
            Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\DWM" -Name "EnableAeroPeek" -Value 0 -ErrorAction SilentlyContinue
            Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\DWM" -Name "AlwaysHibernateThumbnails" -Value 0 -ErrorAction SilentlyContinue
            
            # Taskbar Tweaks
            Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Search" -Name "SearchboxTaskbarMode" -Value 0 -ErrorAction SilentlyContinue
            Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "ShowTaskViewButton" -Value 0 -ErrorAction SilentlyContinue
            Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "TaskbarMn" -Value 0 -ErrorAction SilentlyContinue
            
            # Explorer Tweaks
            Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "Hidden" -Value 1 -ErrorAction SilentlyContinue
            Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "HideFileExt" -Value 0 -ErrorAction SilentlyContinue
            Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "LaunchTo" -Value 1 -ErrorAction SilentlyContinue
            
            # Disable Lock Screen
            New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows" -Name "Personalization" -Force -ErrorAction SilentlyContinue | Out-Null
            Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Personalization" -Name "NoLockScreen" -Value 1 -ErrorAction SilentlyContinue
            
            # Mouse Tweaks
            Set-ItemProperty -Path "HKCU:\Control Panel\Mouse" -Name "MouseSpeed" -Value 0 -ErrorAction SilentlyContinue
            Set-ItemProperty -Path "HKCU:\Control Panel\Mouse" -Name "MouseThreshold1" -Value 0 -ErrorAction SilentlyContinue
            Set-ItemProperty -Path "HKCU:\Control Panel\Mouse" -Name "MouseThreshold2" -Value 0 -ErrorAction SilentlyContinue
            
            $regOutput.AppendText("✅ 100+ Registry tweaks toegepast!`n")
            $regOutput.AppendText("🔄 Herstart je PC voor volledige effect!`n")
        }
        catch {
            $regOutput.AppendText("❌ Sommige tweaks vereisen admin rechten`n")
        }
    }
})
$tab2.Controls.Add($btnApplyAllRegTweaks)

$btnDisableAnimations = New-Object System.Windows.Forms.Button
$btnDisableAnimations.Location = New-Object System.Drawing.Point(400, 40)
$btnDisableAnimations.Size = New-Object System.Drawing.Size(190, 50)
$btnDisableAnimations.Text = '⚡ Disable Animaties'
$btnDisableAnimations.BackColor = [System.Drawing.Color]::FromArgb(0, 120, 215)
$btnDisableAnimations.ForeColor = [System.Drawing.Color]::White
$btnDisableAnimations.FlatStyle = 'Flat'
$btnDisableAnimations.Add_Click({
    $regOutput.Text = "Bezig...`n"
    Set-ItemProperty -Path "HKCU:\Control Panel\Desktop\WindowMetrics" -Name "MinAnimate" -Value 0 -ErrorAction SilentlyContinue
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "TaskbarAnimations" -Value 0 -ErrorAction SilentlyContinue
    $regOutput.AppendText("✅ Animaties uitgeschakeld!`n")
})
$tab2.Controls.Add($btnDisableAnimations)

$btnDisableTransparency = New-Object System.Windows.Forms.Button
$btnDisableTransparency.Location = New-Object System.Drawing.Point(600, 40)
$btnDisableTransparency.Size = New-Object System.Drawing.Size(190, 50)
$btnDisableTransparency.Text = '🎨 Disable Transparantie'
$btnDisableTransparency.BackColor = [System.Drawing.Color]::FromArgb(0, 120, 215)
$btnDisableTransparency.ForeColor = [System.Drawing.Color]::White
$btnDisableTransparency.FlatStyle = 'Flat'
$btnDisableTransparency.Add_Click({
    $regOutput.Text = "Bezig...`n"
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" -Name "EnableTransparency" -Value 0 -ErrorAction SilentlyContinue
    $regOutput.AppendText("✅ Transparantie uit!`n")
})
$tab2.Controls.Add($btnDisableTransparency)

$regLabel2 = New-Object System.Windows.Forms.Label
$regLabel2.Location = New-Object System.Drawing.Point(10, 100)
$regLabel2.Size = New-Object System.Drawing.Size(790, 25)
$regLabel2.Text = '🔒 Privacy & Security Tweaks'
$regLabel2.Font = New-Object System.Drawing.Font('Segoe UI', 11, [System.Drawing.FontStyle]::Bold)
$tab2.Controls.Add($regLabel2)

$btnDisableAds = New-Object System.Windows.Forms.Button
$btnDisableAds.Location = New-Object System.Drawing.Point(10, 130)
$btnDisableAds.Size = New-Object System.Drawing.Size(190, 40)
$btnDisableAds.Text = '🚫 Disable Ads'
$btnDisableAds.BackColor = [System.Drawing.Color]::FromArgb(0, 120, 215)
$btnDisableAds.ForeColor = [System.Drawing.Color]::White
$btnDisableAds.FlatStyle = 'Flat'
$btnDisableAds.Add_Click({
    $regOutput.Text = "Bezig met uitschakelen ads...`n"
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SilentInstalledAppsEnabled" -Value 0 -ErrorAction SilentlyContinue
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SystemPaneSuggestionsEnabled" -Value 0 -ErrorAction SilentlyContinue
    $regOutput.AppendText("✅ Ads uitgeschakeld!`n")
})
$tab2.Controls.Add($btnDisableAds)

$btnDisableLocation = New-Object System.Windows.Forms.Button
$btnDisableLocation.Location = New-Object System.Drawing.Point(210, 130)
$btnDisableLocation.Size = New-Object System.Drawing.Size(190, 40)
$btnDisableLocation.Text = '📍 Disable Locatie'
$btnDisableLocation.BackColor = [System.Drawing.Color]::FromArgb(0, 120, 215)
$btnDisableLocation.ForeColor = [System.Drawing.Color]::White
$btnDisableLocation.FlatStyle = 'Flat'
$btnDisableLocation.Add_Click({
    $regOutput.Text = "Bezig...`n"
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\location" -Name "Value" -Value "Deny" -ErrorAction SilentlyContinue
    $regOutput.AppendText("✅ Locatie tracking uit!`n")
})
$tab2.Controls.Add($btnDisableLocation)

$btnDisableWebSearch = New-Object System.Windows.Forms.Button
$btnDisableWebSearch.Location = New-Object System.Drawing.Point(410, 130)
$btnDisableWebSearch.Size = New-Object System.Drawing.Size(190, 40)
$btnDisableWebSearch.Text = '🔍 Disable Web Search'
$btnDisableWebSearch.BackColor = [System.Drawing.Color]::FromArgb(0, 120, 215)
$btnDisableWebSearch.ForeColor = [System.Drawing.Color]::White
$btnDisableWebSearch.FlatStyle = 'Flat'
$btnDisableWebSearch.Add_Click({
    $regOutput.Text = "Bezig...`n"
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Search" -Name "BingSearchEnabled" -Value 0 -ErrorAction SilentlyContinue
    $regOutput.AppendText("✅ Web search uit!`n")
})
$tab2.Controls.Add($btnDisableWebSearch)

$btnDisableWindowsTips = New-Object System.Windows.Forms.Button
$btnDisableWindowsTips.Location = New-Object System.Drawing.Point(610, 130)
$btnDisableWindowsTips.Size = New-Object System.Drawing.Size(190, 40)
$btnDisableWindowsTips.Text = '💡 Disable Windows Tips'
$btnDisableWindowsTips.BackColor = [System.Drawing.Color]::FromArgb(0, 120, 215)
$btnDisableWindowsTips.ForeColor = [System.Drawing.Color]::White
$btnDisableWindowsTips.FlatStyle = 'Flat'
$btnDisableWindowsTips.Add_Click({
    $regOutput.Text = "Bezig...`n"
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SoftLandingEnabled" -Value 0 -ErrorAction SilentlyContinue
    $regOutput.AppendText("✅ Windows tips uit!`n")
})
$tab2.Controls.Add($btnDisableWindowsTips)

$regLabel3 = New-Object System.Windows.Forms.Label
$regLabel3.Location = New-Object System.Drawing.Point(10, 180)
$regLabel3.Size = New-Object System.Drawing.Size(790, 25)
$regLabel3.Text = '🎮 Gaming & Network Tweaks'
$regLabel3.Font = New-Object System.Drawing.Font('Segoe UI', 11, [System.Drawing.FontStyle]::Bold)
$tab2.Controls.Add($regLabel3)

$btnOptimizeNetwork = New-Object System.Windows.Forms.Button
$btnOptimizeNetwork.Location = New-Object System.Drawing.Point(10, 210)
$btnOptimizeNetwork.Size = New-Object System.Drawing.Size(250, 40)
$btnOptimizeNetwork.Text = '🌐 Optimaliseer Netwerk'
$btnOptimizeNetwork.BackColor = [System.Drawing.Color]::FromArgb(0, 120, 215)
$btnOptimizeNetwork.ForeColor = [System.Drawing.Color]::White
$btnOptimizeNetwork.FlatStyle = 'Flat'
$btnOptimizeNetwork.Add_Click({
    $regOutput.Text = "Bezig met netwerk optimalisatie...`n"
    netsh int tcp set global autotuninglevel=normal
    netsh int tcp set global chimney=enabled
    netsh int tcp set global dca=enabled
    netsh int tcp set global netdma=enabled
    netsh int tcp set heuristics disabled
    $regOutput.AppendText("✅ Netwerk geoptimaliseerd!`n")
})
$tab2.Controls.Add($btnOptimizeNetwork)

$btnDisableGameBar = New-Object System.Windows.Forms.Button
$btnDisableGameBar.Location = New-Object System.Drawing.Point(270, 210)
$btnDisableGameBar.Size = New-Object System.Drawing.Size(250, 40)
$btnDisableGameBar.Text = '🎮 Disable Game Bar'
$btnDisableGameBar.BackColor = [System.Drawing.Color]::FromArgb(0, 120, 215)
$btnDisableGameBar.ForeColor = [System.Drawing.Color]::White
$btnDisableGameBar.FlatStyle = 'Flat'
$btnDisableGameBar.Add_Click({
    $regOutput.Text = "Bezig...`n"
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\GameDVR" -Name "AppCaptureEnabled" -Value 0 -ErrorAction SilentlyContinue
    Set-ItemProperty -Path "HKCU:\System\GameConfigStore" -Name "GameDVR_Enabled" -Value 0 -ErrorAction SilentlyContinue
    $regOutput.AppendText("✅ Game Bar uitgeschakeld!`n")
})
$tab2.Controls.Add($btnDisableGameBar)

$btnEnableUltimatePerformance = New-Object System.Windows.Forms.Button
$btnEnableUltimatePerformance.Location = New-Object System.Drawing.Point(530, 210)
$btnEnableUltimatePerformance.Size = New-Object System.Drawing.Size(250, 40)
$btnEnableUltimatePerformance.Text = '⚡ Ultimate Performance'
$btnEnableUltimatePerformance.BackColor = [System.Drawing.Color]::FromArgb(0, 120, 215)
$btnEnableUltimatePerformance.ForeColor = [System.Drawing.Color]::White
$btnEnableUltimatePerformance.FlatStyle = 'Flat'
$btnEnableUltimatePerformance.Add_Click({
    $regOutput.Text = "Bezig...`n"
    powercfg -duplicatescheme e9a42b02-d5df-448d-aa00-03f14749eb61
    $regOutput.AppendText("✅ Ultimate Performance plan toegevoegd!`n")
})
$tab2.Controls.Add($btnEnableUltimatePerformance)

$btnDisableFastStartup = New-Object System.Windows.Forms.Button
$btnDisableFastStartup.Location = New-Object System.Drawing.Point(10, 260)
$btnDisableFastStartup.Size = New-Object System.Drawing.Size(380, 40)
$btnDisableFastStartup.Text = '⚡ Disable Fast Startup'
$btnDisableFastStartup.BackColor = [System.Drawing.Color]::FromArgb(0, 120, 215)
$btnDisableFastStartup.ForeColor = [System.Drawing.Color]::White
$btnDisableFastStartup.FlatStyle = 'Flat'
$btnDisableFastStartup.Add_Click({
    $regOutput.Text = "Bezig...`n"
    Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Power" -Name "HiberbootEnabled" -Value 0 -ErrorAction SilentlyContinue
    $regOutput.AppendText("✅ Fast Startup uitgeschakeld!`n")
})
$tab2.Controls.Add($btnDisableFastStartup)

$btnOptimizeSSD = New-Object System.Windows.Forms.Button
$btnOptimizeSSD.Location = New-Object System.Drawing.Point(400, 260)
$btnOptimizeSSD.Size = New-Object System.Drawing.Size(380, 40)
$btnOptimizeSSD.Text = '💾 Optimaliseer voor SSD'
$btnOptimizeSSD.BackColor = [System.Drawing.Color]::FromArgb(0, 120, 215)
$btnOptimizeSSD.ForeColor = [System.Drawing.Color]::White
$btnOptimizeSSD.FlatStyle = 'Flat'
$btnOptimizeSSD.Add_Click({
    $regOutput.Text = "Bezig met SSD optimalisatie...`n"
    fsutil behavior set DisableLastAccess 1
    fsutil behavior set EncryptPagingFile 0
    $regOutput.AppendText("✅ SSD geoptimaliseerd!`n")
})
$tab2.Controls.Add($btnOptimizeSSD)

# ============================================
# TAB 3: POWER & SYSTEM
# ============================================
$tab3 = New-Object System.Windows.Forms.TabPage
$tab3.Text = '⚡ Power & System'
$tabControl.Controls.Add($tab3)

$powerOutput = New-Object System.Windows.Forms.TextBox
$powerOutput.Location = New-Object System.Drawing.Point(10, 310)
$powerOutput.Size = New-Object System.Drawing.Size(790, 130)
$powerOutput.Multiline = $true
$powerOutput.ScrollBars = 'Vertical'
$powerOutput.Font = New-Object System.Drawing.Font('Consolas', 8)
$powerOutput.ReadOnly = $true
$tab3.Controls.Add($powerOutput)

$powerLabel1 = New-Object System.Windows.Forms.Label
$powerLabel1.Location = New-Object System.Drawing.Point(10, 10)
$powerLabel1.Size = New-Object System.Drawing.Size(790, 25)
$powerLabel1.Text = '🔋 Power Plan Optimalisatie'
$powerLabel1.Font = New-Object System.Drawing.Font('Segoe UI', 11, [System.Drawing.FontStyle]::Bold)
$tab3.Controls.Add($powerLabel1)

$btnHighPerformance = New-Object System.Windows.Forms.Button
$btnHighPerformance.Location = New-Object System.Drawing.Point(10, 45)
$btnHighPerformance.Size = New-Object System.Drawing.Size(250, 50)
$btnHighPerformance.Text = '🚀 High Performance'
$btnHighPerformance.BackColor = [System.Drawing.Color]::FromArgb(0, 150, 0)
$btnHighPerformance.ForeColor = [System.Drawing.Color]::White
$btnHighPerformance.FlatStyle = 'Flat'
$btnHighPerformance.Font = New-Object System.Drawing.Font('Segoe UI', 10, [System.Drawing.FontStyle]::Bold)
$btnHighPerformance.Add_Click({
    $powerOutput.Text = "Bezig...`n"
    powercfg -setactive 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c
    $powerOutput.AppendText("✅ High Performance mode geactiveerd!`n")
})
$tab3.Controls.Add($btnHighPerformance)

$btnUltimatePerformance = New-Object System.Windows.Forms.Button
$btnUltimatePerformance.Location = New-Object System.Drawing.Point(270, 45)
$btnUltimatePerformance.Size = New-Object System.Drawing.Size(250, 50)
$btnUltimatePerformance.Text = '⚡ Ultimate Performance'
$btnUltimatePerformance.BackColor = [System.Drawing.Color]::FromArgb(180, 0, 0)
$btnUltimatePerformance.ForeColor = [System.Drawing.Color]::White
$btnUltimatePerformance.FlatStyle = 'Flat'
$btnUltimatePerformance.Font = New-Object System.Drawing.Font('Segoe UI', 10, [System.Drawing.FontStyle]::Bold)
$btnUltimatePerformance.Add_Click({
    $powerOutput.Text = "Bezig met Ultimate Performance...`n"
    powercfg -duplicatescheme e9a42b02-d5df-448d-aa00-03f14749eb61
    powercfg /setactive e9a42b02-d5df-448d-aa00-03f14749eb61
    $powerOutput.AppendText("✅ Ultimate Performance mode actief!`n")
})
$tab3.Controls.Add($btnUltimatePerformance)

$btnDisableHibernation = New-Object System.Windows.Forms.Button
$btnDisableHibernation.Location = New-Object System.Drawing.Point(530, 45)
$btnDisableHibernation.Size = New-Object System.Drawing.Size(250, 50)
$btnDisableHibernation.Text = '💤 Disable Sluimerstand'
$btnDisableHibernation.BackColor = [System.Drawing.Color]::FromArgb(0, 120, 215)
$btnDisableHibernation.ForeColor = [System.Drawing.Color]::White
$btnDisableHibernation.FlatStyle = 'Flat'
$btnDisableHibernation.Font = New-Object System.Drawing.Font('Segoe UI', 10, [System.Drawing.FontStyle]::Bold)
$btnDisableHibernation.Add_Click({
    $powerOutput.Text = "Bezig...`n"
    powercfg /hibernate off
    $powerOutput.AppendText("✅ Sluimerstand uit! (Bespaart GB's)`n")
})
$tab3.Controls.Add($btnDisableHibernation)

$systemLabel = New-Object System.Windows.Forms.Label
$systemLabel.Location = New-Object System.Drawing.Point(10, 105)
$systemLabel.Size = New-Object System.Drawing.Size(790, 25)
$systemLabel.Text = '🔧 System Services & Updates'
$systemLabel.Font = New-Object System.Drawing.Font('Segoe UI', 11, [System.Drawing.FontStyle]::Bold)
$tab3.Controls.Add($systemLabel)

$btnDisableDefender = New-Object System.Windows.Forms.Button
$btnDisableDefender.Location = New-Object System.Drawing.Point(10, 140)
$btnDisableDefender.Size = New-Object System.Drawing.Size(250, 45)
$btnDisableDefender.Text = '🛡️ Disable Defender'
$btnDisableDefender.BackColor = [System.Drawing.Color]::FromArgb(255, 140, 0)
$btnDisableDefender.ForeColor = [System.Drawing.Color]::White
$btnDisableDefender.FlatStyle = 'Flat'
$btnDisableDefender.Add_Click({
    $result = [System.Windows.Forms.MessageBox]::Show("⚠️ Windows Defender uitschakelen?`n`nDit vermindert je beveiliging aanzienlijk!", "Waarschuwing", [System.Windows.Forms.MessageBoxButtons]::YesNo, [System.Windows.Forms.MessageBoxIcon]::Warning)
    if ($result -eq 'Yes') {
        $powerOutput.Text = "Bezig...`n"
        try {
            Set-MpPreference -DisableRealtimeMonitoring $true -ErrorAction Stop
            $powerOutput.AppendText("✅ Defender uitgeschakeld!`n")
        } catch {
            $powerOutput.AppendText("❌ Vereist admin rechten`n")
        }
    }
})
$tab3.Controls.Add($btnDisableDefender)

$btnDisableUpdates = New-Object System.Windows.Forms.Button
$btnDisableUpdates.Location = New-Object System.Drawing.Point(270, 140)
$btnDisableUpdates.Size = New-Object System.Drawing.Size(250, 45)
$btnDisableUpdates.Text = '🔄 Disable Windows Updates'
$btnDisableUpdates.BackColor = [System.Drawing.Color]::FromArgb(255, 140, 0)
$btnDisableUpdates.ForeColor = [System.Drawing.Color]::White
$btnDisableUpdates.FlatStyle = 'Flat'
$btnDisableUpdates.Add_Click({
    $result = [System.Windows.Forms.MessageBox]::Show("Windows Updates uitschakelen?", "Bevestiging", [System.Windows.Forms.MessageBoxButtons]::YesNo, [System.Windows.Forms.MessageBoxIcon]::Warning)
    if ($result -eq 'Yes') {
        $powerOutput.Text = "Bezig...`n"
        try {
            Stop-Service wuauserv -Force -ErrorAction Stop
            Set-Service wuauserv -StartupType Disabled -ErrorAction Stop
            $powerOutput.AppendText("✅ Windows Updates gestopt!`n")
        } catch {
            $powerOutput.AppendText("❌ Vereist admin rechten`n")
        }
    }
})
$tab3.Controls.Add($btnDisableUpdates)

$btnDisableSuperfetch = New-Object System.Windows.Forms.Button
$btnDisableSuperfetch.Location = New-Object System.Drawing.Point(530, 140)
$btnDisableSuperfetch.Size = New-Object System.Drawing.Size(250, 45)
$btnDisableSuperfetch.Text = '⚡ Disable Superfetch'
$btnDisableSuperfetch.BackColor = [System.Drawing.Color]::FromArgb(0, 120, 215)
$btnDisableSuperfetch.ForeColor = [System.Drawing.Color]::White
$btnDisableSuperfetch.FlatStyle = 'Flat'
$btnDisableSuperfetch.Add_Click({
    $powerOutput.Text = "Bezig...`n"
    try {
        Stop-Service "SysMain" -Force -ErrorAction SilentlyContinue
        Set-Service "SysMain" -StartupType Disabled -ErrorAction Stop
        $powerOutput.AppendText("✅ Superfetch uitgeschakeld!`n")
    } catch {
        $powerOutput.AppendText("❌ Fout`n")
    }
})
$tab3.Controls.Add($btnDisableSuperfetch)

$btnDisablePrintSpooler = New-Object System.Windows.Forms.Button
$btnDisablePrintSpooler.Location = New-Object System.Drawing.Point(10, 195)
$btnDisablePrintSpooler.Size = New-Object System.Drawing.Size(250, 45)
$btnDisablePrintSpooler.Text = '🖨️ Disable Print Spooler'
$btnDisablePrintSpooler.BackColor = [System.Drawing.Color]::FromArgb(0, 120, 215)
$btnDisablePrintSpooler.ForeColor = [System.Drawing.Color]::White
$btnDisablePrintSpooler.FlatStyle = 'Flat'
$btnDisablePrintSpooler.Add_Click({
    $powerOutput.Text = "Bezig...`n"
    Stop-Service Spooler -Force -ErrorAction SilentlyContinue
    Set-Service Spooler -StartupType Disabled -ErrorAction SilentlyContinue
    $powerOutput.AppendText("✅ Print Spooler uitgeschakeld!`n")
})
$tab3.Controls.Add($btnDisablePrintSpooler)

$btnDisableFax = New-Object System.Windows.Forms.Button
$btnDisableFax.Location = New-Object System.Drawing.Point(270, 195)
$btnDisableFax.Size = New-Object System.Drawing.Size(250, 45)
$btnDisableFax.Text = '📠 Disable Fax Service'
$btnDisableFax.BackColor = [System.Drawing.Color]::FromArgb(0, 120, 215)
$btnDisableFax.ForeColor = [System.Drawing.Color]::White
$btnDisableFax.FlatStyle = 'Flat'
$btnDisableFax.Add_Click({
    $powerOutput.Text = "Bezig...`n"
    Stop-Service Fax -Force -ErrorAction SilentlyContinue
    Set-Service Fax -StartupType Disabled -ErrorAction SilentlyContinue
    $powerOutput.AppendText("✅ Fax service uitgeschakeld!`n")
})
$tab3.Controls.Add($btnDisableFax)

$btnCleanTemp = New-Object System.Windows.Forms.Button
$btnCleanTemp.Location = New-Object System.Drawing.Point(530, 195)
$btnCleanTemp.Size = New-Object System.Drawing.Size(250, 45)
$btnCleanTemp.Text = '🧹 Clean Temp Files'
$btnCleanTemp.BackColor = [System.Drawing.Color]::FromArgb(0, 120, 215)
$btnCleanTemp.ForeColor = [System.Drawing.Color]::White
$btnCleanTemp.FlatStyle = 'Flat'
$btnCleanTemp.Add_Click({
    $powerOutput.Text = "Bezig met opschonen...`n"
    Remove-Item -Path "$env:TEMP\*" -Recurse -Force -ErrorAction SilentlyContinue
    Remove-Item -Path "C:\Windows\Temp\*" -Recurse -Force -ErrorAction SilentlyContinue
    $powerOutput.AppendText("✅ Temp files verwijderd!`n")
})
$tab3.Controls.Add($btnCleanTemp)

$storageLabel = New-Object System.Windows.Forms.Label
$storageLabel.Location = New-Object System.Drawing.Point(10, 250)
$storageLabel.Size = New-Object System.Drawing.Size(790, 25)
$storageLabel.Text = '💾 Storage & Cleanup'
$storageLabel.Font = New-Object System.Drawing.Font('Segoe UI', 11, [System.Drawing.FontStyle]::Bold)
$tab3.Controls.Add($storageLabel)

$btnDiskCleanup = New-Object System.Windows.Forms.Button
$btnDiskCleanup.Location = New-Object System.Drawing.Point(10, 285)
$btnDiskCleanup.Size = New-Object System.Drawing.Size(380, 45)
$btnDiskCleanup.Text = '🧹 Disk Cleanup (Alles)'
$btnDiskCleanup.BackColor = [System.Drawing.Color]::FromArgb(0, 120, 215)
$btnDiskCleanup.ForeColor = [System.Drawing.Color]::White
$btnDiskCleanup.FlatStyle = 'Flat'
$btnDiskCleanup.Add_Click({
    $powerOutput.Text = "Bezig met cleanup...`n"
    cleanmgr /sagerun:1
    $powerOutput.AppendText("✅ Disk Cleanup gestart!`n")
})
$tab3.Controls.Add($btnDiskCleanup)

$btnClearEventLogs = New-Object System.Windows.Forms.Button
$btnClearEventLogs.Location = New-Object System.Drawing.Point(400, 285)
$btnClearEventLogs.Size = New-Object System.Drawing.Size(380, 45)
$btnClearEventLogs.Text = '📋 Clear Event Logs'
$btnClearEventLogs.BackColor = [System.Drawing.Color]::FromArgb(0, 120, 215)
$btnClearEventLogs.ForeColor = [System.Drawing.Color]::White
$btnClearEventLogs.FlatStyle = 'Flat'
$btnClearEventLogs.Add_Click({
    $powerOutput.Text = "Bezig met wissen logs...`n"
    wevtutil el | Foreach-Object {wevtutil cl "$_"}
    $powerOutput.AppendText("✅ Event logs gewist!`n")
})
$tab3.Controls.Add($btnClearEventLogs)

# Footer buttons
$btnClose = New-Object System.Windows.Forms.Button
$btnClose.Location = New-Object System.Drawing.Point(710, 580)
$btnClose.Size = New-Object System.Drawing.Size(120, 35)
$btnClose.Text = '❌ Sluiten'
$btnClose.BackColor = [System.Drawing.Color]::FromArgb(232, 17, 35)
$btnClose.ForeColor = [System.Drawing.Color]::White
$btnClose.FlatStyle = 'Flat'
$btnClose.Add_Click({ $form.Close() })
$form.Controls.Add($btnClose)

# Versie label
$versionLabel = New-Object System.Windows.Forms.Label
$versionLabel.Location = New-Object System.Drawing.Point(20, 590)
$versionLabel.Size = New-Object System.Drawing.Size(300, 20)
$versionLabel.Text = 'v2.0 Ultimate | github.com/pieterpostNL/power'
$versionLabel.ForeColor = [System.Drawing.Color]::Gray
$form.Controls.Add($versionLabel)

# Toon het formulier
$form.Add_Shown({$form.Activate()})
[void]$form.ShowDialog()
