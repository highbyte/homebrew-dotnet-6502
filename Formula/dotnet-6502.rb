class DotNet6502 < Formula
  desc "6502 CPU and C64 emulator built with .NET and Avalonia"
  homepage "https://github.com/highbyte/dotnet-6502"
  version "0.28.3-alpha"
  license "MIT"

  on_linux do
    on_intel do
      url "https://github.com/highbyte/dotnet-6502/releases/download/v#{version}/DotNet6502-Avalonia-linux-x64.zip"
      sha256 "PLACEHOLDER_LINUX_X64"
    end
    on_arm do
      url "https://github.com/highbyte/dotnet-6502/releases/download/v#{version}/DotNet6502-Avalonia-linux-arm64.zip"
      sha256 "PLACEHOLDER_LINUX_ARM64"
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
