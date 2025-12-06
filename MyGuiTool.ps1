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
$form.Text = 'Windows Debloat Tool v1.0'
$form.Size = New-Object System.Drawing.Size(700, 550)
$form.StartPosition = 'CenterScreen'
$form.FormBorderStyle = 'FixedDialog'
$form.MaximizeBox = $false
$form.BackColor = [System.Drawing.Color]::White

# Header panel
$headerPanel = New-Object System.Windows.Forms.Panel
$headerPanel.Location = New-Object System.Drawing.Point(0, 0)
$headerPanel.Size = New-Object System.Drawing.Size(700, 80)
$headerPanel.BackColor = [System.Drawing.Color]::FromArgb(220, 50, 50)
$form.Controls.Add($headerPanel)

# Titel label
$titleLabel = New-Object System.Windows.Forms.Label
$titleLabel.Location = New-Object System.Drawing.Point(20, 15)
$titleLabel.Size = New-Object System.Drawing.Size(660, 30)
$titleLabel.Text = '🗑️ Windows Debloat Tool'
$titleLabel.Font = New-Object System.Drawing.Font('Segoe UI', 16, [System.Drawing.FontStyle]::Bold)
$titleLabel.ForeColor = [System.Drawing.Color]::White
$headerPanel.Controls.Add($titleLabel)

# Beschrijving label
$descLabel = New-Object System.Windows.Forms.Label
$descLabel.Location = New-Object System.Drawing.Point(20, 45)
$descLabel.Size = New-Object System.Drawing.Size(660, 25)
$descLabel.Text = 'Verwijder Windows bloatware en optimaliseer je systeem'
$descLabel.ForeColor = [System.Drawing.Color]::FromArgb(230, 230, 230)
$headerPanel.Controls.Add($descLabel)

# Waarschuwing label
$warningLabel = New-Object System.Windows.Forms.Label
$warningLabel.Location = New-Object System.Drawing.Point(20, 100)
$warningLabel.Size = New-Object System.Drawing.Size(660, 50)
$warningLabel.Text = '⚠️ WAARSCHUWING: Deze acties kunnen niet ongedaan worden gemaakt!'+"`n"+'Maak eerst een systeemherstel punt voordat je begint.'
$warningLabel.ForeColor = [System.Drawing.Color]::Red
$warningLabel.Font = New-Object System.Drawing.Font('Segoe UI', 10, [System.Drawing.FontStyle]::Bold)
$form.Controls.Add($warningLabel)

# Output textbox
$outputBox = New-Object System.Windows.Forms.TextBox
$outputBox.Location = New-Object System.Drawing.Point(20, 310)
$outputBox.Size = New-Object System.Drawing.Size(660, 150)
$outputBox.Multiline = $true
$outputBox.ScrollBars = 'Vertical'
$outputBox.Font = New-Object System.Drawing.Font('Consolas', 8)
$outputBox.ReadOnly = $true
$outputBox.Text = "Klik op een knop om te beginnen...`n`n⚠️ BELANGRIJK: Maak eerst een systeemherstel punt!"
$form.Controls.Add($outputBox)

