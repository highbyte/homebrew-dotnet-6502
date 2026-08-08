class Dotnet6502Remote < Formula
  desc "Remote control CLI client for the dotnet-6502 emulator"
  homepage "https://github.com/highbyte/dotnet-6502"
  version "0.42.0-alpha"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/highbyte/dotnet-6502/releases/download/v#{version}/DotNet6502-RemoteClient-osx-arm64.zip"
      sha256 "aee418e19a153d5b3c55229a7dbbb86a95751828ed2f4b145f7bb645a163e848"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/highbyte/dotnet-6502/releases/download/v#{version}/DotNet6502-RemoteClient-linux-x64.zip"
      sha256 "91d89f74224d3274175739e11e09a3143889b84b047991ddea881ce15ec65346"
    end
    on_arm do
      url "https://github.com/highbyte/dotnet-6502/releases/download/v#{version}/DotNet6502-RemoteClient-linux-arm64.zip"
      sha256 "cf2d41d872c5c6dd30d1a5c11bac66276829eb705e164e3c9e633a51bb01d0b9"
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
