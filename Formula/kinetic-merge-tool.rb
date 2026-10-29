# Generated with JReleaser 1.26.0 at 2026-10-29T15:46:22.171598886Z

class KineticMergeTool < Formula
  desc "Merge a heavily refactored codebase and stay sane."
  homepage "https://github.com/sageserpent-open/kineticMerge"
  version "1.24.0"
  license "MIT"

  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/sageserpent-open/kineticMerge/releases/download/v1.24.0/kinetic-merge-tool-1.24.0-linux-x86_64.zip"
    sha256 "a66e8257eca2d153d02adbc598812e6e03c67dd55e42f8d7a8969dbc1fdd18e9"
  end
  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/sageserpent-open/kineticMerge/releases/download/v1.24.0/kinetic-merge-tool-1.24.0-osx-aarch_64.zip"
    sha256 "03bc9d81a6fa7c3bd896482436d73b0d7f5ef9296fa3708810cf5493af8ec9b8"
  end
  if OS.mac? && Hardware::CPU.intel?
    url "https://github.com/sageserpent-open/kineticMerge/releases/download/v1.24.0/kinetic-merge-tool-1.24.0-osx-x86_64.zip"
    sha256 "8846b049772fd70de206bee4c8dfa065b2f7ab048e9ecfdd303211d0d91d95c5"
  end


  def install
    libexec.install Dir["*"]
    bin.install_symlink "#{libexec}/bin/kinetic-merge-tool" => "kinetic-merge-tool"
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
    output = shell_output("#{bin}/kinetic-merge-tool --version")
    assert_match "1.24.0", output
  end
end