# Debloat buttons - Rij 1
$btnRemoveBloatware = New-Object System.Windows.Forms.Button
$btnRemoveBloatware.Location = New-Object System.Drawing.Point(20, 170)
$btnRemoveBloatware.Size = New-Object System.Drawing.Size(210, 45)
$btnRemoveBloatware.Text = '🗑️ Verwijder Bloatware Apps'
$btnRemoveBloatware.BackColor = [System.Drawing.Color]::FromArgb(220, 50, 50)
$btnRemoveBloatware.ForeColor = [System.Drawing.Color]::White
$btnRemoveBloatware.FlatStyle = 'Flat'
$btnRemoveBloatware.Font = New-Object System.Drawing.Font('Segoe UI', 9, [System.Drawing.FontStyle]::Bold)
$btnRemoveBloatware.Add_Click({
    $result = [System.Windows.Forms.MessageBox]::Show("Weet je zeker dat je bloatware apps wilt verwijderen?`n`nDit verwijdert: Candy Crush, Xbox Game Bar, 3D Viewer, Mixed Reality Portal, en meer.", "Bevestiging", [System.Windows.Forms.MessageBoxButtons]::YesNo, [System.Windows.Forms.MessageBoxIcon]::Warning)
    
    if ($result -eq 'Yes') {
        $outputBox.Text = "Bezig met verwijderen van bloatware apps...`n`n"
        
        $bloatware = @(
            "Microsoft.BingWeather",
            "Microsoft.GetHelp",
            "Microsoft.Getstarted",
            "Microsoft.Microsoft3DViewer",
            "Microsoft.MicrosoftOfficeHub",
            "Microsoft.MicrosoftSolitaireCollection",
            "Microsoft.MixedReality.Portal",
            "Microsoft.People",
            "Microsoft.SkypeApp",
            "Microsoft.Wallet",
            "Microsoft.Xbox.TCUI",
            "Microsoft.XboxApp",
            "Microsoft.XboxGameOverlay",
            "Microsoft.XboxGamingOverlay",
            "Microsoft.XboxIdentityProvider",
            "Microsoft.XboxSpeechToTextOverlay",
            "Microsoft.ZuneMusic",
            "Microsoft.ZuneVideo",
            "*CandyCrush*",
            "*BubbleWitch*",
            "*Facebook*",
            "*Twitter*",
            "*LinkedIn*",
            "*Duolingo*",
            "*Spotify*"
        )
        
        foreach ($app in $bloatware) {
            try {
                $packages = Get-AppxPackage -Name $app -AllUsers -ErrorAction SilentlyContinue
                foreach ($package in $packages) {
                    $outputBox.AppendText("Verwijderen: $($package.Name)...`n")
                    Remove-AppxPackage -Package $package.PackageFullName -ErrorAction SilentlyContinue
                    $outputBox.AppendText("  ✅ Verwijderd`n")
                }
            }
            catch {
                $outputBox.AppendText("  ❌ Fout: $($_.Exception.Message)`n")
            }
        }
        
        $outputBox.AppendText("`n✅ Bloatware verwijdering voltooid!`n")
    }
})
$form.Controls.Add($btnRemoveBloatware)

$btnDisableMSStore = New-Object System.Windows.Forms.Button
$btnDisableMSStore.Location = New-Object System.Drawing.Point(245, 170)
$btnDisableMSStore.Size = New-Object System.Drawing.Size(210, 45)
$btnDisableMSStore.Text = '🚫 Uitschakelen MS Store'
$btnDisableMSStore.BackColor = [System.Drawing.Color]::FromArgb(220, 50, 50)
$btnDisableMSStore.ForeColor = [System.Drawing.Color]::White
$btnDisableMSStore.FlatStyle = 'Flat'
$btnDisableMSStore.Font = New-Object System.Drawing.Font('Segoe UI', 9, [System.Drawing.FontStyle]::Bold)
$btnDisableMSStore.Add_Click({
    $result = [System.Windows.Forms.MessageBox]::Show("Weet je zeker dat je de Microsoft Store wilt uitschakelen?", "Bevestiging", [System.Windows.Forms.MessageBoxButtons]::YesNo, [System.Windows.Forms.MessageBoxIcon]::Warning)
    
    if ($result -eq 'Yes') {
        $outputBox.Text = "Bezig met uitschakelen Microsoft Store...`n"
        try {
            Get-AppxPackage *windowsstore* | Remove-AppxPackage -ErrorAction Stop
            $outputBox.AppendText("✅ Microsoft Store succesvol uitgeschakeld!`n")
        }
        catch {
            $outputBox.AppendText("❌ Fout: $($_.Exception.Message)`n")
        }
    }
})
$form.Controls.Add($btnDisableMSStore)

