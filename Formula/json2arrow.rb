class Json2arrow < Formula
  desc "Convert JSON files to Arrow"
  homepage "https://github.com/domoritz/arrow-tools/tree/main/crates/json2arrow"
  version "0.22.3"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/domoritz/arrow-tools/releases/download/v0.22.3/json2arrow-aarch64-apple-darwin.tar.xz"
      sha256 "d6675ca59bf8cdded0e75b0526265c8bb11ed6246842871dc4657f076c039146"
    end
    if Hardware::CPU.intel?
      url "https://github.com/domoritz/arrow-tools/releases/download/v0.22.3/json2arrow-x86_64-apple-darwin.tar.xz"
      sha256 "9ef66281b69d118590cde7378f8ba1d23fc31713e5697cc89d8f604bb80a2dde"
    end
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/domoritz/arrow-tools/releases/download/v0.22.3/json2arrow-x86_64-unknown-linux-gnu.tar.xz"
    sha256 "a2f35ea4026dc446f6b65eb2868e1af7fb4d7bb7d879976f3ad3c53c3617a33f"
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
