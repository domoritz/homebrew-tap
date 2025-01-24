class Csv2arrow < Formula
  desc "Convert CSV files to Arrow"
  homepage "https://github.com/domoritz/arrow-tools/tree/main/crates/csv2arrow"
  version "0.21.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/domoritz/arrow-tools/releases/download/v0.21.1/csv2arrow-aarch64-apple-darwin.tar.xz"
      sha256 "caf7bab47e8bb6e768734a4326af950520b7d2a0b36ce30282495153401f9865"
    end
    if Hardware::CPU.intel?
      url "https://github.com/domoritz/arrow-tools/releases/download/v0.21.1/csv2arrow-x86_64-apple-darwin.tar.xz"
      sha256 "093d2f16c3306ee0edb661542ca27f540d742a0a75e363ede01b7e83f2bbedea"
    end
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/domoritz/arrow-tools/releases/download/v0.21.1/csv2arrow-x86_64-unknown-linux-gnu.tar.xz"
    sha256 "cbf23583d21a6108572ecafe1925b6a8b5d944a4a982781e198122bc56d25b26"
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
