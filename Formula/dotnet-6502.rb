class DotNet6502 < Formula
  desc "6502 CPU and C64 emulator built with .NET and Avalonia"
  homepage "https://github.com/highbyte/dotnet-6502"
  version "0.29.0-alpha"
  license "MIT"

  on_linux do
    on_intel do
      url "https://github.com/highbyte/dotnet-6502/releases/download/v#{version}/DotNet6502-Avalonia-linux-x64.zip"
      sha256 "d4e0b4541ffb8f4113f4a4dcf504ff6c13cf186a44bae8bcbff37a4fcbd8a5c6"
    end
    on_arm do
      url "https://github.com/highbyte/dotnet-6502/releases/download/v#{version}/DotNet6502-Avalonia-linux-arm64.zip"
      sha256 "4b356beb4b43bc897938d80fb788f0d961b179238d5dc5cb4212a125cf6e9701"
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
