# Generated with JReleaser 1.26.0 at 2026-10-15T15:16:57.758100831Z

class KineticMerge < Formula
  desc "Merge a heavily refactored codebase and stay sane."
  homepage "https://github.com/sageserpent-open/kineticMerge"
  version "1.21.6"
  license "MIT"

  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/sageserpent-open/kineticMerge/releases/download/v1.21.6/kinetic-merge-1.21.6-linux-x86_64.zip"
    sha256 "2a18dc2eebc2fe6436f395a8e73ed21bbed5487e4eb58b3f9c161b2db24195e4"
  end
  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/sageserpent-open/kineticMerge/releases/download/v1.21.6/kinetic-merge-1.21.6-osx-aarch_64.zip"
    sha256 "11314526f6f44ef63caf3c8656326986033a89e942a98d84479e2a5a5b684481"
  end
  if OS.mac? && Hardware::CPU.intel?
    url "https://github.com/sageserpent-open/kineticMerge/releases/download/v1.21.6/kinetic-merge-1.21.6-osx-x86_64.zip"
    sha256 "e9459bf3ffb31487e602de43f9e9e48bdf7333ee846646d194d6f1d7b389612b"
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
