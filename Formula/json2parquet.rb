class Json2parquet < Formula
  desc "Convert JSON files to Parquet"
  version "0.17.9"
  on_macos do
    on_arm do
      url "https://github.com/domoritz/arrow-tools/releases/download/v0.17.9/json2parquet-aarch64-apple-darwin.tar.xz"
      sha256 "2fad61db76209832d24dd2d1bb9f7cecdc1ae1d196036bfd7ab56899fcadfdc5"
    end
    on_intel do
      url "https://github.com/domoritz/arrow-tools/releases/download/v0.17.9/json2parquet-x86_64-apple-darwin.tar.xz"
      sha256 "8a2453ff9580746b5b67e4a28092860bea7bd6dfc161779a2862db981d7adf08"
    end
  end
  on_linux do
    on_intel do
      url "https://github.com/domoritz/arrow-tools/releases/download/v0.17.9/json2parquet-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "b288f1aae8a32435e801c11542198fb411abe4c299235ecd6e469d041f3754c9"
    end
  end
  license "MIT/Apache-2.0"

  def install
    on_macos do
      on_arm do
        bin.install "json2parquet"
      end
    end
    on_macos do
      on_intel do
        bin.install "json2parquet"
      end
    end
    on_linux do
      on_intel do
        bin.install "json2parquet"
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
