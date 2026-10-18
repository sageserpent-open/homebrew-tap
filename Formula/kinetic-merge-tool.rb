# Generated with JReleaser 1.26.0 at 2026-10-18T17:27:29.627338492Z

class KineticMergeTool < Formula
  desc "Merge a heavily refactored codebase and stay sane."
  homepage "https://github.com/sageserpent-open/kineticMerge"
  version "1.22.2"
  license "MIT"

  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/sageserpent-open/kineticMerge/releases/download/v1.22.2/kinetic-merge-tool-1.22.2-linux-x86_64.zip"
    sha256 "a876bd070958e4ee3571ce54020c1144a8921fe24ce33f78e45ee13e652ceb04"
  end
  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/sageserpent-open/kineticMerge/releases/download/v1.22.2/kinetic-merge-tool-1.22.2-osx-aarch_64.zip"
    sha256 "34c7a3653edf0fd7defd3dc806a8885bf58cbf6d7a4fd42ecb1b60f950148af0"
  end
  if OS.mac? && Hardware::CPU.intel?
    url "https://github.com/sageserpent-open/kineticMerge/releases/download/v1.22.2/kinetic-merge-tool-1.22.2-osx-x86_64.zip"
    sha256 "fa6329edd3308ad283ed5e79386fac460f17e72c6475174a845a84e7de2ce081"
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
