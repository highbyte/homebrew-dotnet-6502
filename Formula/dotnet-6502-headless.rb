class Dotnet6502Headless < Formula
  desc "Headless 6502/C64 emulator driven by CLI arguments and Lua scripts"
  homepage "https://github.com/highbyte/dotnet-6502"
  version "0.33.0-alpha"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/highbyte/dotnet-6502/releases/download/v#{version}/DotNet6502-Headless-osx-arm64.zip"
      sha256 "7c52eee8aa649952fb584b5bf796f6c9d12d3ec530c5840e2a1e5c1726504541"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/highbyte/dotnet-6502/releases/download/v#{version}/DotNet6502-Headless-linux-x64.zip"
      sha256 "95b27f443b1dad28a95810f5b1a93e82d645ff762c376d670da4b9df393291b6"
    end
    on_arm do
      url "https://github.com/highbyte/dotnet-6502/releases/download/v#{version}/DotNet6502-Headless-linux-arm64.zip"
      sha256 "570c3ef411ab11c86754652247357e87f7554bbf83b523839d5bae01934f8901"
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
