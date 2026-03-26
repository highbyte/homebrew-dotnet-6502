cask "dotnet-6502" do
  version "0.29.5-alpha"

  url "https://github.com/highbyte/dotnet-6502/releases/download/v#{version}/DotNet6502-Avalonia-osx-arm64.zip"
  sha256 "47041f659c9449ef484a36f22e63e1bb49b222e7b0d3c29a1335fe3c7af902b9"

  name "DotNet6502 Emulator"
  desc "6502 CPU and C64 emulator built with .NET and Avalonia"
  homepage "https://github.com/highbyte/dotnet-6502"

  depends_on arch: :arm64

  app "DotNet6502 Emulator.app"
  binary "DotNet6502 Emulator.app/Contents/MacOS/Highbyte.DotNet6502.App.Avalonia.Desktop", target: "dotnet-6502"

  # Removes Gatekeeper quarantine flag automatically
  preflight do
    system_command "/usr/bin/xattr", args: ["-cr", "#{staged_path}"]
  end
end
