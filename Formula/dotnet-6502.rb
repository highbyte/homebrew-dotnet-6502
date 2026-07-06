class Dotnet6502 < Formula
  desc "6502 CPU and C64 emulator built with .NET and Avalonia"
  homepage "https://github.com/highbyte/dotnet-6502"
  version "0.41.2-alpha"
  license "MIT"

  on_linux do
    on_intel do
      url "https://github.com/highbyte/dotnet-6502/releases/download/v#{version}/DotNet6502-Avalonia-linux-x64.zip"
      sha256 "6b573d76eea0e26a9e4af9d378085a8c5078c40c5d397c2b62cd5ea7bab679d2"
    end
    on_arm do
      url "https://github.com/highbyte/dotnet-6502/releases/download/v#{version}/DotNet6502-Avalonia-linux-arm64.zip"
      sha256 "51058fdb0835eba4f57e6240bb84e289dc887018959fbe7160536fda276a715b"
    end
  end

  def install
    # Install everything into libexec (app needs native libs in same directory)
    libexec.install Dir["*"]
    # Marker read by the app's in-app update checker to confirm a Homebrew install
    # (Highbyte.DotNet6502.Updates.InstallChannelDetector); the app runs from libexec.
    (libexec/"install-channel").write "homebrew\n"
    # Shell wrapper that launches the executable from libexec
    # On ARM64 Linux, SkiaSharp requires preloading libfreetype and libuuid
    # to resolve missing symbols (FT_Get_BDF_Property, uuid_generate_random).
    # Library paths below are for Ubuntu/Debian (Homebrew's primary Linux target).
    (bin/"dotnet-6502").write <<~EOS
      #!/bin/bash
      if [ "$(uname -m)" = "aarch64" ]; then
        for lib in /lib/aarch64-linux-gnu/libfreetype.so.6 /lib/aarch64-linux-gnu/libuuid.so.1; do
          [ -f "$lib" ] && export LD_PRELOAD="${LD_PRELOAD:+$LD_PRELOAD }$lib"
        done
      fi
      exec "#{libexec}/Highbyte.DotNet6502.App.Avalonia.Desktop" "$@"
    EOS
  end

  test do
    assert_predicate bin/"dotnet-6502", :exist?
  end
end
