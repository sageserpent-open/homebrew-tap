# Generated with JReleaser 1.27.0 at 2026-11-10T07:57:44.213448647Z

class KineticMerge < Formula
  desc "Merge a heavily refactored codebase and stay sane."
  homepage "https://github.com/sageserpent-open/kineticMerge"
  version "1.25.1"
  license "MIT"

  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/sageserpent-open/kineticMerge/releases/download/v1.25.1/kinetic-merge-1.25.1-linux-x86_64.zip"
    sha256 "99db470b50c7222002de2756706f124b88bdae747c55b353becf6bface794941"
  end
  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/sageserpent-open/kineticMerge/releases/download/v1.25.1/kinetic-merge-1.25.1-osx-aarch_64.zip"
    sha256 "177f39dbb3c5e4f77152fa0f74e76d36bd650333574c0ad6a9882b8c558b0854"
  end
  if OS.mac? && Hardware::CPU.intel?
    url "https://github.com/sageserpent-open/kineticMerge/releases/download/v1.25.1/kinetic-merge-1.25.1-osx-x86_64.zip"
    sha256 "148626cc040c8376ca37eb7a4270ef6127c3deffc57f58b0ddbb1468ee27ae4f"
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
    assert_match "1.25.1", output
  end
end
