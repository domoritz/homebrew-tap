class Csv2parquet < Formula
  desc "Convert CSV files to Parquet"
  version "0.18.0"
  on_macos do
    on_arm do
      url "https://github.com/domoritz/arrow-tools/releases/download/v0.18.0/csv2parquet-aarch64-apple-darwin.tar.xz"
      sha256 "071ab6750bf433fb9024c302ab6c707c7fdde5063c554f61c32eb309ef055775"
    end
    on_intel do
      url "https://github.com/domoritz/arrow-tools/releases/download/v0.18.0/csv2parquet-x86_64-apple-darwin.tar.xz"
      sha256 "55b5c35711717924d3c1eee63586888d5eef81e0e1265791dc4ca8e3b094f3f1"
    end
  end
  on_linux do
    on_intel do
      url "https://github.com/domoritz/arrow-tools/releases/download/v0.18.0/csv2parquet-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "f05c5da8ea16dd38ba1f75269b193dfcdacbd57902cde3bc582bd6f65f619fb4"
    end
  end
  license "MIT/Apache-2.0"

  def install
    on_macos do
      on_arm do
        bin.install "csv2parquet"
      end
    end
    on_macos do
      on_intel do
        bin.install "csv2parquet"
      end
    end
    on_linux do
      on_intel do
        bin.install "csv2parquet"
      end
    end

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install *leftover_contents unless leftover_contents.empty?
  end
end
