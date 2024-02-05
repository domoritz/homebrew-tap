class Json2parquet < Formula
  desc "Convert JSON files to Parquet"
  version "0.17.10"
  on_macos do
    on_arm do
      url "https://github.com/domoritz/arrow-tools/releases/download/v0.17.10/json2parquet-aarch64-apple-darwin.tar.xz"
      sha256 "2e1d2fb073f3ad3e21abf92ffd10c27b04efc75a18422355437699156e7ffa17"
    end
    on_intel do
      url "https://github.com/domoritz/arrow-tools/releases/download/v0.17.10/json2parquet-x86_64-apple-darwin.tar.xz"
      sha256 "49622c47ce59b4559120089562042178a080f1d410de290402e0aa1b6435c3e5"
    end
  end
  on_linux do
    on_intel do
      url "https://github.com/domoritz/arrow-tools/releases/download/v0.17.10/json2parquet-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "3bb751d6aaaa60e263a6f83a8f548d9c61b42a5e5c5c499034257f5e2046fd85"
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
