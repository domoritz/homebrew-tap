class Json2arrow < Formula
  desc "Convert JSON files to Arrow"
  homepage "https://github.com/domoritz/arrow-tools/tree/main/crates/json2arrow"
  version "0.20.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/domoritz/arrow-tools/releases/download/v0.20.0/json2arrow-aarch64-apple-darwin.tar.xz"
      sha256 "3718f0f9060c7dec1a1d313c39e6a41304c9cd4228eb8bb7ef186e2ab32ec941"
    end
    if Hardware::CPU.intel?
      url "https://github.com/domoritz/arrow-tools/releases/download/v0.20.0/json2arrow-x86_64-apple-darwin.tar.xz"
      sha256 "b36774f86d2521333f2f303bedb372b53ec3a655156b2177e5ddf1b32c98a2a4"
    end
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/domoritz/arrow-tools/releases/download/v0.20.0/json2arrow-x86_64-unknown-linux-gnu.tar.xz"
    sha256 "f3cd0a4ef51802d46f876ca432c19a3f0a3fb2415c4c940756f1b2fa6bae6235"
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
