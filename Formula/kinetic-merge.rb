# Generated with JReleaser 1.26.0 at 2026-10-28T21:11:07.333172465Z

class KineticMerge < Formula
  desc "Merge a heavily refactored codebase and stay sane."
  homepage "https://github.com/sageserpent-open/kineticMerge"
  version "1.23.0"
  license "MIT"

  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/sageserpent-open/kineticMerge/releases/download/v1.23.0/kinetic-merge-1.23.0-linux-x86_64.zip"
    sha256 "0474a612d83a890c2fc02fda2fe84d4bb386ffb1f6d4bfb46b95c6c1fc445d24"
  end
  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/sageserpent-open/kineticMerge/releases/download/v1.23.0/kinetic-merge-1.23.0-osx-aarch_64.zip"
    sha256 "273d8f1418610b1cb9adf98d08535ec16d1122907ce9090702fd17681500af9d"
  end
  if OS.mac? && Hardware::CPU.intel?
    url "https://github.com/sageserpent-open/kineticMerge/releases/download/v1.23.0/kinetic-merge-1.23.0-osx-x86_64.zip"
    sha256 "47d33057ca511728d4d72f8ae3297b0c3e354d24652d7c292a9c5b1fa5fa39bd"
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
    assert_match "1.23.0", output
  end
end
