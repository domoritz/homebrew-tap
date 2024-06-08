class Json2parquet < Formula
  desc "Convert JSON files to Parquet"
  homepage "https://github.com/domoritz/arrow-tools"
  version "0.18.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/domoritz/arrow-tools/releases/download/v0.18.1/json2parquet-aarch64-apple-darwin.tar.xz"
      sha256 "c57c4aacd085e056f71695a1f7b43b405b06628247a5384b0a48745a848e4129"
    end
    if Hardware::CPU.intel?
      url "https://github.com/domoritz/arrow-tools/releases/download/v0.18.1/json2parquet-x86_64-apple-darwin.tar.xz"
      sha256 "93874a64d65b55251cd8bb54ad22762263bccff220b105e869e29f7c7d956ffc"
    end
  end
  if OS.linux?
    if Hardware::CPU.intel?
      url "https://github.com/domoritz/arrow-tools/releases/download/v0.18.1/json2parquet-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "66e7d2ff436236c8ef260674c1a42a898c55137d6aba8bedb56b7bb3d4bd8061"
    end
  end
  license "MIT/Apache-2.0"

  BINARY_ALIASES = {"aarch64-apple-darwin": {}, "x86_64-apple-darwin": {}, "x86_64-pc-windows-gnu": {}, "x86_64-unknown-linux-gnu": {}, "x86_64-unknown-linux-musl-dynamic": {}, "x86_64-unknown-linux-musl-static": {}}

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
    if OS.mac? && Hardware::CPU.arm?
      bin.install "json2parquet"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "json2parquet"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "json2parquet"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
