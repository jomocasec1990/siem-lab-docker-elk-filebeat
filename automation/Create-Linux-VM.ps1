
# === Variables ===
$VMName = "Cortex"
$BasePath = "C:\Users\jomoc\Documents\Virtual Machines"
$VMPath = "$BasePath\$VMName"
$VHDSubfolder = "$VMPath\Virtual Hard Disks"
$VHDPath = "$VHDSubfolder\$VMName.vhdx"
$SwitchName = "InternetSwitch-192.168.0.0"
$ISOPath = "$BasePath\ubuntu-20.04.6-live-server-amd64.iso"

# === Crear carpetas ===
New-Item -ItemType Directory -Path $VHDSubfolder -Force

# === Crear disco duro virtual dinámico de 50 GB ===
New-VHD -Path $VHDPath -SizeBytes 50GB -Dynamic

# === Crear la VM ===
New-VM -Name $VMName -MemoryStartupBytes 4GB -Generation 1 `
       -VHDPath $VHDPath -SwitchName $SwitchName -Path $VMPath

# === Configurar procesadores ===
Set-VMProcessor -VMName $VMName -Count 2

# === Agregar ISO al DVD ===
Add-VMDvdDrive -VMName $VMName -Path $ISOPath

# === Desactivar puntos de control automáticos ===
Set-VM -Name $VMName -AutomaticCheckpointsEnabled $false

# === Iniciar la VM ===
Start-VM -Name $VMName

Write-Host "✅ VM '$VMName' creada con disco dinámico de 50GB y en ejecución." -ForegroundColor Green
