class Csv2parquet < Formula
  desc "Convert CSV files to Parquet"
  version "0.17.10"
  on_macos do
    on_arm do
      url "https://github.com/domoritz/arrow-tools/releases/download/v0.17.10/csv2parquet-aarch64-apple-darwin.tar.xz"
      sha256 "fbae17a2b6ffd02ea7a18401c6ece3b9af983d30e25ec4264363d4bccd8f91a9"
    end
    on_intel do
      url "https://github.com/domoritz/arrow-tools/releases/download/v0.17.10/csv2parquet-x86_64-apple-darwin.tar.xz"
      sha256 "b80148cc5e0f84071a5ba0a95897dd63a14ec43ac1deaec4a056c1c918b0ef4d"
    end
  end
  on_linux do
    on_intel do
      url "https://github.com/domoritz/arrow-tools/releases/download/v0.17.10/csv2parquet-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "90b776e82c0182aefbe9b7186b7f370a2650514f16932efc8262fe2af161a16b"
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
