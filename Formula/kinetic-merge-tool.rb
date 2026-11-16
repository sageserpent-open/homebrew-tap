# Generated with JReleaser 1.27.0 at 2026-11-16T15:30:16.625999128Z

class KineticMergeTool < Formula
  desc "Merge a heavily refactored codebase and stay sane."
  homepage "https://github.com/sageserpent-open/kineticMerge"
  version "1.25.3"
  license "MIT"

  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/sageserpent-open/kineticMerge/releases/download/v1.25.3/kinetic-merge-tool-1.25.3-linux-x86_64.zip"
    sha256 "2085517b0645d8e9303150108247ab1e43cf906b6a7bf185cb89ce04eb7fe57b"
  end
  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/sageserpent-open/kineticMerge/releases/download/v1.25.3/kinetic-merge-tool-1.25.3-osx-aarch_64.zip"
    sha256 "f6a51a1bca20f906693df89591f0309e8d971a33bdf15c349c30748eceeb5e52"
  end
  if OS.mac? && Hardware::CPU.intel?
    url "https://github.com/sageserpent-open/kineticMerge/releases/download/v1.25.3/kinetic-merge-tool-1.25.3-osx-x86_64.zip"
    sha256 "169d64e72dfadc96dfea75f27758f81b4df276cfdba1c6c7717d0137ac1a8e02"
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
    assert_match "1.25.3", output
  end
end
