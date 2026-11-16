# Generated with JReleaser 1.27.0 at 2026-11-16T15:30:16.625999128Z

class KineticMerge < Formula
  desc "Merge a heavily refactored codebase and stay sane."
  homepage "https://github.com/sageserpent-open/kineticMerge"
  version "1.25.3"
  license "MIT"

  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/sageserpent-open/kineticMerge/releases/download/v1.25.3/kinetic-merge-1.25.3-linux-x86_64.zip"
    sha256 "9b04fdc67ae0a7f9632fd67b5d7c36a7cd2ce7c60376bd0b32e1defbd4438639"
  end
  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/sageserpent-open/kineticMerge/releases/download/v1.25.3/kinetic-merge-1.25.3-osx-aarch_64.zip"
    sha256 "60a77a2b15f0df1dda8dd8b0e6fd0892a3abc3a00c17a9ea5e0faba8281e52ed"
  end
  if OS.mac? && Hardware::CPU.intel?
    url "https://github.com/sageserpent-open/kineticMerge/releases/download/v1.25.3/kinetic-merge-1.25.3-osx-x86_64.zip"
    sha256 "0010ff0a80f03a63784e93d04fbde3261b4141ffa25dd561b6246539fe1517c4"
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
    assert_match "1.25.3", output
  end
end
