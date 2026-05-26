# AirTrack Lite 1.0.0 "Wilbur"

### Free self-hosted aircraft tracking for planespotters and aviation enthusiasts.

[![Version](https://img.shields.io/badge/version-1.0.0%20Wilbur-blue)](https://airtracksolutions.com.au)
[![Platform](https://img.shields.io/badge/platform-Linux%20%7C%20Raspberry%20Pi-lightgrey)](https://airtracksolutions.com.au)
[![License](https://img.shields.io/badge/license-Free%20for%20personal%20use-green)](https://airtracksolutions.com.au)
[![Discord](https://img.shields.io/discord/1388676733842227210?label=Discord&logo=discord&color=5865F2)](https://discord.gg/NsmUxZmuY)

> **AirTrack Lite** is a free, fully functional build of AirTrack with a 100-aircraft cap.
> Everything works. Same interface, same database, same installer.
> When you outgrow 100 aircraft, the full version is waiting.

---

## What is AirTrack?

AirTrack is a locally-installed, offline-first aircraft tracking suite. It runs entirely on your own hardware — Linux desktop or Raspberry Pi — with no cloud, no subscriptions, and no data leaving your machine.

You log what you see. You own what you log. Nobody else gets a look at it.

Most aviation software is built around airlines and commercial traffic. AirTrack is built around the question planespotters actually ask: **what is that aircraft, where is it registered, and have I seen it before?**

---

## What's in the box

**A registration database — 78 countries, 417,000+ records, fully offline.**
Civil aircraft registrations for 78 countries are bundled with AirTrack. No API keys. No internet lookups. You see a registration, AirTrack already knows it.

**A sightings and flights logbook.**
Log aircraft you've seen, flights you've tracked, and build a personal history. Search by registration, airline, type, country, or ICAO/IATA code.

**Aircraft photo storage.**
Attach your own photos to aircraft records. Stored locally, never uploaded anywhere.

**Aria — an AI assistant running on your own machine.**
Ask Aria questions in plain English. *"How many A320s have I logged?"* She queries your local database and answers. Powered by phi4-mini via Ollama — no data sent to any cloud service.

**Works with ADS-B.**
Designed to sit alongside dump1090, FR24, or any ADS-B feeder. AirTrack becomes the logging and identification layer on top of your live SDR feed.

---

## Lite vs Full

| Feature | Lite (Free) | Full |
|:--------|:-----------:|:----:|
| Aircraft records | Up to 100 | Unlimited |
| Registration database (50 countries) | ✅ | ✅ |
| Sightings & flights logbook | ✅ | ✅ |
| Photo management | ✅ | ✅ |
| Aria AI assistant | ✅ | ✅ |
| ADS-B integration | ✅ | ✅ |
| Android companion app | ✅ | ✅ |
| Multi-node Pi fleet support | ✅ | ✅ |
| Price | Free | Contact us |

---

## System requirements

| Component | Requirement |
|:----------|:------------|
| OS | Linux Desktop (Ubuntu / Pop!_OS / Mint) or Raspberry Pi OS 64-bit |
| Docker | Required (installer will install if missing) |
| Docker Compose | Required (installer will install if missing) |
| RAM | 2 GB minimum |
| Storage | SSD recommended; SD card works on Pi |
| Browser | Chrome, Firefox, Edge, or Safari |

Aria requires Ollama with phi4-mini. Optional — AirTrack works fine without it.

---

## Installation

```bash
# 1. Download and unzip AirTrack Lite
# 2. Open a terminal in the extracted folder

chmod +x install_airtrack.sh
./install_airtrack.sh
```

When installation completes, open your browser:

```
http://localhost:5000
```

You're flying.

---

## Starting and stopping

```bash
./start.sh    # Start AirTrack
./stop.sh     # Stop AirTrack
```

---

## Community

Come and show us your setup, ask questions, or just talk planes.

👉 **[Join AirTrack Solutions on Discord](https://discord.gg/NsmUxZmuY)**

---

## Release codenames

AirTrack releases are named after aviation pioneers.

| Version | Codename | Person |
|:--------|:---------|:-------|
| 0.9.x | Orville | Orville Wright — pilot of the first controlled powered flight, Kitty Hawk, 17 December 1903 |
| 1.0.0 | Wilbur | Wilbur Wright — aviation innovator and co-architect of powered flight |

---

## Philosophy

Your data belongs to you.

- No cloud accounts
- No telemetry
- No subscriptions
- No dependency on our servers
- Works completely offline
- Runs on hardware you already own

If AirTrack Solutions disappeared tomorrow, every installation would keep running exactly as it does today.

---

## License

AirTrack Lite is **free for personal, non-commercial use**.
Redistribution or resale without written permission is prohibited.
All data you store with AirTrack belongs entirely to you.

The full AirTrack system is available under a separate commercial licence.

---

## Acknowledgements

- **Trevor** — Founder, architect, captain of AirTrack Solutions
- **Samowal** — Creator of the original PHP concept this grew from
- **Bob** — AI co-pilot and general voice of reason
- Every planespotter who looks up when something flies overhead

---

*Built by aviation enthusiasts, for aviation enthusiasts.*

**[airtracksolutions.com.au](https://airtracksolutions.com.au) · [Discord](https://discord.gg/NsmUxZmuY)**
