class Dotnet6502Remote < Formula
  desc "Remote control CLI client for the dotnet-6502 emulator"
  homepage "https://github.com/highbyte/dotnet-6502"
  version "0.32.1-alpha"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/highbyte/dotnet-6502/releases/download/v#{version}/DotNet6502-RemoteClient-osx-arm64.zip"
      sha256 "ed244f86256ba47473f341691415a8102a208ae360c665a282a210981e00b20a"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/highbyte/dotnet-6502/releases/download/v#{version}/DotNet6502-RemoteClient-linux-x64.zip"
      sha256 "d17c95a3e36096ad390fb6da16a0f4b7a45abfed40a4c8a9fe5999c7e74cfb86"
    end
    on_arm do
      url "https://github.com/highbyte/dotnet-6502/releases/download/v#{version}/DotNet6502-RemoteClient-linux-arm64.zip"
      sha256 "e1728d0de72a1c97d37d478c28ca414cd75c10db86333b45254a5dda69840592"
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
