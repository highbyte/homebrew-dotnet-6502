# Homebrew Tap for DotNet6502

Homebrew tap for the [DotNet6502](https://github.com/highbyte/dotnet-6502) emulator — a 6502 CPU and C64 emulator built with .NET and Avalonia.

This tap provides three packages:

- **dotnet-6502** — the desktop emulator app (Avalonia GUI).
- **dotnet-6502-headless** — headless emulator driven by CLI arguments and Lua scripts.
- **dotnet-6502-remote** — remote control CLI client for the emulator.

## Setup

```bash
brew tap highbyte/dotnet-6502
```

## Installation

### dotnet-6502 (desktop app)

#### macOS (Apple Silicon)

```bash
brew install --cask dotnet-6502
```

#### Linux (x64 / ARM64)

```bash
brew install dotnet-6502
```

### dotnet-6502-headless

macOS (Apple Silicon) and Linux (x64 / ARM64):

```bash
brew install dotnet-6502-headless
```

### dotnet-6502-remote

macOS (Apple Silicon) and Linux (x64 / ARM64):

```bash
brew install dotnet-6502-remote
```

## Updating

```bash
brew update
brew upgrade dotnet-6502
brew upgrade dotnet-6502-headless
brew upgrade dotnet-6502-remote
```

## Uninstalling

```bash
# macOS desktop app
brew uninstall --cask dotnet-6502

# Linux desktop app
brew uninstall dotnet-6502

# Headless and remote (macOS and Linux)
brew uninstall dotnet-6502-headless
brew uninstall dotnet-6502-remote
```
