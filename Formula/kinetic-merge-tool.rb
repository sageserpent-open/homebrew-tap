# Generated with JReleaser 1.26.0 at 2026-10-13T11:35:59.963821057Z

class KineticMergeTool < Formula
  desc "Merge a heavily refactored codebase and stay sane."
  homepage "https://github.com/sageserpent-open/kineticMerge"
  url "https://github.com/sageserpent-open/kineticMerge/releases/download/v1.21.6/tool-cli-application-1.21.6.zip"
  version "1.21.6"
  sha256 "b60527afa5212ec9df3a2d677493ee8a71aa12f8e74a4eaf02db70a251ff0a96"
  license "MIT"

  depends_on "openjdk@17"

  def install
    libexec.install Dir["*"]
    bin.install_symlink "#{libexec}/bin/kinetic-merge-tool" => "kinetic-merge-tool"
  end

  test do
    output = shell_output("#{bin}/kinetic-merge-tool --version")
    assert_match "1.21.6", output
  end
end
