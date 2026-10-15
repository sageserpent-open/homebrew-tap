# Generated with JReleaser 1.26.0 at 2026-10-15T15:07:53.419410715Z

class KineticMergeTool < Formula
  desc "Merge a heavily refactored codebase and stay sane."
  homepage "https://github.com/sageserpent-open/kineticMerge"
  version "1.21.6"
  license "MIT"

  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/sageserpent-open/kineticMerge/releases/download/v1.21.6/kinetic-merge-tool-1.21.6-linux-x86_64.zip"
    sha256 "38798d4bf782ec394716700db2f45fb1660ba84b73be473f7e00d2007eb0d827"
  end
  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/sageserpent-open/kineticMerge/releases/download/v1.21.6/kinetic-merge-tool-1.21.6-osx-aarch_64.zip"
    sha256 "30e79c0a0d352a30f28b1718460b94b9903d1836f5e7ecbdda03eb45f84fa0c8"
  end
  if OS.mac? && Hardware::CPU.intel?
    url "https://github.com/sageserpent-open/kineticMerge/releases/download/v1.21.6/kinetic-merge-tool-1.21.6-osx-x86_64.zip"
    sha256 "9a246ae919c4d22ad40ede6b1c61ffa9c03b474a1c4a15febc04978498c478ff"
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
