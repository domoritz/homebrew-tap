class Csv2arrow < Formula
  desc "Convert CSV files to Arrow"
  homepage "https://github.com/domoritz/arrow-tools/tree/main/crates/csv2arrow"
  version "0.20.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/domoritz/arrow-tools/releases/download/v0.20.0/csv2arrow-aarch64-apple-darwin.tar.xz"
      sha256 "9c37b4a5d8364f9899f7d69dc030da3348ce801e5283114bb6900bf6930b9abf"
    end
    if Hardware::CPU.intel?
      url "https://github.com/domoritz/arrow-tools/releases/download/v0.20.0/csv2arrow-x86_64-apple-darwin.tar.xz"
      sha256 "74da1c2db8bca5fa6d8d15f4c120e43c46de11ee83787bc6fe3d17c04a9f5501"
    end
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/domoritz/arrow-tools/releases/download/v0.20.0/csv2arrow-x86_64-unknown-linux-gnu.tar.xz"
    sha256 "45caf00f0c5d1ad4fbae9d7cadaff2dd095b9a0cc34e0f669847cec77a60549f"
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
