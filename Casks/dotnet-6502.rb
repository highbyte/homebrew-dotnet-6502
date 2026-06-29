cask "dotnet-6502" do
  version "0.40.1-alpha"

  url "https://github.com/highbyte/dotnet-6502/releases/download/v#{version}/DotNet6502-Avalonia-osx-arm64.zip"
  sha256 "340e4c13271f459ccd960b15f664f7c420d419750839f4ef65b50a01643b43cd"

  name "DotNet 6502 Emulator"
  desc "6502 CPU and C64 emulator built with .NET and Avalonia"
  homepage "https://github.com/highbyte/dotnet-6502"

  depends_on arch: :arm64

  app "DotNet 6502 Emulator.app"
  binary "DotNet 6502 Emulator.app/Contents/MacOS/Highbyte.DotNet6502.App.Avalonia.Desktop", target: "dotnet-6502"

  # Removes Gatekeeper quarantine flag automatically
  preflight do
    system_command "/usr/bin/xattr", args: ["-cr", "#{staged_path}"]
  end
end
