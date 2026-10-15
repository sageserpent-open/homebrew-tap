# Generated with JReleaser 1.26.0 at 2026-10-15T15:16:57.758100831Z

class KineticMergeTool < Formula
  desc "Merge a heavily refactored codebase and stay sane."
  homepage "https://github.com/sageserpent-open/kineticMerge"
  version "1.21.6"
  license "MIT"

  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/sageserpent-open/kineticMerge/releases/download/v1.21.6/kinetic-merge-tool-1.21.6-linux-x86_64.zip"
    sha256 "dba6a575882867f5a2ab71ef441c9f60057dfc27228e95a59cf023c556e289fc"
  end
  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/sageserpent-open/kineticMerge/releases/download/v1.21.6/kinetic-merge-tool-1.21.6-osx-aarch_64.zip"
    sha256 "cde643c49fd5953b19e50c60a37767a18d7d7dd805ccade753f9171665495d2f"
  end
  if OS.mac? && Hardware::CPU.intel?
    url "https://github.com/sageserpent-open/kineticMerge/releases/download/v1.21.6/kinetic-merge-tool-1.21.6-osx-x86_64.zip"
    sha256 "efe22e18c5102667422944ddbeae861439e443474c61bf13afc4378eeb790412"
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
    assert_match "1.21.6", output
  end
end
