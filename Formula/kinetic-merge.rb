# Generated with JReleaser 1.26.0 at 2026-10-28T15:13:10.250526193Z

class KineticMerge < Formula
  desc "Merge a heavily refactored codebase and stay sane."
  homepage "https://github.com/sageserpent-open/kineticMerge"
  version "1.22.2"
  license "MIT"

  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/sageserpent-open/kineticMerge/releases/download/v1.22.2/kinetic-merge-1.22.2-linux-x86_64.zip"
    sha256 "fd0da76324c4db85d167ed919053d7cd29f7cc443d8766823cd358a8b20c4d1c"
  end
  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/sageserpent-open/kineticMerge/releases/download/v1.22.2/kinetic-merge-1.22.2-osx-aarch_64.zip"
    sha256 "bfc02f1ee7c43f21c0cf2cba26a88ef33f4dc106920935ac7c241f360b76d335"
  end
  if OS.mac? && Hardware::CPU.intel?
    url "https://github.com/sageserpent-open/kineticMerge/releases/download/v1.22.2/kinetic-merge-1.22.2-osx-x86_64.zip"
    sha256 "d397f190e693dd24c3b4895b25be19147dde5a79365c5414548165ceb3dd534c"
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
    assert_match "1.22.2", output
  end
end
