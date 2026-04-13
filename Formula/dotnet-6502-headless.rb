class Dotnet6502Headless < Formula
  desc "Headless 6502/C64 emulator driven by CLI arguments and Lua scripts"
  homepage "https://github.com/highbyte/dotnet-6502"
  version "0.29.11-alpha"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/highbyte/dotnet-6502/releases/download/v#{version}/DotNet6502-Headless-osx-arm64.zip"
      sha256 "b5c7a105acba2680111b6c9f7d5802dcac2ab26c42bb44ea5e9e3d2a9e9718fc"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/highbyte/dotnet-6502/releases/download/v#{version}/DotNet6502-Headless-linux-x64.zip"
      sha256 "e01d94383e241c885dbab34b296e6adcf128ce993b95c236521f6069ef6e44c9"
    end
    on_arm do
      url "https://github.com/highbyte/dotnet-6502/releases/download/v#{version}/DotNet6502-Headless-linux-arm64.zip"
      sha256 "cd47dc0586dad95c6daae2bd176cc71705427c6ee8ca256efb71a99b81baa2af"
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
