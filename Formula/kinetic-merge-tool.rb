# Generated with JReleaser 1.26.0 at 2026-10-28T15:35:35.467132495Z

class KineticMergeTool < Formula
  desc "Merge a heavily refactored codebase and stay sane."
  homepage "https://github.com/sageserpent-open/kineticMerge"
  version "1.22.2"
  license "MIT"

  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/sageserpent-open/kineticMerge/releases/download/v1.22.2/kinetic-merge-tool-1.22.2-linux-x86_64.zip"
    sha256 "e8a7bfda07f30b73d434b581911cd8d10abcdadf3e467ba73e3c5df2a3ecbe18"
  end
  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/sageserpent-open/kineticMerge/releases/download/v1.22.2/kinetic-merge-tool-1.22.2-osx-aarch_64.zip"
    sha256 "c829157f9cac39daa95a99311914d84c592c2d45dc0f591fa0c9ca943694b186"
  end
  if OS.mac? && Hardware::CPU.intel?
    url "https://github.com/sageserpent-open/kineticMerge/releases/download/v1.22.2/kinetic-merge-tool-1.22.2-osx-x86_64.zip"
    sha256 "95e324c1a7300d49f0b84ff2ca4c99ab332fdc28069f2e6190583e026b1de9f0"
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
