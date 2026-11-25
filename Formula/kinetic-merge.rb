# Generated with JReleaser 1.27.0 at 2026-11-25T14:42:24.30214092Z

class KineticMerge < Formula
  desc "Merge a heavily refactored codebase and stay sane."
  homepage "https://github.com/sageserpent-open/kineticMerge"
  version "1.25.4"
  license "MIT"

  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/sageserpent-open/kineticMerge/releases/download/v1.25.4/kinetic-merge-1.25.4-linux-x86_64.zip"
    sha256 "ae48788192173355256502593aae83d19affcc78a986ca4cc2c7ab4b83a8780f"
  end
  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/sageserpent-open/kineticMerge/releases/download/v1.25.4/kinetic-merge-1.25.4-osx-aarch_64.zip"
    sha256 "e62f956dbcc3b16e314f6d0fa934a07a70b21d6a2abad1759fb041b482d971ba"
  end
  if OS.mac? && Hardware::CPU.intel?
    url "https://github.com/sageserpent-open/kineticMerge/releases/download/v1.25.4/kinetic-merge-1.25.4-osx-x86_64.zip"
    sha256 "c35c44008201b353ba79bcada6f90ab1686b95324f7a3565ce440bbd39819fe2"
  end


  def install
    libexec.install Dir["*"]
    bin.install_symlink "#{libexec}/bin/kinetic-merge" => "kinetic-merge"
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
    output = shell_output("#{bin}/kinetic-merge --version")
    assert_match "1.25.4", output
  end
end
