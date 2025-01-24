class Json2parquet < Formula
  desc "Convert JSON files to Parquet"
  homepage "https://github.com/domoritz/arrow-tools/tree/main/crates/json2parquet"
  version "0.21.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/domoritz/arrow-tools/releases/download/v0.21.1/json2parquet-aarch64-apple-darwin.tar.xz"
      sha256 "bad6a17eb3af08486f39610a31321a82cd38ebb35791beefb80cba19361b0822"
    end
    if Hardware::CPU.intel?
      url "https://github.com/domoritz/arrow-tools/releases/download/v0.21.1/json2parquet-x86_64-apple-darwin.tar.xz"
      sha256 "9e1e5de1bbd9a3ea586086ecb1188e874344c7626a7e52a3cb043942e30a042f"
    end
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/domoritz/arrow-tools/releases/download/v0.21.1/json2parquet-x86_64-unknown-linux-gnu.tar.xz"
    sha256 "5c6a721d756cee739c7f17716e9b8678d2fb1e3384894dd018255ac7605115b1"
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
