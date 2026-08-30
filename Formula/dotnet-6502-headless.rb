class Dotnet6502Headless < Formula
  desc "Headless 6502/C64 emulator driven by CLI arguments and Lua scripts"
  homepage "https://github.com/highbyte/dotnet-6502"
  version "0.44.1-alpha"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/highbyte/dotnet-6502/releases/download/v#{version}/DotNet6502-Headless-osx-arm64.zip"
      sha256 "96122be012577f61e4ff6eb06cd1e94253cc43ae6cb31629e737d3c2c90a166e"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/highbyte/dotnet-6502/releases/download/v#{version}/DotNet6502-Headless-linux-x64.zip"
      sha256 "2ed68290b55cde85cb8c3d0f93b18143328ccff497b12c89108137f18c90518e"
    end
    on_arm do
      url "https://github.com/highbyte/dotnet-6502/releases/download/v#{version}/DotNet6502-Headless-linux-arm64.zip"
      sha256 "e705adba1e4f6f497789859f2e15083895ba88d1635153b8ace24ef709bb70d2"
    end
  end

  def install
    # Install everything into libexec (app needs native libs in same directory)
    libexec.install Dir["*"]
    # Marker read by the app's in-app update checker to confirm a Homebrew install
    # (Highbyte.DotNet6502.Updates.InstallChannelDetector); the app runs from libexec.
    (libexec/"install-channel").write "homebrew\n"
    # Shell wrapper that launches the executable from libexec
    (bin/"dotnet-6502-headless").write <<~EOS
      #!/bin/bash
      exec "#{libexec}/Highbyte.DotNet6502.App.Headless" "$@"
    EOS
  end

  test do
    assert_predicate bin/"dotnet-6502-headless", :exist?
  end
end
