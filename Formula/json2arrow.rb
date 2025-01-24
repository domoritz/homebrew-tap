class Json2arrow < Formula
  desc "Convert JSON files to Arrow"
  homepage "https://github.com/domoritz/arrow-tools/tree/main/crates/json2arrow"
  version "0.21.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/domoritz/arrow-tools/releases/download/v0.21.1/json2arrow-aarch64-apple-darwin.tar.xz"
      sha256 "02a63615d0452966e25d92f3ddb0a9e593ef1678c82dea201ab8785df7f0c47b"
    end
    if Hardware::CPU.intel?
      url "https://github.com/domoritz/arrow-tools/releases/download/v0.21.1/json2arrow-x86_64-apple-darwin.tar.xz"
      sha256 "c884b39606a29753524c91e4a7ef93a329899ef5bc9b857ed9efed7eda8ab8e0"
    end
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/domoritz/arrow-tools/releases/download/v0.21.1/json2arrow-x86_64-unknown-linux-gnu.tar.xz"
    sha256 "29a61118dc8f5b185dc6724eddf17a47b4569e47c9b0122f8aa292c6597e334b"
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
    bin.install "json2arrow" if OS.mac? && Hardware::CPU.arm?
    bin.install "json2arrow" if OS.mac? && Hardware::CPU.intel?
    bin.install "json2arrow" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
