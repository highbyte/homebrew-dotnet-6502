class Dotnet6502Headless < Formula
  desc "Headless 6502/C64 emulator driven by CLI arguments and Lua scripts"
  homepage "https://github.com/highbyte/dotnet-6502"
  version "0.36.1-alpha"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/highbyte/dotnet-6502/releases/download/v#{version}/DotNet6502-Headless-osx-arm64.zip"
      sha256 "31a948ede6fa041ed1ea81ba167628108eaf97f8e014ee13e61a9f73e2724627"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/highbyte/dotnet-6502/releases/download/v#{version}/DotNet6502-Headless-linux-x64.zip"
      sha256 "98059112d6b916eeddc066fbbd3cce76fe9b8993fa7bac0ff4107cc50a84216c"
    end
    on_arm do
      url "https://github.com/highbyte/dotnet-6502/releases/download/v#{version}/DotNet6502-Headless-linux-arm64.zip"
      sha256 "779ebac2a5118c34a52387248847f50c334066e2648c30642bee8b49eb9ad3a9"
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
