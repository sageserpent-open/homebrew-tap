# Generated with JReleaser 1.27.0 at 2026-11-08T18:18:15.036193037Z

class KineticMerge < Formula
  desc "Merge a heavily refactored codebase and stay sane."
  homepage "https://github.com/sageserpent-open/kineticMerge"
  version "1.25.0"
  license "MIT"

  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/sageserpent-open/kineticMerge/releases/download/v1.25.0/kinetic-merge-1.25.0-linux-x86_64.zip"
    sha256 "99d6d9edf494c1a93d310ad34f4c39494f2f02b3455e6eb7e701de78d30e48fb"
  end
  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/sageserpent-open/kineticMerge/releases/download/v1.25.0/kinetic-merge-1.25.0-osx-aarch_64.zip"
    sha256 "410903b7217e8c3b37eff7f42536593e23ee73dd2b161188c775b2b4a2d7b60f"
  end
  if OS.mac? && Hardware::CPU.intel?
    url "https://github.com/sageserpent-open/kineticMerge/releases/download/v1.25.0/kinetic-merge-1.25.0-osx-x86_64.zip"
    sha256 "611b3085cc50e113e17734a441a4896aa9fcaf8b699cb49cfb99a73e3ea0a8b2"
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
    assert_match "1.25.0", output
  end
end
