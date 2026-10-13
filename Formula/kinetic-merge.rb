# Generated with JReleaser 1.26.0 at 2026-10-13T09:31:33.396452496Z

class KineticMerge < Formula
  desc "Merge a heavily refactored codebase and stay sane."
  homepage "https://github.com/sageserpent-open/kineticMerge"
  url "https://github.com/sageserpent-open/kineticMerge/releases/download/v1.21.6/git-cli-application-1.21.6.zip"
  version "1.21.6"
  sha256 "1d6da695eebb0457b0d7451fa7b742b7378b1ff0930ba17db965235e84800116"
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
