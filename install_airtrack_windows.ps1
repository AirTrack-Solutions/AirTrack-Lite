# AirTrack Lite 1.0.0 "Wilbur" — Windows Installer
# Copyright (c) 2025 Trevor ("Subhuti"). All rights reserved.
# SPDX-License-Identifier: LicenseRef-AirTrack-Proprietary-NC
#
# Run from PowerShell as Administrator:
#   cd "C:\Path\To\AirTrack-Lite"
#   .\install_airtrack_windows.ps1

$ErrorActionPreference = "Stop"

function Write-AirTrack($msg) {
    Write-Host "[AirTrack] $msg" -ForegroundColor Green
}
function Write-Warn($msg) {
    Write-Host "[AirTrack] $msg" -ForegroundColor Yellow
}
function Write-Fail($msg) {
    Write-Host "[AirTrack] ERROR: $msg" -ForegroundColor Red
    exit 1
}

Write-Host ""
Write-Host "  ✈  AirTrack Lite 1.0.0 `"Wilbur`" — Windows Installer" -ForegroundColor Cyan
Write-Host "  ────────────────────────────────────────────────────" -ForegroundColor Cyan
Write-Host ""

# ── Check Docker Desktop ──────────────────────────────────────────────────────
if (-not (Get-Command "docker" -ErrorAction SilentlyContinue)) {
    Write-Fail "Docker Desktop is not installed or not in PATH.`nPlease install it from: https://www.docker.com/products/docker-desktop/`nEnsure WSL2 is enabled during installation, then re-run this script."
}
Write-AirTrack "Docker found."

# ── Check Docker is running ───────────────────────────────────────────────────
try {
    docker info | Out-Null
} catch {
    Write-Fail "Docker Desktop is installed but not running. Please start Docker Desktop and try again."
}
Write-AirTrack "Docker is running."

# ── Set up .env if not present ────────────────────────────────────────────────
if (-not (Test-Path ".env")) {
    Write-AirTrack "Creating .env from template..."
    Copy-Item ".env.template" ".env"
    Write-AirTrack ".env created with default settings."
} else {
    Write-AirTrack ".env already exists — skipping."
}

# ── Decompress init.sql if needed ─────────────────────────────────────────────
$sqlGz  = "app\mariadb-init\init.sql.gz"
$sqlOut = "app\mariadb-init\init.sql"
if ((Test-Path $sqlGz) -and (-not (Test-Path $sqlOut))) {
    Write-AirTrack "Decompressing database..."
    $input  = [System.IO.File]::OpenRead((Resolve-Path $sqlGz))
    $output = [System.IO.File]::Create((Join-Path (Get-Location) $sqlOut))
    $gz     = New-Object System.IO.Compression.GZipStream($input, [System.IO.Compression.CompressionMode]::Decompress)
    $gz.CopyTo($output)
    $gz.Close(); $output.Close(); $input.Close()
    Write-AirTrack "Database decompressed."
}

# ── Build and start ───────────────────────────────────────────────────────────
Write-AirTrack "Building AirTrack Lite containers (this may take a few minutes)..."
docker compose build
if ($LASTEXITCODE -ne 0) { Write-Fail "Docker build failed." }

Write-AirTrack "Starting AirTrack Lite..."
docker compose up -d
if ($LASTEXITCODE -ne 0) { Write-Fail "Docker Compose failed to start." }

# ── Wait for app ──────────────────────────────────────────────────────────────
Write-AirTrack "Waiting for AirTrack to start..."
$ready = $false
for ($i = 0; $i -lt 30; $i++) {
    try {
        $r = Invoke-WebRequest -Uri "http://localhost:5000" -UseBasicParsing -TimeoutSec 2
        if ($r.StatusCode -eq 200) { $ready = $true; break }
    } catch {}
    Start-Sleep -Seconds 2
}

Write-Host ""
Write-Host "  ✔  AirTrack Lite is running!" -ForegroundColor Green
Write-Host ""
Write-Host "  Open your browser and go to:  http://localhost:5000"
Write-Host ""
Write-Host "  To stop AirTrack:   docker compose down"
Write-Host "  To start it again:  docker compose up -d"
Write-Host ""

# Open browser automatically
Start-Process "http://localhost:5000"
