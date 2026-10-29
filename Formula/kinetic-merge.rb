# Generated with JReleaser 1.26.0 at 2026-10-29T15:46:22.171598886Z

class KineticMerge < Formula
  desc "Merge a heavily refactored codebase and stay sane."
  homepage "https://github.com/sageserpent-open/kineticMerge"
  version "1.24.0"
  license "MIT"

  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/sageserpent-open/kineticMerge/releases/download/v1.24.0/kinetic-merge-1.24.0-linux-x86_64.zip"
    sha256 "949e35f8cc566ba6eb9126657b09ea78fb4822e67cf07dc3872349e11cf62b50"
  end
  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/sageserpent-open/kineticMerge/releases/download/v1.24.0/kinetic-merge-1.24.0-osx-aarch_64.zip"
    sha256 "c1182368c1859213b7fd61c9b7f28f9d2a947af2baff62c8bc22b2def82fe6fc"
  end
  if OS.mac? && Hardware::CPU.intel?
    url "https://github.com/sageserpent-open/kineticMerge/releases/download/v1.24.0/kinetic-merge-1.24.0-osx-x86_64.zip"
    sha256 "5a844d0b380b660c1b1fe23c7bf1e805f3f3e714cd48c7e09872f422552a9332"
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
    assert_match "1.24.0", output
  end
end
