# Generated with JReleaser 1.26.0 at 2026-10-13T06:59:38.649405995Z

class KineticMerge < Formula
  desc "Merge a heavily refactored codebase and stay sane."
  homepage "https://github.com/sageserpent-open/kineticMerge"
  url "https://github.com/sageserpent-open/kineticMerge/releases/download/v1.21.6/git-cli-application-1.21.6.zip"
  version "1.21.6"
  sha256 "2b31a3fa8e8a7d7cd7770e41ce51b5f043c6b03684248541f56231569c869c93"
  license "MIT"

  depends_on "openjdk@"

  def install
    libexec.install Dir["*"]
    bin.install_symlink "#{libexec}/bin/kinetic-merge" => "kinetic-merge"
  end

  test do
    output = shell_output("#{bin}/kinetic-merge --version")
    assert_match "1.21.6", output
  end
end
