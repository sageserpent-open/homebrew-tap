# Generated with JReleaser 1.26.0 at 2026-10-17T14:12:59.303266645Z

class KineticMergeTool < Formula
  desc "Merge a heavily refactored codebase and stay sane."
  homepage "https://github.com/sageserpent-open/kineticMerge"
  version "1.22.1"
  license "MIT"

  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/sageserpent-open/kineticMerge/releases/download/v1.22.1/kinetic-merge-tool-1.22.1-linux-x86_64.zip"
    sha256 "d024174deb081d5d5c2f26d9eb350dc7ae3022ed804cb5c86c741a6066a1ec79"
  end
  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/sageserpent-open/kineticMerge/releases/download/v1.22.1/kinetic-merge-tool-1.22.1-osx-aarch_64.zip"
    sha256 "69140de7a212b737b8147dfc0da37feea50d5dfc806690c9a61029e21a261685"
  end
  if OS.mac? && Hardware::CPU.intel?
    url "https://github.com/sageserpent-open/kineticMerge/releases/download/v1.22.1/kinetic-merge-tool-1.22.1-osx-x86_64.zip"
    sha256 "034e9aa468f3e8f7008f3cfb3f73e64d437ebfa15a8e3338b2dcee36cc35cbeb"
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
    assert_match "1.22.1", output
  end
end
