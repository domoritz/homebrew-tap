class Csv2parquet < Formula
  desc "Convert CSV files to Parquet"
  version "0.17.8"
  on_macos do
    on_arm do
      url "https://github.com/domoritz/arrow-tools/releases/download/v0.17.8/csv2parquet-aarch64-apple-darwin.tar.xz"
      sha256 "ef0b858b6febeb78359cfffcc33c21a976c032e5e1a92796c7438a5eae1e1a8d"
    end
    on_intel do
      url "https://github.com/domoritz/arrow-tools/releases/download/v0.17.8/csv2parquet-x86_64-apple-darwin.tar.xz"
      sha256 "cb1ca1213954eefaefb135ba5090bece4c8d73efed0d072ac228b7d05862833b"
    end
  end
  on_linux do
    on_intel do
      url "https://github.com/domoritz/arrow-tools/releases/download/v0.17.8/csv2parquet-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "314e5af2686eead80f036c18ee0b9bbb7f9382d813d806706a54949c0a5d5881"
    end
  end
  license "MIT/Apache-2.0"

  def install
    bin.install "csv2parquet"

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install *leftover_contents unless leftover_contents.empty?
  end
end
