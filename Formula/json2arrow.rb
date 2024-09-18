class Json2arrow < Formula
  desc "Convert JSON files to Arrow"
  homepage "https://github.com/domoritz/arrow-tools/tree/main/crates/json2arrow"
  version "0.19.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/domoritz/arrow-tools/releases/download/v0.19.0/json2arrow-aarch64-apple-darwin.tar.xz"
      sha256 "876bbac47a8ab5d9640b1b4ec7f9a205d73bc29808f6b18ae9539d23d44d086d"
    end
    if Hardware::CPU.intel?
      url "https://github.com/domoritz/arrow-tools/releases/download/v0.19.0/json2arrow-x86_64-apple-darwin.tar.xz"
      sha256 "2bd66a97f577b2a46f92bd89949681b480a3ef16dff7a5aa4021aae042acdea4"
    end
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/domoritz/arrow-tools/releases/download/v0.19.0/json2arrow-x86_64-unknown-linux-gnu.tar.xz"
    sha256 "59799c3aad27394fb3de3cf3c45f914b81675aeb8fb5a01bf6c5cabe37fac798"
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
