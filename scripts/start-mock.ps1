param(
    [int]$Port = 8081
)

$ErrorActionPreference = "Stop"

$repoRoot = Split-Path -Parent $PSScriptRoot
Set-Location $repoRoot

$selectedPort = $Port
while (Get-NetTCPConnection -LocalPort $selectedPort -State Listen -ErrorAction SilentlyContinue) {
    Write-Host "Port $selectedPort is already in use. Trying $($selectedPort + 1)..."
    $selectedPort++
}

Write-Host "Starting LUCY LMS mock profile on http://localhost:$selectedPort/login"
Write-Host "Mock accounts use password: 123456"
Write-Host ""

& .\mvnw.cmd spring-boot:run "-Dspring-boot.run.profiles=mock" "-Dspring-boot.run.arguments=--server.port=$selectedPort"
