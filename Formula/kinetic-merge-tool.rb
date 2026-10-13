# Generated with JReleaser 1.26.0 at 2026-10-13T09:31:33.396452496Z

class KineticMergeTool < Formula
  desc "Merge a heavily refactored codebase and stay sane."
  homepage "https://github.com/sageserpent-open/kineticMerge"
  url "https://github.com/sageserpent-open/kineticMerge/releases/download/v1.21.6/tool-cli-application-1.21.6.zip"
  version "1.21.6"
  sha256 "ba1d635b85fe7df21be0f3dc5123e0cac929a9f70d589739ffbbefb782e3abb8"
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
