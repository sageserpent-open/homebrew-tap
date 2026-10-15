# Generated with JReleaser 1.26.0 at 2026-10-15T14:38:43.821415666Z

class KineticMerge < Formula
  desc "Merge a heavily refactored codebase and stay sane."
  homepage "https://github.com/sageserpent-open/kineticMerge"
  version "1.21.6"
  license "MIT"

  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/sageserpent-open/kineticMerge/releases/download/v1.21.6/kinetic-merge-1.21.6-linux-x86_64.zip"
    sha256 "741af63c8b4e5d66a98bd4b192c40e442dff049251f7e388939e9de2927b8584"
  end
  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/sageserpent-open/kineticMerge/releases/download/v1.21.6/kinetic-merge-1.21.6-osx-aarch_64.zip"
    sha256 "b6049b49056e6de88a2067ad6d1303abc2bbfc2c7733267dbdd82d9feb226437"
  end
  if OS.mac? && Hardware::CPU.intel?
    url "https://github.com/sageserpent-open/kineticMerge/releases/download/v1.21.6/kinetic-merge-1.21.6-osx-x86_64.zip"
    sha256 "0e30eed7089c2e40453cb70b3f57e36fe2c3f0d417c62b956fa6b9b7abe3d38a"
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
