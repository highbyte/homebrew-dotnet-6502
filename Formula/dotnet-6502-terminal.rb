class Dotnet6502Terminal < Formula
  desc "Interactive terminal (TUI) 6502/C64 emulator host"
  homepage "https://github.com/highbyte/dotnet-6502"
  version "0.42.2-alpha"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/highbyte/dotnet-6502/releases/download/v#{version}/DotNet6502-Terminal-osx-arm64.zip"
      sha256 "49837653df41378ae21a061a49eae8085f26b8285bfc14b3c26b17b9195be0bd"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/highbyte/dotnet-6502/releases/download/v#{version}/DotNet6502-Terminal-linux-x64.zip"
      sha256 "42d4410c4ed0c65982963312b6e4a02358addc5ed941335bf39e9f0ba21886d6"
    end
    on_arm do
      url "https://github.com/highbyte/dotnet-6502/releases/download/v#{version}/DotNet6502-Terminal-linux-arm64.zip"
      sha256 "0053b6af369bf79f837faa155cc4c5e94599d687b58577b580b3ecd30b7be981"
    end
  end

  def install
    # Install everything into libexec (app needs native libs in same directory)
    libexec.install Dir["*"]
    # Marker read by the app's in-app update checker to confirm a Homebrew install
    # (Highbyte.DotNet6502.Updates.InstallChannelDetector); the app runs from libexec.
    (libexec/"install-channel").write "homebrew\n"
    # Shell wrapper that launches the executable from libexec
    (bin/"dotnet-6502-terminal").write <<~EOS
      #!/bin/bash
      exec "#{libexec}/Highbyte.DotNet6502.App.Terminal" "$@"
    EOS
  end

  test do
    assert_predicate bin/"dotnet-6502-terminal", :exist?
  end
end
