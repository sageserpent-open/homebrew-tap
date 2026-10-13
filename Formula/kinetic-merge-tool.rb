# Generated with JReleaser 1.26.0 at 2026-10-13T09:39:18.332513849Z

class KineticMergeTool < Formula
  desc "Merge a heavily refactored codebase and stay sane."
  homepage "https://github.com/sageserpent-open/kineticMerge"
  url "https://github.com/sageserpent-open/kineticMerge/releases/download/v1.21.6/tool-cli-application-1.21.6.zip"
  version "1.21.6"
  sha256 "696d6cf3b0d1f3f12c29d4c427e9daec15edf33ff4bbd7fdcf2fb0b2f81aa30a"
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
