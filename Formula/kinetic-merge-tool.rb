# Generated with JReleaser 1.27.0 at 2026-11-05T17:53:12.731906037Z

class KineticMergeTool < Formula
  desc "Merge a heavily refactored codebase and stay sane."
  homepage "https://github.com/sageserpent-open/kineticMerge"
  version "1.24.2"
  license "MIT"

  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/sageserpent-open/kineticMerge/releases/download/v1.24.2/kinetic-merge-tool-1.24.2-linux-x86_64.zip"
    sha256 "e52e8050961c5f6647b3f867036bde3dd058a912fec33f6bb8ed678bbfa8d31f"
  end
  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/sageserpent-open/kineticMerge/releases/download/v1.24.2/kinetic-merge-tool-1.24.2-osx-aarch_64.zip"
    sha256 "e7056dc436235662723639f79b12d277da2bffb4cc58faa93d2e8a24134dbad8"
  end
  if OS.mac? && Hardware::CPU.intel?
    url "https://github.com/sageserpent-open/kineticMerge/releases/download/v1.24.2/kinetic-merge-tool-1.24.2-osx-x86_64.zip"
    sha256 "b75546426eba1cab4571216a25be74c9ca077c1beae73d234fe50528196be334"
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
    assert_match "1.24.2", output
  end
end
