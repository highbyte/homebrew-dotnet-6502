class Dotnet6502Headless < Formula
  desc "Headless 6502/C64 emulator driven by CLI arguments and Lua scripts"
  homepage "https://github.com/highbyte/dotnet-6502"
  version "0.31.2-alpha"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/highbyte/dotnet-6502/releases/download/v#{version}/DotNet6502-Headless-osx-arm64.zip"
      sha256 "9aea6c5f5cc2e06f361b8bcc0d6585f17e8c771e56df28bb4fd1d48584de231b"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/highbyte/dotnet-6502/releases/download/v#{version}/DotNet6502-Headless-linux-x64.zip"
      sha256 "6d239e859de398c4f261831f8a7b4ecd9b9a0883341107aeb539424b2d789231"
    end
    on_arm do
      url "https://github.com/highbyte/dotnet-6502/releases/download/v#{version}/DotNet6502-Headless-linux-arm64.zip"
      sha256 "e46e5122186ff4ddfe3076f7b1e787e37e6fdd14f7568d07a45ea5e65643e39f"
    end
  end

  def install
    # Install everything into libexec (app needs native libs in same directory)
    libexec.install Dir["*"]
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
