class Dotnet6502Terminal < Formula
  desc "Interactive terminal (TUI) 6502/C64 emulator host"
  homepage "https://github.com/highbyte/dotnet-6502"
  version "0.37.3-alpha"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/highbyte/dotnet-6502/releases/download/v#{version}/DotNet6502-Terminal-osx-arm64.zip"
      sha256 "0000000000000000000000000000000000000000000000000000000000000000"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/highbyte/dotnet-6502/releases/download/v#{version}/DotNet6502-Terminal-linux-x64.zip"
      sha256 "0000000000000000000000000000000000000000000000000000000000000000"
    end
    on_arm do
      url "https://github.com/highbyte/dotnet-6502/releases/download/v#{version}/DotNet6502-Terminal-linux-arm64.zip"
      sha256 "0000000000000000000000000000000000000000000000000000000000000000"
    end
  end

  def install
    # Install everything into libexec (app needs native libs in same directory)
    libexec.install Dir["*"]
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
