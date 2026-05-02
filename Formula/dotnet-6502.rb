class Dotnet6502 < Formula
  desc "6502 CPU and C64 emulator built with .NET and Avalonia"
  homepage "https://github.com/highbyte/dotnet-6502"
  version "0.31.3-alpha"
  license "MIT"

  on_linux do
    on_intel do
      url "https://github.com/highbyte/dotnet-6502/releases/download/v#{version}/DotNet6502-Avalonia-linux-x64.zip"
      sha256 "25ac6bdc6788d35a9942e4c525870788b1bee1225687bcedd1cab39f20688955"
    end
    on_arm do
      url "https://github.com/highbyte/dotnet-6502/releases/download/v#{version}/DotNet6502-Avalonia-linux-arm64.zip"
      sha256 "acd73b94e456b053ed08218abbb6b4c7726e483e94509aee3f0f4ea3e1b2b507"
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
