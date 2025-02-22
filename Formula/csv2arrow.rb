class Csv2arrow < Formula
  desc "Convert CSV files to Arrow"
  homepage "https://github.com/domoritz/arrow-tools/tree/main/crates/csv2arrow"
  version "0.22.3"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/domoritz/arrow-tools/releases/download/v0.22.3/csv2arrow-aarch64-apple-darwin.tar.xz"
      sha256 "c7cc79b85c63b5256f8c4b138d62c69e99e5c2163a70f399131d8bdccb135ad3"
    end
    if Hardware::CPU.intel?
      url "https://github.com/domoritz/arrow-tools/releases/download/v0.22.3/csv2arrow-x86_64-apple-darwin.tar.xz"
      sha256 "0da00ffe1739b7a72a13e84aad09ccfdefa066c8cab9c1d7cd83844a0047561f"
    end
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/domoritz/arrow-tools/releases/download/v0.22.3/csv2arrow-x86_64-unknown-linux-gnu.tar.xz"
    sha256 "8e8746e1e3c140b8c47a5af3ad13b7780fdb7085face8b28f5864123c4157949"
  end
  license "MIT/Apache-2.0"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":              {},
    "x86_64-apple-darwin":               {},
    "x86_64-pc-windows-gnu":             {},
    "x86_64-unknown-linux-gnu":          {},
    "x86_64-unknown-linux-musl-dynamic": {},
    "x86_64-unknown-linux-musl-static":  {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    bin.install "csv2arrow" if OS.mac? && Hardware::CPU.arm?
    bin.install "csv2arrow" if OS.mac? && Hardware::CPU.intel?
    bin.install "csv2arrow" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