$btnRemoveOneDrive = New-Object System.Windows.Forms.Button
$btnRemoveOneDrive.Location = New-Object System.Drawing.Point(470, 170)
$btnRemoveOneDrive.Size = New-Object System.Drawing.Size(210, 45)
$btnRemoveOneDrive.Text = '☁️ Verwijder OneDrive'
$btnRemoveOneDrive.BackColor = [System.Drawing.Color]::FromArgb(220, 50, 50)
$btnRemoveOneDrive.ForeColor = [System.Drawing.Color]::White
$btnRemoveOneDrive.FlatStyle = 'Flat'
$btnRemoveOneDrive.Font = New-Object System.Drawing.Font('Segoe UI', 9, [System.Drawing.FontStyle]::Bold)
$btnRemoveOneDrive.Add_Click({
    $result = [System.Windows.Forms.MessageBox]::Show("Weet je zeker dat je OneDrive wilt verwijderen?", "Bevestiging", [System.Windows.Forms.MessageBoxButtons]::YesNo, [System.Windows.Forms.MessageBoxIcon]::Warning)
    
    if ($result -eq 'Yes') {
        $outputBox.Text = "Bezig met verwijderen van OneDrive...`n"
        try {
            taskkill /f /im OneDrive.exe 2>&1 | Out-Null
            Start-Sleep -Seconds 2
            
            $oneDrivePath = "$env:SystemRoot\SysWOW64\OneDriveSetup.exe"
            if (!(Test-Path $oneDrivePath)) {
                $oneDrivePath = "$env:SystemRoot\System32\OneDriveSetup.exe"
            }
            
            if (Test-Path $oneDrivePath) {
                Start-Process $oneDrivePath "/uninstall" -NoNewWindow -Wait
                $outputBox.AppendText("✅ OneDrive succesvol verwijderd!`n")
            }
            else {
                $outputBox.AppendText("❌ OneDrive installer niet gevonden`n")
            }
        }
        catch {
            $outputBox.AppendText("❌ Fout: $($_.Exception.Message)`n")
        }
    }
})
$form.Controls.Add($btnRemoveOneDrive)

# Debloat buttons - Rij 2
$btnDisableTelemetry = New-Object System.Windows.Forms.Button
$btnDisableTelemetry.Location = New-Object System.Drawing.Point(20, 225)
$btnDisableTelemetry.Size = New-Object System.Drawing.Size(210, 45)
$btnDisableTelemetry.Text = '📡 Uitschakelen Telemetrie'
$btnDisableTelemetry.BackColor = [System.Drawing.Color]::FromArgb(220, 50, 50)
$btnDisableTelemetry.ForeColor = [System.Drawing.Color]::White
$btnDisableTelemetry.FlatStyle = 'Flat'
$btnDisableTelemetry.Font = New-Object System.Drawing.Font('Segoe UI', 9, [System.Drawing.FontStyle]::Bold)
$btnDisableTelemetry.Add_Click({
    $outputBox.Text = "Bezig met uitschakelen telemetrie...`n"
    try {
        Stop-Service DiagTrack -ErrorAction SilentlyContinue
        Stop-Service dmwappushservice -ErrorAction SilentlyContinue
        Set-Service DiagTrack -StartupType Disabled -ErrorAction SilentlyContinue
        Set-Service dmwappushservice -StartupType Disabled -ErrorAction SilentlyContinue
        $outputBox.AppendText("✅ Telemetrie services uitgeschakeld!`n")
    }
    catch {
        $outputBox.AppendText("❌ Fout: $($_.Exception.Message)`n")
    }
})
$form.Controls.Add($btnDisableTelemetry)

$btnDisableCortana = New-Object System.Windows.Forms.Button
$btnDisableCortana.Location = New-Object System.Drawing.Point(245, 225)
$btnDisableCortana.Size = New-Object System.Drawing.Size(210, 45)
$btnDisableCortana.Text = '🎤 Uitschakelen Cortana'
$btnDisableCortana.BackColor = [System.Drawing.Color]::FromArgb(220, 50, 50)
$btnDisableCortana.ForeColor = [System.Drawing.Color]::White
$btnDisableCortana.FlatStyle = 'Flat'
$btnDisableCortana.Font = New-Object System.Drawing.Font('Segoe UI', 9, [System.Drawing.FontStyle]::Bold)
$btnDisableCortana.Add_Click({
    $outputBox.Text = "Bezig met uitschakelen Cortana...`n"
    try {
        Get-AppxPackage *Microsoft.549981C3F5F10* | Remove-AppxPackage -ErrorAction SilentlyContinue
        $outputBox.AppendText("✅ Cortana uitgeschakeld!`n")
    }
    catch {
        $outputBox.AppendText("❌ Fout: $($_.Exception.Message)`n")
    }
})
$form.Controls.Add($btnDisableCortana)

