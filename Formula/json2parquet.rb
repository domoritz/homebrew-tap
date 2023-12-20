class Json2parquet < Formula
  desc "Convert JSON files to Parquet"
  version "0.17.8"
  on_macos do
    on_arm do
      url "https://github.com/domoritz/arrow-tools/releases/download/v0.17.8/json2parquet-aarch64-apple-darwin.tar.xz"
      sha256 "9bddbfa278fbd76b03979166796b206170be2f12ce3d22648e9429c511352f66"
    end
    on_intel do
      url "https://github.com/domoritz/arrow-tools/releases/download/v0.17.8/json2parquet-x86_64-apple-darwin.tar.xz"
      sha256 "001bc5e13e9a4929a22aa6b270bcc056f306507f31fbede26b2b86010257e7b7"
    end
  end
  on_linux do
    on_intel do
      url "https://github.com/domoritz/arrow-tools/releases/download/v0.17.8/json2parquet-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "1a59e63e474c97a2155665b953c6139367ba3db29be8821f3ca992069edf543f"
    end
  end
  license "MIT/Apache-2.0"

  def install
    bin.install "json2parquet"

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install *leftover_contents unless leftover_contents.empty?
  end
end
