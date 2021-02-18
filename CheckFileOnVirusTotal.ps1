#Fait par Christian Lévesque
Add-Type -AssemblyName System.Windows.Forms

$fileDialog = New-Object System.Windows.Forms.OpenFileDialog -Property @{ InitialDirectory = [Environment]::GetFolderPath('Desktop') }
$Null = $fileDialog.ShowDialog()

$fileHash = Get-FileHash -Path $fileDialog.FileName -Algorithm SHA1
Write-Host $fileHash.Hash

$url = "https://www.virustotal.com/gui/file/" + $fileHash.Hash + "/detection"
Start-Process $url