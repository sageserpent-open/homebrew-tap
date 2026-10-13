# Generated with JReleaser 1.26.0 at 2026-10-13T09:39:18.332513849Z

class KineticMerge < Formula
  desc "Merge a heavily refactored codebase and stay sane."
  homepage "https://github.com/sageserpent-open/kineticMerge"
  url "https://github.com/sageserpent-open/kineticMerge/releases/download/v1.21.6/git-cli-application-1.21.6.zip"
  version "1.21.6"
  sha256 "3881d5dbeb9d3b9bdaa16cf3a406a22a1609acccee52fa2c1d536c7b5e2e7b4d"
  license "MIT"

  depends_on "openjdk@17"

  def install
    libexec.install Dir["*"]
    bin.install_symlink "#{libexec}/bin/kinetic-merge" => "kinetic-merge"
  end

  test do
    output = shell_output("#{bin}/kinetic-merge --version")
    assert_match "1.21.6", output
  end
end
