class Dotnet6502Terminal < Formula
  desc "Interactive terminal (TUI) 6502/C64 emulator host"
  homepage "https://github.com/highbyte/dotnet-6502"
  version "0.39.0-alpha"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/highbyte/dotnet-6502/releases/download/v#{version}/DotNet6502-Terminal-osx-arm64.zip"
      sha256 "bf8d83b1d897837d5751c05bda872f5352e9d0ff9f25fa559f1e899e4b40a3f5"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/highbyte/dotnet-6502/releases/download/v#{version}/DotNet6502-Terminal-linux-x64.zip"
      sha256 "1da1c8ac103107ab38419e1e1e527cfb3dc7f8e02dc55405d3b9012aee9c8a63"
    end
    on_arm do
      url "https://github.com/highbyte/dotnet-6502/releases/download/v#{version}/DotNet6502-Terminal-linux-arm64.zip"
      sha256 "b9fea0377fce6bf8cedca91b46a1c20abd8a6bb41c2e0e8f0f75b62194efd92d"
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
