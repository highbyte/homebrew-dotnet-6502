class Dotnet6502 < Formula
  desc "6502 CPU and C64 emulator built with .NET and Avalonia"
  homepage "https://github.com/highbyte/dotnet-6502"
  version "0.29.2-alpha"
  license "MIT"

  on_linux do
    on_intel do
      url "https://github.com/highbyte/dotnet-6502/releases/download/v#{version}/DotNet6502-Avalonia-linux-x64.zip"
      sha256 "a68066bf49f1dd1db514540fd35259d4a2b9f3e8e6a76097941c71c0569709ad"
    end
    on_arm do
      url "https://github.com/highbyte/dotnet-6502/releases/download/v#{version}/DotNet6502-Avalonia-linux-arm64.zip"
      sha256 "72483201c60a45bfa5fc86413ee0f3fdef891a7ac1a0b40eeb6c3dac36fa0fba"
    end
  end

  def install
    # Install everything into libexec (app needs native libs in same directory)
    libexec.install Dir["*"]
    # Wrapper script that launches from libexec so native libs are found
    (bin/"dotnet-6502").write_env_script libexec/"Highbyte.DotNet6502.App.Avalonia.Desktop"
  end

  test do
    assert_predicate bin/"dotnet-6502", :exist?
  end
end
