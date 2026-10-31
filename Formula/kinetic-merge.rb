# Generated with JReleaser 1.27.0 at 2026-10-31T17:23:57.488177057Z

class KineticMerge < Formula
  desc "Merge a heavily refactored codebase and stay sane."
  homepage "https://github.com/sageserpent-open/kineticMerge"
  version "1.24.1"
  license "MIT"

  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/sageserpent-open/kineticMerge/releases/download/v1.24.1/kinetic-merge-1.24.1-linux-x86_64.zip"
    sha256 "10f0623a12cd29b49e59a73b2170f7144d2b10d99c60e862f3baccb6767a2d17"
  end
  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/sageserpent-open/kineticMerge/releases/download/v1.24.1/kinetic-merge-1.24.1-osx-aarch_64.zip"
    sha256 "3e8c7f858dde27c2a7413907cd88a0d35b4c13d2eeb3d2df9179594e892695d8"
  end
  if OS.mac? && Hardware::CPU.intel?
    url "https://github.com/sageserpent-open/kineticMerge/releases/download/v1.24.1/kinetic-merge-1.24.1-osx-x86_64.zip"
    sha256 "91d5017336508ce8bb0f966c7381c27e5a8854dc4b5c80dc2a5e52f38c50bac2"
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
    assert_match "1.24.1", output
  end
end
