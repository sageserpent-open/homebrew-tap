# Generated with JReleaser 1.26.0 at 2026-10-28T14:38:30.793774218Z

class KineticMerge < Formula
  desc "Merge a heavily refactored codebase and stay sane."
  homepage "https://github.com/sageserpent-open/kineticMerge"
  version "1.22.2"
  license "MIT"

  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/sageserpent-open/kineticMerge/releases/download/v1.22.2/kinetic-merge-1.22.2-linux-x86_64.zip"
    sha256 "3c50208950c22b858d93b706297437f904a5bfb8dd86ebe091fb497fe506b120"
  end
  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/sageserpent-open/kineticMerge/releases/download/v1.22.2/kinetic-merge-1.22.2-osx-aarch_64.zip"
    sha256 "5da0c206bacb5ddc0a60b6618341cb1e81e8089aac5f82d16f1bd41ff51335b8"
  end
  if OS.mac? && Hardware::CPU.intel?
    url "https://github.com/sageserpent-open/kineticMerge/releases/download/v1.22.2/kinetic-merge-1.22.2-osx-x86_64.zip"
    sha256 "f9abb413538d432691afcb1cfb58c1370473f8dc97f730cd43122f2cf2c2f36b"
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
    assert_match "1.22.2", output
  end
end
