# Generated with JReleaser 1.26.0 at 2026-10-15T15:07:53.419410715Z

class KineticMerge < Formula
  desc "Merge a heavily refactored codebase and stay sane."
  homepage "https://github.com/sageserpent-open/kineticMerge"
  version "1.21.6"
  license "MIT"

  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/sageserpent-open/kineticMerge/releases/download/v1.21.6/kinetic-merge-1.21.6-linux-x86_64.zip"
    sha256 "570a9416e9d40841a921b6cb4ba6743230655ec72fec4b61f488cf61468d77f8"
  end
  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/sageserpent-open/kineticMerge/releases/download/v1.21.6/kinetic-merge-1.21.6-osx-aarch_64.zip"
    sha256 "b5e5f42c305f8f437dab07c994cb8737045acf1c10fd37550902bdc42aca2f6f"
  end
  if OS.mac? && Hardware::CPU.intel?
    url "https://github.com/sageserpent-open/kineticMerge/releases/download/v1.21.6/kinetic-merge-1.21.6-osx-x86_64.zip"
    sha256 "e87ce524df63e0461bd3b2a634c1e6dfc29977e44416ce760722e6d77f1ef164"
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
    assert_match "1.21.6", output
  end
end
