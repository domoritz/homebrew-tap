class Csv2arrow < Formula
  desc "Convert CSV files to Arrow"
  homepage "https://github.com/domoritz/arrow-tools/tree/main/crates/csv2arrow"
  version "0.19.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/domoritz/arrow-tools/releases/download/v0.19.0/csv2arrow-aarch64-apple-darwin.tar.xz"
      sha256 "4f7a9fb2a2f168cfb44350c7fc8caddd99e45863eb22ea8d1e86ab902f7062ab"
    end
    if Hardware::CPU.intel?
      url "https://github.com/domoritz/arrow-tools/releases/download/v0.19.0/csv2arrow-x86_64-apple-darwin.tar.xz"
      sha256 "9ab03ba61d67655b78281292c4ec335a204e43559b3555f0eb5d59fe5c41aa02"
    end
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/domoritz/arrow-tools/releases/download/v0.19.0/csv2arrow-x86_64-unknown-linux-gnu.tar.xz"
    sha256 "5299ce1a96b2915d7f99c3b97a565b4cf9bb546f8cb8491aeabaa2d5e7df662d"
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
