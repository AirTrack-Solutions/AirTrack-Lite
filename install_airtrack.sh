#!/usr/bin/env bash
# AirTrack Lite 1.0.0 "Wilbur" — Linux / Raspberry Pi Installer
# Copyright (c) 2025 Trevor ("Subhuti"). All rights reserved.
# SPDX-License-Identifier: LicenseRef-AirTrack-Proprietary-NC

set -e

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

info()    { echo -e "${GREEN}[AirTrack]${NC} $1"; }
warning() { echo -e "${YELLOW}[AirTrack]${NC} $1"; }
error()   { echo -e "${RED}[AirTrack]${NC} $1"; exit 1; }

echo ""
echo "  ✈  AirTrack Lite 1.0.0 \"Wilbur\" — Installer"
echo "  ─────────────────────────────────────────────"
echo ""

# ── Check OS ──────────────────────────────────────────────────────────────────
if [[ "$OSTYPE" != "linux-gnu"* ]]; then
    error "This installer is for Linux only. Use install_airtrack_windows.ps1 on Windows."
fi

# ── Install Docker if needed ──────────────────────────────────────────────────
if ! command -v docker &>/dev/null; then
    info "Docker not found. Installing Docker..."
    curl -fsSL https://get.docker.com | sh
    sudo usermod -aG docker "$USER"
    warning "Docker installed. You may need to log out and back in for group permissions to take effect."
else
    info "Docker is already installed."
fi

# ── Install Docker Compose if needed ─────────────────────────────────────────
if ! docker compose version &>/dev/null 2>&1; then
    if ! command -v docker-compose &>/dev/null; then
        info "Installing Docker Compose..."
        sudo apt-get update -qq
        sudo apt-get install -y docker-compose-plugin 2>/dev/null || \
        sudo apt-get install -y docker-compose 2>/dev/null || \
        error "Could not install Docker Compose. Please install it manually: https://docs.docker.com/compose/install/"
    fi
fi
info "Docker Compose is available."

# ── Set up .env if not present ────────────────────────────────────────────────
if [ ! -f ".env" ]; then
    info "Creating .env from template..."
    cp .env.template .env
    info ".env created with default settings. Edit it if you need custom configuration."
else
    info ".env already exists — skipping."
fi

# ── Decompress init.sql if needed ─────────────────────────────────────────────
if [ -f "app/mariadb-init/init.sql.gz" ] && [ ! -f "app/mariadb-init/init.sql" ]; then
    info "Decompressing database..."
    gunzip app/mariadb-init/init.sql.gz
fi

# ── Export UID/GID for Docker ─────────────────────────────────────────────────
export UID="${UID:-$(id -u)}"
export GID="${GID:-$(id -g)}"

# ── Pull images and build ─────────────────────────────────────────────────────
info "Building AirTrack Lite containers (this may take a few minutes)..."
docker compose pull airtrack-db --quiet 2>/dev/null || true
docker compose build --quiet

# ── Start AirTrack ────────────────────────────────────────────────────────────
info "Starting AirTrack Lite..."
docker compose up -d

# ── Wait for app to be ready ──────────────────────────────────────────────────
info "Waiting for AirTrack to start..."
for i in {1..30}; do
    if curl -s http://localhost:5000 > /dev/null 2>&1; then
        break
    fi
    sleep 2
done

echo ""
echo -e "  ${GREEN}✔  AirTrack Lite is running!${NC}"
echo ""
echo "  Open your browser and go to:  http://localhost:5000"
echo ""
echo "  To stop AirTrack:   docker compose down"
echo "  To start it again:  docker compose up -d"
echo ""
