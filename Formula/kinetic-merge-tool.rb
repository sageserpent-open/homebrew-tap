# Generated with JReleaser 1.27.0 at 2026-11-25T14:42:24.30214092Z

class KineticMergeTool < Formula
  desc "Merge a heavily refactored codebase and stay sane."
  homepage "https://github.com/sageserpent-open/kineticMerge"
  version "1.25.4"
  license "MIT"

  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/sageserpent-open/kineticMerge/releases/download/v1.25.4/kinetic-merge-tool-1.25.4-linux-x86_64.zip"
    sha256 "46c1da5a5774ec35894234f3f71cc251250f2ec7cbf017250396213adf7d835e"
  end
  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/sageserpent-open/kineticMerge/releases/download/v1.25.4/kinetic-merge-tool-1.25.4-osx-aarch_64.zip"
    sha256 "51c9ddc2b7d2fce86ede076dc8619242fbc0cf14741ac44ce9f4fa0c126221eb"
  end
  if OS.mac? && Hardware::CPU.intel?
    url "https://github.com/sageserpent-open/kineticMerge/releases/download/v1.25.4/kinetic-merge-tool-1.25.4-osx-x86_64.zip"
    sha256 "259733b447c26721d86b23173998567c332ab4bd98c462b7dd52500de8192674"
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
    assert_match "1.25.4", output
  end
end
