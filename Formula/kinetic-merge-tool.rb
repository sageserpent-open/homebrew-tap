# Generated with JReleaser 1.26.0 at 2026-10-28T21:11:07.333172465Z

class KineticMergeTool < Formula
  desc "Merge a heavily refactored codebase and stay sane."
  homepage "https://github.com/sageserpent-open/kineticMerge"
  version "1.23.0"
  license "MIT"

  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/sageserpent-open/kineticMerge/releases/download/v1.23.0/kinetic-merge-tool-1.23.0-linux-x86_64.zip"
    sha256 "dd557744b86d7ded1b1da245251c2a004df0285d97a86eb44994a9b6498d9e2c"
  end
  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/sageserpent-open/kineticMerge/releases/download/v1.23.0/kinetic-merge-tool-1.23.0-osx-aarch_64.zip"
    sha256 "cf998ff54e79bf757a17c68719e79e032d047f1416d1f59e7a052eeebfc1a6ef"
  end
  if OS.mac? && Hardware::CPU.intel?
    url "https://github.com/sageserpent-open/kineticMerge/releases/download/v1.23.0/kinetic-merge-tool-1.23.0-osx-x86_64.zip"
    sha256 "4a3e23f1e33d0c0ac9fe5652469646f4322ea7d8e5b3c082e935071fff2f831b"
  end


  def install
    libexec.install Dir["*"]
    bin.install_symlink "#{libexec}/bin/kinetic-merge-tool" => "kinetic-merge-tool"
  end

  def post_install
    if OS.mac?
      Dir["#{libexec}/lib/**/*.dylib"].each do |dylib|
        chmod 0664, dylib
        MachO::Tools.change_dylib_id(dylib, "@rpath/#{File.basename(dylib)}")
        MachO.codesign!(dylib)
        chmod 0444, dylib
      end
    end
  end

  test do
    output = shell_output("#{bin}/kinetic-merge-tool --version")
    assert_match "1.23.0", output
  end
end
