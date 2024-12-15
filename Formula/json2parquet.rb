class Json2parquet < Formula
  desc "Convert JSON files to Parquet"
  homepage "https://github.com/domoritz/arrow-tools/tree/main/crates/json2parquet"
  version "0.20.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/domoritz/arrow-tools/releases/download/v0.20.0/json2parquet-aarch64-apple-darwin.tar.xz"
      sha256 "0be62f9d43221f726b7b8c1e859e22153d492d647520dd91e3967b3b635be93c"
    end
    if Hardware::CPU.intel?
      url "https://github.com/domoritz/arrow-tools/releases/download/v0.20.0/json2parquet-x86_64-apple-darwin.tar.xz"
      sha256 "7182142f70a8c2d42e36e55fadec46577eafc66cae71331ec3262e9a0c085578"
    end
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/domoritz/arrow-tools/releases/download/v0.20.0/json2parquet-x86_64-unknown-linux-gnu.tar.xz"
    sha256 "395e4b7ac7cef49a020c861fcafb6014147f5c53b8b8708296337b2466d54e1c"
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
