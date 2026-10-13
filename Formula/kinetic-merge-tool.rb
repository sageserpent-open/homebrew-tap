# Generated with JReleaser 1.26.0 at 2026-10-13T06:59:38.649405995Z

class KineticMergeTool < Formula
  desc "Merge a heavily refactored codebase and stay sane."
  homepage "https://github.com/sageserpent-open/kineticMerge"
  url "https://github.com/sageserpent-open/kineticMerge/releases/download/v1.21.6/tool-cli-application-1.21.6.zip"
  version "1.21.6"
  sha256 "12e098f968e23952d3358e2a34a3b83ccbda70fd569c456712c36905f521a5c4"
  license "MIT"

  depends_on "openjdk@"

  def install
    libexec.install Dir["*"]
    bin.install_symlink "#{libexec}/bin/kinetic-merge-tool" => "kinetic-merge-tool"
  end

  test do
    output = shell_output("#{bin}/kinetic-merge-tool --version")
    assert_match "1.21.6", output
  end
end
