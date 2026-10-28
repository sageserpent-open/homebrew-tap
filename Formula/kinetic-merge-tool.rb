# Generated with JReleaser 1.26.0 at 2026-10-28T15:13:10.250526193Z

class KineticMergeTool < Formula
  desc "Merge a heavily refactored codebase and stay sane."
  homepage "https://github.com/sageserpent-open/kineticMerge"
  version "1.22.2"
  license "MIT"

  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/sageserpent-open/kineticMerge/releases/download/v1.22.2/kinetic-merge-tool-1.22.2-linux-x86_64.zip"
    sha256 "08ec594994112fcddaa953860db825a1d9151c42ba392a485dcc3095cf6a712c"
  end
  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/sageserpent-open/kineticMerge/releases/download/v1.22.2/kinetic-merge-tool-1.22.2-osx-aarch_64.zip"
    sha256 "4369b332cd2cce3a0309c046bf2c7772c0c1b611988cfe8f8023bdc33ebae959"
  end
  if OS.mac? && Hardware::CPU.intel?
    url "https://github.com/sageserpent-open/kineticMerge/releases/download/v1.22.2/kinetic-merge-tool-1.22.2-osx-x86_64.zip"
    sha256 "ce1f45d8f8e921d26965a8ed4d5fae053cb5e2cb23a988a544f91f70f6d52dfa"
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
