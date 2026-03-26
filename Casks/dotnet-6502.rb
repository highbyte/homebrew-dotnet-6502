cask "dotnet-6502" do
  version "0.29.0-alpha"

  url "https://github.com/highbyte/dotnet-6502/releases/download/v#{version}/DotNet6502-Avalonia-osx-arm64.zip"
  sha256 "cebbaaf02e3d6c3c734a8d54444d8fd58cc8ad78303da11f6e08df0962ac14be"

  name "DotNet6502 Emulator"
  desc "6502 CPU and C64 emulator built with .NET and Avalonia"
  homepage "https://github.com/highbyte/dotnet-6502"

  depends_on arch: :arm64

  app "DotNet6502.app"
  binary "DotNet6502.app/Contents/MacOS/Highbyte.DotNet6502.App.Avalonia.Desktop", target: "dotnet-6502"

  # Removes Gatekeeper quarantine flag automatically
  preflight do
    system_command "/usr/bin/xattr", args: ["-cr", "#{staged_path}"]
  end
end
