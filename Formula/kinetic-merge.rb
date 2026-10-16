# Generated with JReleaser 1.26.0 at 2026-10-16T17:17:09.741523322Z

class KineticMerge < Formula
  desc "Merge a heavily refactored codebase and stay sane."
  homepage "https://github.com/sageserpent-open/kineticMerge"
  version "1.22.0"
  license "MIT"

  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/sageserpent-open/kineticMerge/releases/download/v1.22.0/kinetic-merge-1.22.0-linux-x86_64.zip"
    sha256 "eb07cf165d3a22041a1cb99559307886724d6d2337b27c1447bd0caa70045585"
  end
  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/sageserpent-open/kineticMerge/releases/download/v1.22.0/kinetic-merge-1.22.0-osx-aarch_64.zip"
    sha256 "38e88c413cb4c5f10f48a44b65abe81a10f68f738fe82394cd350e18329c1fba"
  end
  if OS.mac? && Hardware::CPU.intel?
    url "https://github.com/sageserpent-open/kineticMerge/releases/download/v1.22.0/kinetic-merge-1.22.0-osx-x86_64.zip"
    sha256 "90b40c8090f2531abcf8b59722865563e9c169ab521a8fd24fc0a92086a60649"
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
    assert_match "1.22.0", output
  end
end
