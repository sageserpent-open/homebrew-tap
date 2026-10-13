# Generated with JReleaser 1.26.0 at 2026-10-13T11:35:59.963821057Z

class KineticMerge < Formula
  desc "Merge a heavily refactored codebase and stay sane."
  homepage "https://github.com/sageserpent-open/kineticMerge"
  url "https://github.com/sageserpent-open/kineticMerge/releases/download/v1.21.6/git-cli-application-1.21.6.zip"
  version "1.21.6"
  sha256 "20f561f88a44bc2127284e539acff94434bfde391dc38d593a3973fd14f1baa5"
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
