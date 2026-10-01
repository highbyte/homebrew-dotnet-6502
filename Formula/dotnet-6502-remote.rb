class Dotnet6502Remote < Formula
  desc "Remote control CLI client for the dotnet-6502 emulator"
  homepage "https://github.com/highbyte/dotnet-6502"
  version "0.47.0-alpha"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/highbyte/dotnet-6502/releases/download/v#{version}/DotNet6502-RemoteClient-osx-arm64.zip"
      sha256 "cc8e06e12b99d90c464ba1890f81886b69fb2f238e174252f462f55b0c9b4044"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/highbyte/dotnet-6502/releases/download/v#{version}/DotNet6502-RemoteClient-linux-x64.zip"
      sha256 "fc53bf78464fc5a25bb4752c369566bb197102038a759c0554ad4383bd7080bf"
    end
    on_arm do
      url "https://github.com/highbyte/dotnet-6502/releases/download/v#{version}/DotNet6502-RemoteClient-linux-arm64.zip"
      sha256 "c198065068206ce5dd39754a2e85dd583bd9112fcd808acb01b496a2f96aa9fa"
    end
  end

  def install
    # Install everything into libexec (app needs native libs in same directory)
    libexec.install Dir["*"]
    # Marker read by the app's in-app update checker to confirm a Homebrew install
    # (Highbyte.DotNet6502.Updates.InstallChannelDetector); the app runs from libexec.
    (libexec/"install-channel").write "homebrew\n"
    # Shell wrapper that launches the executable from libexec
    (bin/"dotnet-6502-remote").write <<~EOS
      #!/bin/bash
      exec "#{libexec}/Highbyte.DotNet6502.App.RemoteClient" "$@"
    EOS
  end

  test do
    assert_predicate bin/"dotnet-6502-remote", :exist?
  end
end
