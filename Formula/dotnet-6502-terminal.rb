class Dotnet6502Terminal < Formula
  desc "Interactive terminal (TUI) 6502/C64 emulator host"
  homepage "https://github.com/highbyte/dotnet-6502"
  version "0.46.0-alpha"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/highbyte/dotnet-6502/releases/download/v#{version}/DotNet6502-Terminal-osx-arm64.zip"
      sha256 "1a12043367dfd4dfb6ab3e1ff737e42c3c02968cb0d7123b9e8e4015f4f7b596"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/highbyte/dotnet-6502/releases/download/v#{version}/DotNet6502-Terminal-linux-x64.zip"
      sha256 "e665dd01e1fed27b5e63388c2353816f6a840e41e56f17918b70c4b3ebb9589d"
    end
    on_arm do
      url "https://github.com/highbyte/dotnet-6502/releases/download/v#{version}/DotNet6502-Terminal-linux-arm64.zip"
      sha256 "3f80ddcfd34c168282a65951ddaa351963e52466c194f80bad7a2d3109565380"
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
