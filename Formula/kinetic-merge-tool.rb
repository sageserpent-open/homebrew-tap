# Generated with JReleaser 1.26.0 at 2026-10-28T14:38:30.793774218Z

class KineticMergeTool < Formula
  desc "Merge a heavily refactored codebase and stay sane."
  homepage "https://github.com/sageserpent-open/kineticMerge"
  version "1.22.2"
  license "MIT"

  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/sageserpent-open/kineticMerge/releases/download/v1.22.2/kinetic-merge-tool-1.22.2-linux-x86_64.zip"
    sha256 "6d2fd3d628c98a1773e565acd661fc6ca30aa52386824e2136d1b45c909857e3"
  end
  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/sageserpent-open/kineticMerge/releases/download/v1.22.2/kinetic-merge-tool-1.22.2-osx-aarch_64.zip"
    sha256 "5c33bf8cb8741966e70f318d9ba5431a529a1e234ab6d044f518b40aac9811f1"
  end
  if OS.mac? && Hardware::CPU.intel?
    url "https://github.com/sageserpent-open/kineticMerge/releases/download/v1.22.2/kinetic-merge-tool-1.22.2-osx-x86_64.zip"
    sha256 "a93625c9dc529ec06f172ec74b4094cbcde240acc5553de3de00f92840ff2f9d"
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
    assert_match "1.22.2", output
  end
end
