# Generated with JReleaser 1.27.0 at 2026-10-31T17:23:57.488177057Z

class KineticMergeTool < Formula
  desc "Merge a heavily refactored codebase and stay sane."
  homepage "https://github.com/sageserpent-open/kineticMerge"
  version "1.24.1"
  license "MIT"

  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/sageserpent-open/kineticMerge/releases/download/v1.24.1/kinetic-merge-tool-1.24.1-linux-x86_64.zip"
    sha256 "731a41b7e9a39f79c065731e35266767ae0627cdbdf556c3409c7ca28bbce1e5"
  end
  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/sageserpent-open/kineticMerge/releases/download/v1.24.1/kinetic-merge-tool-1.24.1-osx-aarch_64.zip"
    sha256 "6f9e4d1a4e9e6029efcb754eb323581789f76e769f44dc479be2990b2b19d95b"
  end
  if OS.mac? && Hardware::CPU.intel?
    url "https://github.com/sageserpent-open/kineticMerge/releases/download/v1.24.1/kinetic-merge-tool-1.24.1-osx-x86_64.zip"
    sha256 "87c17d0d37c74b74479b9709df53c89986716f0b38d76a28846a25b56d307edf"
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
    assert_match "1.24.1", output
  end
end
