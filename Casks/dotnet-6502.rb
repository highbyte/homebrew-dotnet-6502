cask "dotnet-6502" do
  version "0.41.4-alpha"

  url "https://github.com/highbyte/dotnet-6502/releases/download/v#{version}/DotNet6502-Avalonia-osx-arm64.zip"
  sha256 "8ef36d9fa95bfc48793131c0755d45bb6cf553d4779156b2faea03a2d63f315b"

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

  # Marker read by the app's in-app update checker to confirm a Homebrew (cask) install
  # (Highbyte.DotNet6502.Updates.InstallChannelDetector). Written to a support dir rather than
  # inside the .app bundle (which would break signing); removed on uninstall so it can't go stale.
  postflight do
    marker_dir = File.expand_path("~/Library/Application Support/Highbyte/DotNet6502")
    FileUtils.mkdir_p(marker_dir)
    File.write(File.join(marker_dir, "install-channel"), "homebrew\n")
  end

  uninstall_postflight do
    FileUtils.rm_f(File.expand_path("~/Library/Application Support/Highbyte/DotNet6502/install-channel"))
  end
end
