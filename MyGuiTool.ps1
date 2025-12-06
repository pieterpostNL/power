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
$form.Text = 'Windows Optimization Tool v1.0'
$form.Size = New-Object System.Drawing.Size(750, 600)
$form.StartPosition = 'CenterScreen'
$form.FormBorderStyle = 'FixedDialog'
$form.MaximizeBox = $false
$form.BackColor = [System.Drawing.Color]::White

# Header panel
$headerPanel = New-Object System.Windows.Forms.Panel
$headerPanel.Location = New-Object System.Drawing.Point(0, 0)
$headerPanel.Size = New-Object System.Drawing.Size(750, 80)
$headerPanel.BackColor = [System.Drawing.Color]::FromArgb(0, 120, 215)
$form.Controls.Add($headerPanel)

# Titel label
$titleLabel = New-Object System.Windows.Forms.Label
$titleLabel.Location = New-Object System.Drawing.Point(20, 15)
$titleLabel.Size = New-Object System.Drawing.Size(710, 30)
$titleLabel.Text = '⚡ Windows Optimization Tool'
$titleLabel.Font = New-Object System.Drawing.Font('Segoe UI', 16, [System.Drawing.FontStyle]::Bold)
$titleLabel.ForeColor = [System.Drawing.Color]::White
$headerPanel.Controls.Add($titleLabel)

# Beschrijving label
$descLabel = New-Object System.Windows.Forms.Label
$descLabel.Location = New-Object System.Drawing.Point(20, 45)
$descLabel.Size = New-Object System.Drawing.Size(710, 25)
$descLabel.Text = 'Debloat en optimaliseer je Windows systeem'
$descLabel.ForeColor = [System.Drawing.Color]::FromArgb(230, 230, 230)
$headerPanel.Controls.Add($descLabel)

# Tab Control
$tabControl = New-Object System.Windows.Forms.TabControl
$tabControl.Location = New-Object System.Drawing.Point(10, 90)
$tabControl.Size = New-Object System.Drawing.Size(720, 420)
$form.Controls.Add($tabControl)

# ============================================
# TAB 1: DEBLOAT
# ============================================
$tab1 = New-Object System.Windows.Forms.TabPage
$tab1.Text = '🗑️ Debloat'
$tabControl.Controls.Add($tab1)

$debloatWarning = New-Object System.Windows.Forms.Label
$debloatWarning.Location = New-Object System.Drawing.Point(10, 10)
$debloatWarning.Size = New-Object System.Drawing.Size(690, 35)
$debloatWarning.Text = '⚠️ WAARSCHUWING: Maak eerst een systeemherstel punt!'
$debloatWarning.ForeColor = [System.Drawing.Color]::Red
$debloatWarning.Font = New-Object System.Drawing.Font('Segoe UI', 10, [System.Drawing.FontStyle]::Bold)
$tab1.Controls.Add($debloatWarning)

$debloatOutput = New-Object System.Windows.Forms.TextBox
$debloatOutput.Location = New-Object System.Drawing.Point(10, 240)
$debloatOutput.Size = New-Object System.Drawing.Size(690, 140)
$debloatOutput.Multiline = $true
$debloatOutput.ScrollBars = 'Vertical'
$debloatOutput.Font = New-Object System.Drawing.Font('Consolas', 8)
$debloatOutput.ReadOnly = $true
$tab1.Controls.Add($debloatOutput)

