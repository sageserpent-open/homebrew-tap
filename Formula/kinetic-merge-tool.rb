# Generated with JReleaser 1.27.0 at 2026-11-10T07:57:44.213448647Z

class KineticMergeTool < Formula
  desc "Merge a heavily refactored codebase and stay sane."
  homepage "https://github.com/sageserpent-open/kineticMerge"
  version "1.25.1"
  license "MIT"

  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/sageserpent-open/kineticMerge/releases/download/v1.25.1/kinetic-merge-tool-1.25.1-linux-x86_64.zip"
    sha256 "203088e75e47a6eb1767f6443300fd5420a3b9035fa95d8ac9397fd28e44448f"
  end
  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/sageserpent-open/kineticMerge/releases/download/v1.25.1/kinetic-merge-tool-1.25.1-osx-aarch_64.zip"
    sha256 "4864c2e12359e53449bf21489ab0ac389779450af2c639a1cf6cd90815d1d385"
  end
  if OS.mac? && Hardware::CPU.intel?
    url "https://github.com/sageserpent-open/kineticMerge/releases/download/v1.25.1/kinetic-merge-tool-1.25.1-osx-x86_64.zip"
    sha256 "f9ecea9cac6dd8f5d5bffbf6618bb47e3705a78f1f8083532ece64193b18d78b"
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
    assert_match "1.25.1", output
  end
end
