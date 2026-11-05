# Generated with JReleaser 1.27.0 at 2026-11-05T17:53:12.731906037Z

class KineticMerge < Formula
  desc "Merge a heavily refactored codebase and stay sane."
  homepage "https://github.com/sageserpent-open/kineticMerge"
  version "1.24.2"
  license "MIT"

  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/sageserpent-open/kineticMerge/releases/download/v1.24.2/kinetic-merge-1.24.2-linux-x86_64.zip"
    sha256 "8e81cf1e9abaea5832b7c18ded292992e5633d808f4b9ad1166b9be0c17c930f"
  end
  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/sageserpent-open/kineticMerge/releases/download/v1.24.2/kinetic-merge-1.24.2-osx-aarch_64.zip"
    sha256 "201e383a13c29084fe44bc73a7351a6171b27c9b773df7e9800efd513db9cf7f"
  end
  if OS.mac? && Hardware::CPU.intel?
    url "https://github.com/sageserpent-open/kineticMerge/releases/download/v1.24.2/kinetic-merge-1.24.2-osx-x86_64.zip"
    sha256 "31074982d5d51b421919fa52c07daa6a796fdc98854f0d491b27f13063ed7c3a"
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
    assert_match "1.24.2", output
  end
end