# Debloat Buttons
$btnRemoveBloat = New-Object System.Windows.Forms.Button
$btnRemoveBloat.Location = New-Object System.Drawing.Point(10, 55)
$btnRemoveBloat.Size = New-Object System.Drawing.Size(220, 40)
$btnRemoveBloat.Text = '🗑️ Verwijder Bloatware'
$btnRemoveBloat.BackColor = [System.Drawing.Color]::FromArgb(220, 50, 50)
$btnRemoveBloat.ForeColor = [System.Drawing.Color]::White
$btnRemoveBloat.FlatStyle = 'Flat'
$btnRemoveBloat.Add_Click({
    $result = [System.Windows.Forms.MessageBox]::Show("Weet je zeker dat je bloatware wilt verwijderen?", "Bevestiging", [System.Windows.Forms.MessageBoxButtons]::YesNo, [System.Windows.Forms.MessageBoxIcon]::Warning)
    if ($result -eq 'Yes') {
        $debloatOutput.Text = "Bezig met verwijderen...`n`n"
        $bloatware = @("Microsoft.BingWeather","Microsoft.GetHelp","Microsoft.Getstarted","Microsoft.Microsoft3DViewer","Microsoft.MicrosoftOfficeHub","Microsoft.MicrosoftSolitaireCollection","Microsoft.MixedReality.Portal","Microsoft.People","Microsoft.SkypeApp","Microsoft.Wallet","Microsoft.Xbox.TCUI","Microsoft.XboxApp","Microsoft.XboxGameOverlay","Microsoft.XboxGamingOverlay","Microsoft.XboxIdentityProvider","Microsoft.XboxSpeechToTextOverlay","Microsoft.ZuneMusic","Microsoft.ZuneVideo","*CandyCrush*","*BubbleWitch*","*Facebook*","*Twitter*","*LinkedIn*","*Duolingo*","*Spotify*")
        foreach ($app in $bloatware) {
            try {
                $packages = Get-AppxPackage -Name $app -AllUsers -ErrorAction SilentlyContinue
                foreach ($package in $packages) {
                    $debloatOutput.AppendText("✅ Verwijderd: $($package.Name)`n")
                    Remove-AppxPackage -Package $package.PackageFullName -ErrorAction SilentlyContinue
                }
            } catch { }
        }
        $debloatOutput.AppendText("`n✅ Klaar!`n")
    }
})
$tab1.Controls.Add($btnRemoveBloat)

$btnRemoveStore = New-Object System.Windows.Forms.Button
$btnRemoveStore.Location = New-Object System.Drawing.Point(240, 55)
$btnRemoveStore.Size = New-Object System.Drawing.Size(220, 40)
$btnRemoveStore.Text = '🚫 MS Store Verwijderen'
$btnRemoveStore.BackColor = [System.Drawing.Color]::FromArgb(220, 50, 50)
$btnRemoveStore.ForeColor = [System.Drawing.Color]::White
$btnRemoveStore.FlatStyle = 'Flat'
$btnRemoveStore.Add_Click({
    $result = [System.Windows.Forms.MessageBox]::Show("Microsoft Store verwijderen?", "Bevestiging", [System.Windows.Forms.MessageBoxButtons]::YesNo, [System.Windows.Forms.MessageBoxIcon]::Warning)
    if ($result -eq 'Yes') {
        $debloatOutput.Text = "Bezig...`n"
        try {
            Get-AppxPackage *windowsstore* | Remove-AppxPackage -ErrorAction Stop
            $debloatOutput.AppendText("✅ MS Store verwijderd!`n")
        } catch {
            $debloatOutput.AppendText("❌ Fout: $($_.Exception.Message)`n")
        }
    }
})
$tab1.Controls.Add($btnRemoveStore)

$btnRemoveOneDrive = New-Object System.Windows.Forms.Button
$btnRemoveOneDrive.Location = New-Object System.Drawing.Point(470, 55)
$btnRemoveOneDrive.Size = New-Object System.Drawing.Size(220, 40)
$btnRemoveOneDrive.Text = '☁️ OneDrive Verwijderen'
$btnRemoveOneDrive.BackColor = [System.Drawing.Color]::FromArgb(220, 50, 50)
$btnRemoveOneDrive.ForeColor = [System.Drawing.Color]::White
$btnRemoveOneDrive.FlatStyle = 'Flat'
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
        } catch {
            $debloatOutput.AppendText("❌ Fout`n")
        }
    }
})
$tab1.Controls.Add($btnRemoveOneDrive)

$btnDisableCortana = New-Object System.Windows.Forms.Button
$btnDisableCortana.Location = New-Object System.Drawing.Point(10, 105)
$btnDisableCortana.Size = New-Object System.Drawing.Size(220, 40)
$btnDisableCortana.Text = '🎤 Cortana Uitschakelen'
$btnDisableCortana.BackColor = [System.Drawing.Color]::FromArgb(220, 50, 50)
$btnDisableCortana.ForeColor = [System.Drawing.Color]::White
$btnDisableCortana.FlatStyle = 'Flat'
$btnDisableCortana.Add_Click({
    $debloatOutput.Text = "Bezig...`n"
    try {
        Get-AppxPackage *Microsoft.549981C3F5F10* | Remove-AppxPackage -ErrorAction SilentlyContinue
        $debloatOutput.AppendText("✅ Cortana uitgeschakeld!`n")
    } catch {
        $debloatOutput.AppendText("❌ Fout`n")
    }
})
$tab1.Controls.Add($btnDisableCortana)

