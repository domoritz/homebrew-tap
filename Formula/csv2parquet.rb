class Csv2parquet < Formula
  desc "Convert CSV files to Parquet"
  homepage "https://github.com/domoritz/arrow-tools/tree/main/crates/csv2parquet"
  version "0.20.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/domoritz/arrow-tools/releases/download/v0.20.0/csv2parquet-aarch64-apple-darwin.tar.xz"
      sha256 "dc760f1fbe184de3be9f4bc7a05458834edc472479967f7cc798d54602153eda"
    end
    if Hardware::CPU.intel?
      url "https://github.com/domoritz/arrow-tools/releases/download/v0.20.0/csv2parquet-x86_64-apple-darwin.tar.xz"
      sha256 "65a52ca7d442b891538a429f21c0782462e7ad7e3f6f962398385a33fa2ceacc"
    end
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/domoritz/arrow-tools/releases/download/v0.20.0/csv2parquet-x86_64-unknown-linux-gnu.tar.xz"
    sha256 "0f1be704517e6a6cbbb78ba54abe7fdc2f946327bad6db5ebf92919c43383771"
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
