class Json2arrow < Formula
  desc "Convert JSON files to Arrow"
  homepage "https://github.com/domoritz/arrow-tools"
  version "0.18.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/domoritz/arrow-tools/releases/download/v0.18.1/json2arrow-aarch64-apple-darwin.tar.xz"
      sha256 "0cc003f138bd2c351c9da9b11f6100f9f9887fcef4e269d6cd54930616f6de18"
    end
    if Hardware::CPU.intel?
      url "https://github.com/domoritz/arrow-tools/releases/download/v0.18.1/json2arrow-x86_64-apple-darwin.tar.xz"
      sha256 "665c9334f698e16d4b8b1d0da85e731fb67133d3ff965f7a60af78389bdfc086"
    end
  end
  if OS.linux?
    if Hardware::CPU.intel?
      url "https://github.com/domoritz/arrow-tools/releases/download/v0.18.1/json2arrow-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "4410161497ebc4857c4785f1edfa71bea34b73ba1ba49b08b303394ffaac775e"
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
      bin.install "json2arrow"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "json2arrow"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "json2arrow"
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