$btnDisableTelemetry = New-Object System.Windows.Forms.Button
$btnDisableTelemetry.Location = New-Object System.Drawing.Point(240, 105)
$btnDisableTelemetry.Size = New-Object System.Drawing.Size(220, 40)
$btnDisableTelemetry.Text = '📡 Telemetrie Uitschakelen'
$btnDisableTelemetry.BackColor = [System.Drawing.Color]::FromArgb(220, 50, 50)
$btnDisableTelemetry.ForeColor = [System.Drawing.Color]::White
$btnDisableTelemetry.FlatStyle = 'Flat'
$btnDisableTelemetry.Add_Click({
    $debloatOutput.Text = "Bezig...`n"
    try {
        Stop-Service DiagTrack -ErrorAction SilentlyContinue
        Stop-Service dmwappushservice -ErrorAction SilentlyContinue
        Set-Service DiagTrack -StartupType Disabled -ErrorAction SilentlyContinue
        Set-Service dmwappushservice -StartupType Disabled -ErrorAction SilentlyContinue
        $debloatOutput.AppendText("✅ Telemetrie uitgeschakeld!`n")
    } catch {
        $debloatOutput.AppendText("❌ Fout`n")
    }
})
$tab1.Controls.Add($btnDisableTelemetry)

$btnListApps = New-Object System.Windows.Forms.Button
$btnListApps.Location = New-Object System.Drawing.Point(470, 105)
$btnListApps.Size = New-Object System.Drawing.Size(220, 40)
$btnListApps.Text = '📋 Toon Store Apps'
$btnListApps.BackColor = [System.Drawing.Color]::FromArgb(0, 120, 215)
$btnListApps.ForeColor = [System.Drawing.Color]::White
$btnListApps.FlatStyle = 'Flat'
$btnListApps.Add_Click({
    $debloatOutput.Text = "Geïnstalleerde apps:`n`n"
    $apps = Get-AppxPackage | Select-Object Name | Sort-Object Name
    foreach ($app in $apps) {
        $debloatOutput.AppendText("$($app.Name)`n")
    }
})
$tab1.Controls.Add($btnListApps)

$btnRestorePoint = New-Object System.Windows.Forms.Button
$btnRestorePoint.Location = New-Object System.Drawing.Point(10, 155)
$btnRestorePoint.Size = New-Object System.Drawing.Size(680, 40)
$btnRestorePoint.Text = '💾 Maak Systeemherstel Punt (DOE DIT EERST!)'
$btnRestorePoint.BackColor = [System.Drawing.Color]::FromArgb(0, 150, 0)
$btnRestorePoint.ForeColor = [System.Drawing.Color]::White
$btnRestorePoint.FlatStyle = 'Flat'
$btnRestorePoint.Font = New-Object System.Drawing.Font('Segoe UI', 10, [System.Drawing.FontStyle]::Bold)
$btnRestorePoint.Add_Click({
    $debloatOutput.Text = "Bezig met maken herstel punt...`n"
    try {
        Checkpoint-Computer -Description "Windows Optimization Tool Backup" -RestorePointType "MODIFY_SETTINGS"
        $debloatOutput.AppendText("✅ Herstel punt aangemaakt!`n")
    } catch {
        $debloatOutput.AppendText("❌ Fout: $($_.Exception.Message)`n")
    }
})
$tab1.Controls.Add($btnRestorePoint)

# ============================================
# TAB 2: WINDOWS TWEAKS
# ============================================
$tab2 = New-Object System.Windows.Forms.TabPage
$tab2.Text = '⚙️ Tweaks'
$tabControl.Controls.Add($tab2)

