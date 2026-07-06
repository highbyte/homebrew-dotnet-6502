class Dotnet6502Remote < Formula
  desc "Remote control CLI client for the dotnet-6502 emulator"
  homepage "https://github.com/highbyte/dotnet-6502"
  version "0.41.1-alpha"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/highbyte/dotnet-6502/releases/download/v#{version}/DotNet6502-RemoteClient-osx-arm64.zip"
      sha256 "4da92cdbdd01ef88453cab65f3afc85265bc1ba00fe7b510eca24776b6e7a74e"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/highbyte/dotnet-6502/releases/download/v#{version}/DotNet6502-RemoteClient-linux-x64.zip"
      sha256 "8861f24659c483f086673580cee34cb0c75eb6bccf7b66c1e17af9b6a7a23457"
    end
    on_arm do
      url "https://github.com/highbyte/dotnet-6502/releases/download/v#{version}/DotNet6502-RemoteClient-linux-arm64.zip"
      sha256 "a1f2a3f1f012f0c41d407cc949d5cec19d1050b35b7346e737b3691ddf772e29"
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
