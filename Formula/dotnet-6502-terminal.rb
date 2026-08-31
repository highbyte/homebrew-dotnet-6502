class Dotnet6502Terminal < Formula
  desc "Interactive terminal (TUI) 6502/C64 emulator host"
  homepage "https://github.com/highbyte/dotnet-6502"
  version "0.44.2-alpha"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/highbyte/dotnet-6502/releases/download/v#{version}/DotNet6502-Terminal-osx-arm64.zip"
      sha256 "1ff059a0e4468ac245593c21885231ad4578299450878fa08c65a183cebd524c"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/highbyte/dotnet-6502/releases/download/v#{version}/DotNet6502-Terminal-linux-x64.zip"
      sha256 "dcb7827883dc087895bfae4029bcbeb2923aedfe791bf43cd36ee33e686c0040"
    end
    on_arm do
      url "https://github.com/highbyte/dotnet-6502/releases/download/v#{version}/DotNet6502-Terminal-linux-arm64.zip"
      sha256 "e884081abee7e43f9aa2f56b78d506464ff3fede9e98de791e826ea94e717166"
    end
  end

  def install
    # Install everything into libexec (app needs native libs in same directory)
    libexec.install Dir["*"]
    # Marker read by the app's in-app update checker to confirm a Homebrew install
    # (Highbyte.DotNet6502.Updates.InstallChannelDetector); the app runs from libexec.
    (libexec/"install-channel").write "homebrew\n"
    # Shell wrapper that launches the executable from libexec
    (bin/"dotnet-6502-terminal").write <<~EOS
      #!/bin/bash
      exec "#{libexec}/Highbyte.DotNet6502.App.Terminal" "$@"
    EOS
  end

  test do
    assert_predicate bin/"dotnet-6502-terminal", :exist?
  end
end