$tweaksOutput = New-Object System.Windows.Forms.TextBox
$tweaksOutput.Location = New-Object System.Drawing.Point(10, 240)
$tweaksOutput.Size = New-Object System.Drawing.Size(690, 140)
$tweaksOutput.Multiline = $true
$tweaksOutput.ScrollBars = 'Vertical'
$tweaksOutput.Font = New-Object System.Drawing.Font('Consolas', 8)
$tweaksOutput.ReadOnly = $true
$tab2.Controls.Add($tweaksOutput)

# Performance Tweaks
$tweaksLabel = New-Object System.Windows.Forms.Label
$tweaksLabel.Location = New-Object System.Drawing.Point(10, 10)
$tweaksLabel.Size = New-Object System.Drawing.Size(690, 25)
$tweaksLabel.Text = '⚡ Performance & Registry Tweaks'
$tweaksLabel.Font = New-Object System.Drawing.Font('Segoe UI', 11, [System.Drawing.FontStyle]::Bold)
$tab2.Controls.Add($tweaksLabel)

$btnDisableAnimations = New-Object System.Windows.Forms.Button
$btnDisableAnimations.Location = New-Object System.Drawing.Point(10, 45)
$btnDisableAnimations.Size = New-Object System.Drawing.Size(220, 40)
$btnDisableAnimations.Text = '🚀 Disable Animaties'
$btnDisableAnimations.BackColor = [System.Drawing.Color]::FromArgb(0, 120, 215)
$btnDisableAnimations.ForeColor = [System.Drawing.Color]::White
$btnDisableAnimations.FlatStyle = 'Flat'
$btnDisableAnimations.Add_Click({
    $tweaksOutput.Text = "Bezig met uitschakelen animaties...`n"
    try {
        Set-ItemProperty -Path "HKCU:\Control Panel\Desktop\WindowMetrics" -Name "MinAnimate" -Value "0" -ErrorAction Stop
        Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "TaskbarAnimations" -Value 0 -ErrorAction Stop
        $tweaksOutput.AppendText("✅ Animaties uitgeschakeld! Herstart explorer.exe`n")
    } catch {
        $tweaksOutput.AppendText("❌ Fout`n")
    }
})
$tab2.Controls.Add($btnDisableAnimations)

$btnDisableTransparency = New-Object System.Windows.Forms.Button
$btnDisableTransparency.Location = New-Object System.Drawing.Point(240, 45)
$btnDisableTransparency.Size = New-Object System.Drawing.Size(220, 40)
$btnDisableTransparency.Text = '🎨 Disable Transparantie'
$btnDisableTransparency.BackColor = [System.Drawing.Color]::FromArgb(0, 120, 215)
$btnDisableTransparency.ForeColor = [System.Drawing.Color]::White
$btnDisableTransparency.FlatStyle = 'Flat'
$btnDisableTransparency.Add_Click({
    $tweaksOutput.Text = "Bezig...`n"
    try {
        Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" -Name "EnableTransparency" -Value 0 -ErrorAction Stop
        $tweaksOutput.AppendText("✅ Transparantie uitgeschakeld!`n")
    } catch {
        $tweaksOutput.AppendText("❌ Fout`n")
    }
})
$tab2.Controls.Add($btnDisableTransparency)

$btnDisableStartupApps = New-Object System.Windows.Forms.Button
$btnDisableStartupApps.Location = New-Object System.Drawing.Point(470, 45)
$btnDisableStartupApps.Size = New-Object System.Drawing.Size(220, 40)
$btnDisableStartupApps.Text = '🚫 Disable Startup Delay'
$btnDisableStartupApps.BackColor = [System.Drawing.Color]::FromArgb(0, 120, 215)
$btnDisableStartupApps.ForeColor = [System.Drawing.Color]::White
$btnDisableStartupApps.FlatStyle = 'Flat'
$btnDisableStartupApps.Add_Click({
    $tweaksOutput.Text = "Bezig...`n"
    try {
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Serialize" -Name "StartupDelayInMSec" -Value 0 -ErrorAction Stop
        $tweaksOutput.AppendText("✅ Startup delay verwijderd!`n")
    } catch {
        $tweaksOutput.AppendText("❌ Fout`n")
    }
})
$tab2.Controls.Add($btnDisableStartupApps)

