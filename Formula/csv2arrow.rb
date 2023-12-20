class Csv2arrow < Formula
  desc "Convert CSV files to Arrow"
  version "0.17.8"
  on_macos do
    on_arm do
      url "https://github.com/domoritz/arrow-tools/releases/download/v0.17.8/csv2arrow-aarch64-apple-darwin.tar.xz"
      sha256 "bc6562a55283b950985b13e00209f820e3c2d3549bd839cc9e4847efd9256a54"
    end
    on_intel do
      url "https://github.com/domoritz/arrow-tools/releases/download/v0.17.8/csv2arrow-x86_64-apple-darwin.tar.xz"
      sha256 "d80ef41428cec27e078e17c85681e371e18b2299b35b35599fb0762dc7bfe257"
    end
  end
  on_linux do
    on_intel do
      url "https://github.com/domoritz/arrow-tools/releases/download/v0.17.8/csv2arrow-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "873a03f55dd7afac0ff317e0350ab77c07927339ef34edae68e630a319318146"
    end
  end
  license "MIT/Apache-2.0"

  def install
    bin.install "csv2arrow"

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install *leftover_contents unless leftover_contents.empty?
  end
end
