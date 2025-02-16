class Json2parquet < Formula
  desc "Convert JSON files to Parquet"
  homepage "https://github.com/domoritz/arrow-tools/tree/main/crates/json2parquet"
  version "0.22.3"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/domoritz/arrow-tools/releases/download/v0.22.3/json2parquet-aarch64-apple-darwin.tar.xz"
      sha256 "961b3d944d8a8612d179a4c8657e17027200298d20f8514dca361ce22d9c59f2"
    end
    if Hardware::CPU.intel?
      url "https://github.com/domoritz/arrow-tools/releases/download/v0.22.3/json2parquet-x86_64-apple-darwin.tar.xz"
      sha256 "1abe3ccde9f20ecea75fb539f2cb2fd8598f0809441bfc93eccfca98082f5122"
    end
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/domoritz/arrow-tools/releases/download/v0.22.3/json2parquet-x86_64-unknown-linux-gnu.tar.xz"
    sha256 "568d99601127a08b920a79a304fe9b1d4296351f59cf02527a10ae96151a0f08"
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
    bin.install "json2parquet" if OS.mac? && Hardware::CPU.arm?
    bin.install "json2parquet" if OS.mac? && Hardware::CPU.intel?
    bin.install "json2parquet" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
