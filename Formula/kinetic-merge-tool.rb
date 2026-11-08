# Generated with JReleaser 1.27.0 at 2026-11-08T18:18:15.036193037Z

class KineticMergeTool < Formula
  desc "Merge a heavily refactored codebase and stay sane."
  homepage "https://github.com/sageserpent-open/kineticMerge"
  version "1.25.0"
  license "MIT"

  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/sageserpent-open/kineticMerge/releases/download/v1.25.0/kinetic-merge-tool-1.25.0-linux-x86_64.zip"
    sha256 "6c0961d87ab5f2a0c0e2b7234143fd51b2cdca42d549dcb77a0189dc9a01ce27"
  end
  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/sageserpent-open/kineticMerge/releases/download/v1.25.0/kinetic-merge-tool-1.25.0-osx-aarch_64.zip"
    sha256 "e3dc5e0ff87537a11b5734547f8f7c4518a96844cebfa2d72ec73d772b0e8c03"
  end
  if OS.mac? && Hardware::CPU.intel?
    url "https://github.com/sageserpent-open/kineticMerge/releases/download/v1.25.0/kinetic-merge-tool-1.25.0-osx-x86_64.zip"
    sha256 "f5826bed60539ecaee18dc57eeee944ad633286e6db01c1bf5e2c0d0b7d61fce"
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
    assert_match "1.25.0", output
  end
end
