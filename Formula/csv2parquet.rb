class Csv2parquet < Formula
  desc "Convert CSV files to Parquet"
  homepage "https://github.com/domoritz/arrow-tools"
  version "0.18.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/domoritz/arrow-tools/releases/download/v0.18.1/csv2parquet-aarch64-apple-darwin.tar.xz"
      sha256 "cb101b8d159ee213105a638c6c94604aa9d6d419206130555f508a828addea16"
    end
    if Hardware::CPU.intel?
      url "https://github.com/domoritz/arrow-tools/releases/download/v0.18.1/csv2parquet-x86_64-apple-darwin.tar.xz"
      sha256 "731314752844c0aafc59e876727e1b7abb1f7fc67364d92afd3edbb4f2467b42"
    end
  end
  if OS.linux?
    if Hardware::CPU.intel?
      url "https://github.com/domoritz/arrow-tools/releases/download/v0.18.1/csv2parquet-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "3a8a32ec75ad1226c017ef8dfdf12cc19c4d8ef0070ebdcf54758f6451760c4a"
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
      bin.install "csv2parquet"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "csv2parquet"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "csv2parquet"
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
