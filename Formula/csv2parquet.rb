class Csv2parquet < Formula
  desc "Convert CSV files to Parquet"
  homepage "https://github.com/domoritz/arrow-tools/tree/main/crates/csv2parquet"
  version "0.21.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/domoritz/arrow-tools/releases/download/v0.21.1/csv2parquet-aarch64-apple-darwin.tar.xz"
      sha256 "27190fa50e49580c30d0c6afb7b21a43e34a8737995e22592b56434ea12e31d9"
    end
    if Hardware::CPU.intel?
      url "https://github.com/domoritz/arrow-tools/releases/download/v0.21.1/csv2parquet-x86_64-apple-darwin.tar.xz"
      sha256 "22d6a430e1d9cea028e2faab5bd02045cb5fa890ad9b4dca27573ef6a3f3f08e"
    end
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/domoritz/arrow-tools/releases/download/v0.21.1/csv2parquet-x86_64-unknown-linux-gnu.tar.xz"
    sha256 "ea3aa39605615cbeb44e43e7855c4ddc60cb4c685c402ae3f415396b50de4a8f"
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