$btnListInstalledApps = New-Object System.Windows.Forms.Button
$btnListInstalledApps.Location = New-Object System.Drawing.Point(470, 225)
$btnListInstalledApps.Size = New-Object System.Drawing.Size(210, 45)
$btnListInstalledApps.Text = '📋 Toon Alle Store Apps'
$btnListInstalledApps.BackColor = [System.Drawing.Color]::FromArgb(0, 120, 215)
$btnListInstalledApps.ForeColor = [System.Drawing.Color]::White
$btnListInstalledApps.FlatStyle = 'Flat'
$btnListInstalledApps.Font = New-Object System.Drawing.Font('Segoe UI', 9, [System.Drawing.FontStyle]::Bold)
$btnListInstalledApps.Add_Click({
    $outputBox.Text = "Bezig met laden van geïnstalleerde apps...`n`n"
    $apps = Get-AppxPackage | Select-Object Name | Sort-Object Name
    foreach ($app in $apps) {
        $outputBox.AppendText("$($app.Name)`n")
    }
})
$form.Controls.Add($btnListInstalledApps)

# Footer buttons
$btnCreateRestorePoint = New-Object System.Windows.Forms.Button
$btnCreateRestorePoint.Location = New-Object System.Drawing.Point(20, 475)
$btnCreateRestorePoint.Size = New-Object System.Drawing.Size(200, 40)
$btnCreateRestorePoint.Text = '💾 Maak Herstel Punt'
$btnCreateRestorePoint.BackColor = [System.Drawing.Color]::FromArgb(0, 150, 0)
$btnCreateRestorePoint.ForeColor = [System.Drawing.Color]::White
$btnCreateRestorePoint.FlatStyle = 'Flat'
$btnCreateRestorePoint.Font = New-Object System.Drawing.Font('Segoe UI', 10, [System.Drawing.FontStyle]::Bold)
$btnCreateRestorePoint.Add_Click({
    $outputBox.Text = "Bezig met maken van systeemherstel punt...`n"
    try {
        Checkpoint-Computer -Description "PowerShell Debloat Tool Backup" -RestorePointType "MODIFY_SETTINGS"
        $outputBox.AppendText("✅ Systeemherstel punt succesvol aangemaakt!`n")
    }
    catch {
        $outputBox.AppendText("❌ Fout: $($_.Exception.Message)`n")
        $outputBox.AppendText("Mogelijk zijn systeemherstel punten uitgeschakeld.`n")
    }
})
$form.Controls.Add($btnCreateRestorePoint)

$btnClose = New-Object System.Windows.Forms.Button
$btnClose.Location = New-Object System.Drawing.Point(480, 475)
$btnClose.Size = New-Object System.Drawing.Size(200, 40)
$btnClose.Text = '❌ Sluiten'
$btnClose.BackColor = [System.Drawing.Color]::FromArgb(232, 17, 35)
$btnClose.ForeColor = [System.Drawing.Color]::White
$btnClose.FlatStyle = 'Flat'
$btnClose.Font = New-Object System.Drawing.Font('Segoe UI', 10, [System.Drawing.FontStyle]::Bold)
$btnClose.Add_Click({ $form.Close() })
$form.Controls.Add($btnClose)

# Versie label
$versionLabel = New-Object System.Windows.Forms.Label
$versionLabel.Location = New-Object System.Drawing.Point(230, 485)
$versionLabel.Size = New-Object System.Drawing.Size(240, 20)
$versionLabel.Text = 'v1.0 | github.com/pieterpostNL/power'
$versionLabel.ForeColor = [System.Drawing.Color]::Gray
$versionLabel.TextAlign = 'MiddleCenter'
$form.Controls.Add($versionLabel)

# Toon het formulier
$form.Add_Shown({$form.Activate()})
[void]$form.ShowDialog()
