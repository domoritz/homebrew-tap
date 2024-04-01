class Json2parquet < Formula
  desc "Convert JSON files to Parquet"
  version "0.18.0"
  on_macos do
    on_arm do
      url "https://github.com/domoritz/arrow-tools/releases/download/v0.18.0/json2parquet-aarch64-apple-darwin.tar.xz"
      sha256 "04629f70bf3152f760cdc31dbf3e218f14631ce8926de4262fb2936f051d388c"
    end
    on_intel do
      url "https://github.com/domoritz/arrow-tools/releases/download/v0.18.0/json2parquet-x86_64-apple-darwin.tar.xz"
      sha256 "9c28f293ef319a4f59f2568a9f8131c35a40cd30ad144febef79dea27894f97f"
    end
  end
  on_linux do
    on_intel do
      url "https://github.com/domoritz/arrow-tools/releases/download/v0.18.0/json2parquet-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "4a5528c204bd36d117d811c5c354bb385b0e491032807f5d9af6ba3bb841c14f"
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
