class Csv2parquet < Formula
  desc "Convert CSV files to Parquet"
  homepage "https://github.com/domoritz/arrow-tools/tree/main/crates/csv2parquet"
  version "0.22.3"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/domoritz/arrow-tools/releases/download/v0.22.3/csv2parquet-aarch64-apple-darwin.tar.xz"
      sha256 "8fd762121a9ac3f89a54300fcf40418a34b4d7e6b3270e39a3fb683aa88f1bbe"
    end
    if Hardware::CPU.intel?
      url "https://github.com/domoritz/arrow-tools/releases/download/v0.22.3/csv2parquet-x86_64-apple-darwin.tar.xz"
      sha256 "17d9d8b857c2e56f9a38120fe275456d275ab4024f9deb466288d585c2cc144d"
    end
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/domoritz/arrow-tools/releases/download/v0.22.3/csv2parquet-x86_64-unknown-linux-gnu.tar.xz"
    sha256 "7c6ca0a178f494070baa066e800979c07dfd47c845127a3fc2bc72346d8c6f42"
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
    bin.install "csv2parquet" if OS.mac? && Hardware::CPU.arm?
    bin.install "csv2parquet" if OS.mac? && Hardware::CPU.intel?
    bin.install "csv2parquet" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