$btnDisableHibernation = New-Object System.Windows.Forms.Button
$btnDisableHibernation.Location = New-Object System.Drawing.Point(10, 95)
$btnDisableHibernation.Size = New-Object System.Drawing.Size(220, 40)
$btnDisableHibernation.Text = '💤 Disable Sluimerstand'
$btnDisableHibernation.BackColor = [System.Drawing.Color]::FromArgb(0, 120, 215)
$btnDisableHibernation.ForeColor = [System.Drawing.Color]::White
$btnDisableHibernation.FlatStyle = 'Flat'
$btnDisableHibernation.Add_Click({
    $tweaksOutput.Text = "Bezig...`n"
    try {
        powercfg /hibernate off
        $tweaksOutput.AppendText("✅ Sluimerstand uitgeschakeld! (Bespaart GB schijfruimte)`n")
    } catch {
        $tweaksOutput.AppendText("❌ Fout`n")
    }
})
$tab2.Controls.Add($btnDisableHibernation)

$btnOptimizeVisualEffects = New-Object System.Windows.Forms.Button
$btnOptimizeVisualEffects.Location = New-Object System.Drawing.Point(240, 95)
$btnOptimizeVisualEffects.Size = New-Object System.Drawing.Size(220, 40)
$btnOptimizeVisualEffects.Text = '🎯 Optimaliseer Visueel'
$btnOptimizeVisualEffects.BackColor = [System.Drawing.Color]::FromArgb(0, 120, 215)
$btnOptimizeVisualEffects.ForeColor = [System.Drawing.Color]::White
$btnOptimizeVisualEffects.FlatStyle = 'Flat'
$btnOptimizeVisualEffects.Add_Click({
    $tweaksOutput.Text = "Bezig met optimaliseren...`n"
    try {
        Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" -Name "VisualFXSetting" -Value 2 -ErrorAction Stop
        $tweaksOutput.AppendText("✅ Ingesteld op 'beste prestaties'!`n")
    } catch {
        $tweaksOutput.AppendText("❌ Fout`n")
    }
})
$tab2.Controls.Add($btnOptimizeVisualEffects)

$btnDisableSuperfetch = New-Object System.Windows.Forms.Button
$btnDisableSuperfetch.Location = New-Object System.Drawing.Point(470, 95)
$btnDisableSuperfetch.Size = New-Object System.Drawing.Size(220, 40)
$btnDisableSuperfetch.Text = '⚡ Disable Superfetch'
$btnDisableSuperfetch.BackColor = [System.Drawing.Color]::FromArgb(0, 120, 215)
$btnDisableSuperfetch.ForeColor = [System.Drawing.Color]::White
$btnDisableSuperfetch.FlatStyle = 'Flat'
$btnDisableSuperfetch.Add_Click({
    $tweaksOutput.Text = "Bezig...`n"
    try {
        Stop-Service "SysMain" -Force -ErrorAction SilentlyContinue
        Set-Service "SysMain" -StartupType Disabled -ErrorAction Stop
        $tweaksOutput.AppendText("✅ Superfetch uitgeschakeld!`n")
    } catch {
        $tweaksOutput.AppendText("❌ Fout`n")
    }
})
$tab2.Controls.Add($btnDisableSuperfetch)

# Privacy & Updates
$privacyLabel = New-Object System.Windows.Forms.Label
$privacyLabel.Location = New-Object System.Drawing.Point(10, 145)
$privacyLabel.Size = New-Object System.Drawing.Size(690, 25)
$privacyLabel.Text = '🔒 Privacy & Updates'
$privacyLabel.Font = New-Object System.Drawing.Font('Segoe UI', 11, [System.Drawing.FontStyle]::Bold)
$tab2.Controls.Add($privacyLabel)

