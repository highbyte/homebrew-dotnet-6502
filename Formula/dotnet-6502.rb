class Dotnet6502 < Formula
  desc "6502 CPU and C64 emulator built with .NET and Avalonia"
  homepage "https://github.com/highbyte/dotnet-6502"
  version "0.36.0-alpha"
  license "MIT"

  on_linux do
    on_intel do
      url "https://github.com/highbyte/dotnet-6502/releases/download/v#{version}/DotNet6502-Avalonia-linux-x64.zip"
      sha256 "5e4199e665948a05355a19a5d97b11a10f59fc52fef87e62503c03ea5e24ee71"
    end
    on_arm do
      url "https://github.com/highbyte/dotnet-6502/releases/download/v#{version}/DotNet6502-Avalonia-linux-arm64.zip"
      sha256 "0f6201e56891f3f2a6e6337719f89cc97c89b5f10bd5c7867fde11ca7f84b0e4"
    end
  end

  def install
    # Install everything into libexec (app needs native libs in same directory)
    libexec.install Dir["*"]
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
