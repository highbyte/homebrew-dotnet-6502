class Dotnet6502Remote < Formula
  desc "Remote control CLI client for the dotnet-6502 emulator"
  homepage "https://github.com/highbyte/dotnet-6502"
  version "0.31.2-alpha"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/highbyte/dotnet-6502/releases/download/v#{version}/DotNet6502-RemoteClient-osx-arm64.zip"
      sha256 "7b3f6d35b2daf1e5ebd13d2355a87229727111cc46c9b276cd5d434e63ff1fab"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/highbyte/dotnet-6502/releases/download/v#{version}/DotNet6502-RemoteClient-linux-x64.zip"
      sha256 "13cd93e95c0bb5445ab81bf1380c566369526736ef987ec0c0c5ea2bc83ec0ad"
    end
    on_arm do
      url "https://github.com/highbyte/dotnet-6502/releases/download/v#{version}/DotNet6502-RemoteClient-linux-arm64.zip"
      sha256 "5246e658495192453e574fe0d5f44d02163a301b3a0205dabb27a5a1bebacde2"
    end
  end

  def install
    # Install everything into libexec (app needs native libs in same directory)
    libexec.install Dir["*"]
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
