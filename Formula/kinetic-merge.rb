# Generated with JReleaser 1.26.0 at 2026-10-18T17:27:29.627338492Z

class KineticMerge < Formula
  desc "Merge a heavily refactored codebase and stay sane."
  homepage "https://github.com/sageserpent-open/kineticMerge"
  version "1.22.2"
  license "MIT"

  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/sageserpent-open/kineticMerge/releases/download/v1.22.2/kinetic-merge-1.22.2-linux-x86_64.zip"
    sha256 "63ae850887d657f654bde9bd50a22f3c1762d35b40f31e87d0466227e833225c"
  end
  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/sageserpent-open/kineticMerge/releases/download/v1.22.2/kinetic-merge-1.22.2-osx-aarch_64.zip"
    sha256 "9477d0975f3f640907b547161739982bae79292bc516bf58cc1c3541e6121d53"
  end
  if OS.mac? && Hardware::CPU.intel?
    url "https://github.com/sageserpent-open/kineticMerge/releases/download/v1.22.2/kinetic-merge-1.22.2-osx-x86_64.zip"
    sha256 "7503de1cd9ac4eb73a6e4080ea43e8a28e9e164381cea924e3ba86e942999cd2"
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
