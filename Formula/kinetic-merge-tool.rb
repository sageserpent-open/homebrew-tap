# Generated with JReleaser 1.26.0 at 2026-10-16T17:17:09.741523322Z

class KineticMergeTool < Formula
  desc "Merge a heavily refactored codebase and stay sane."
  homepage "https://github.com/sageserpent-open/kineticMerge"
  version "1.22.0"
  license "MIT"

  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/sageserpent-open/kineticMerge/releases/download/v1.22.0/kinetic-merge-tool-1.22.0-linux-x86_64.zip"
    sha256 "1b4555ed64ee3b202123531c01c5f3dd8b921ae68c5ad179de735ff484f1c268"
  end
  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/sageserpent-open/kineticMerge/releases/download/v1.22.0/kinetic-merge-tool-1.22.0-osx-aarch_64.zip"
    sha256 "43756d5009b2617ae8e986d7881b1d03fb50fc74c0a32c7e4c7b162feef6bef4"
  end
  if OS.mac? && Hardware::CPU.intel?
    url "https://github.com/sageserpent-open/kineticMerge/releases/download/v1.22.0/kinetic-merge-tool-1.22.0-osx-x86_64.zip"
    sha256 "9cbdd50a969bdf956758068b0cc70b22e03c4fddc89a930148bd8822a97d6f13"
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
    assert_match "1.22.0", output
  end
end