$btnDisableDefender = New-Object System.Windows.Forms.Button
$btnDisableDefender.Location = New-Object System.Drawing.Point(10, 180)
$btnDisableDefender.Size = New-Object System.Drawing.Size(220, 40)
$btnDisableDefender.Text = '🛡️ Disable Defender'
$btnDisableDefender.BackColor = [System.Drawing.Color]::FromArgb(255, 140, 0)
$btnDisableDefender.ForeColor = [System.Drawing.Color]::White
$btnDisableDefender.FlatStyle = 'Flat'
$btnDisableDefender.Add_Click({
    $tweaksOutput.Text = "⚠️ Let op: Dit schakelt je beveiliging uit!`n"
    $result = [System.Windows.Forms.MessageBox]::Show("Windows Defender uitschakelen? Dit vermindert je beveiliging!", "Waarschuwing", [System.Windows.Forms.MessageBoxButtons]::YesNo, [System.Windows.Forms.MessageBoxIcon]::Warning)
    if ($result -eq 'Yes') {
        try {
            Set-MpPreference -DisableRealtimeMonitoring $true -ErrorAction Stop
            $tweaksOutput.AppendText("✅ Defender uitgeschakeld!`n")
        } catch {
            $tweaksOutput.AppendText("❌ Vereist admin rechten`n")
        }
    }
})
$tab2.Controls.Add($btnDisableDefender)

$btnDisableUpdates = New-Object System.Windows.Forms.Button
$btnDisableUpdates.Location = New-Object System.Drawing.Point(240, 180)
$btnDisableUpdates.Size = New-Object System.Drawing.Size(220, 40)
$btnDisableUpdates.Text = '🔄 Pause Windows Updates'
$btnDisableUpdates.BackColor = [System.Drawing.Color]::FromArgb(255, 140, 0)
$btnDisableUpdates.ForeColor = [System.Drawing.Color]::White
$btnDisableUpdates.FlatStyle = 'Flat'
$btnDisableUpdates.Add_Click({
    $tweaksOutput.Text = "Bezig met pauzeren updates...`n"
    try {
        Stop-Service wuauserv -Force -ErrorAction Stop
        Set-Service wuauserv -StartupType Disabled -ErrorAction Stop
        $tweaksOutput.AppendText("✅ Windows Update service gestopt!`n")
    } catch {
        $tweaksOutput.AppendText("❌ Vereist admin rechten`n")
    }
})
$tab2.Controls.Add($btnDisableUpdates)

$btnOptimizeNetwork = New-Object System.Windows.Forms.Button
$btnOptimizeNetwork.Location = New-Object System.Drawing.Point(470, 180)
$btnOptimizeNetwork.Size = New-Object System.Drawing.Size(220, 40)
$btnOptimizeNetwork.Text = '🌐 Optimaliseer Netwerk'
$btnOptimizeNetwork.BackColor = [System.Drawing.Color]::FromArgb(0, 120, 215)
$btnOptimizeNetwork.ForeColor = [System.Drawing.Color]::White
$btnOptimizeNetwork.FlatStyle = 'Flat'
$btnOptimizeNetwork.Add_Click({
    $tweaksOutput.Text = "Bezig met netwerk optimalisatie...`n"
    try {
        netsh int tcp set global autotuninglevel=normal
        netsh int tcp set global chimney=enabled
        netsh int tcp set global dca=enabled
        netsh int tcp set global netdma=enabled
        $tweaksOutput.AppendText("✅ Netwerk geoptimaliseerd!`n")
    } catch {
        $tweaksOutput.AppendText("❌ Fout`n")
    }
})
$tab2.Controls.Add($btnOptimizeNetwork)

# Footer buttons
$btnClose = New-Object System.Windows.Forms.Button
$btnClose.Location = New-Object System.Drawing.Point(610, 520)
$btnClose.Size = New-Object System.Drawing.Size(120, 35)
$btnClose.Text = '❌ Sluiten'
$btnClose.BackColor = [System.Drawing.Color]::FromArgb(232, 17, 35)
$btnClose.ForeColor = [System.Drawing.Color]::White
$btnClose.FlatStyle = 'Flat'
$btnClose.Add_Click({ $form.Close() })
$form.Controls.Add($btnClose)

# Versie label
$versionLabel = New-Object System.Windows.Forms.Label
$versionLabel.Location = New-Object System.Drawing.Point(20, 530)
$versionLabel.Size = New-Object System.Drawing.Size(300, 20)
$versionLabel.Text = 'v1.0 | github.com/pieterpostNL/power'
$versionLabel.ForeColor = [System.Drawing.Color]::Gray
$form.Controls.Add($versionLabel)

# Toon het formulier
$form.Add_Shown({$form.Activate()})
[void]$form.ShowDialog()
