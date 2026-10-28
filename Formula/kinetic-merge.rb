# Generated with JReleaser 1.26.0 at 2026-10-28T15:35:35.467132495Z

class KineticMerge < Formula
  desc "Merge a heavily refactored codebase and stay sane."
  homepage "https://github.com/sageserpent-open/kineticMerge"
  version "1.22.2"
  license "MIT"

  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/sageserpent-open/kineticMerge/releases/download/v1.22.2/kinetic-merge-1.22.2-linux-x86_64.zip"
    sha256 "a8fa9a8c4cd2023d408026e214014dc61c985162802d3e993e678619967b0e3e"
  end
  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/sageserpent-open/kineticMerge/releases/download/v1.22.2/kinetic-merge-1.22.2-osx-aarch_64.zip"
    sha256 "33cc0355fb33ad7b20c782efb842a20e98ed579a8b56e457edca64e18783f490"
  end
  if OS.mac? && Hardware::CPU.intel?
    url "https://github.com/sageserpent-open/kineticMerge/releases/download/v1.22.2/kinetic-merge-1.22.2-osx-x86_64.zip"
    sha256 "77f2f3c4589f6c2fc3080e83fc49b59716ab195679433e8917f2ca8ea967e287"
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
