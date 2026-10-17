# Generated with JReleaser 1.26.0 at 2026-10-17T14:12:59.303266645Z

class KineticMerge < Formula
  desc "Merge a heavily refactored codebase and stay sane."
  homepage "https://github.com/sageserpent-open/kineticMerge"
  version "1.22.1"
  license "MIT"

  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/sageserpent-open/kineticMerge/releases/download/v1.22.1/kinetic-merge-1.22.1-linux-x86_64.zip"
    sha256 "901b7a15f07844cd8230983104c09cd41cfd04f320f19353a7ef60d8acc523c1"
  end
  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/sageserpent-open/kineticMerge/releases/download/v1.22.1/kinetic-merge-1.22.1-osx-aarch_64.zip"
    sha256 "f24b98cae8060d9bda44b4f473ce0ab5ead607978110550b193e9c7759778f37"
  end
  if OS.mac? && Hardware::CPU.intel?
    url "https://github.com/sageserpent-open/kineticMerge/releases/download/v1.22.1/kinetic-merge-1.22.1-osx-x86_64.zip"
    sha256 "cb45ecf5b8e0ae87771096af3b2eeced900f072632482f72d91d2ac75c92cc15"
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
    assert_match "1.22.1", output
  end
end
