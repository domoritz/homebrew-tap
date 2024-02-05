class Json2arrow < Formula
  desc "Convert JSON files to Arrow"
  version "0.17.9"
  on_macos do
    on_arm do
      url "https://github.com/domoritz/arrow-tools/releases/download/v0.17.9/json2arrow-aarch64-apple-darwin.tar.xz"
      sha256 "8c942d550a7a902da4e38f57d70066911d9fe431496b5dd1b1dc4cbf588bedd1"
    end
    on_intel do
      url "https://github.com/domoritz/arrow-tools/releases/download/v0.17.9/json2arrow-x86_64-apple-darwin.tar.xz"
      sha256 "b61341512e8ddafe42f5b664444981e842df862d5e4e7f88d4fe4e2fab70c97f"
    end
  end
  on_linux do
    on_intel do
      url "https://github.com/domoritz/arrow-tools/releases/download/v0.17.9/json2arrow-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "4b11aa795fd84ebba8519499ea1a4aaec08e14cae49e4d8ac51eb7245adabbb1"
    end
  end
  license "MIT/Apache-2.0"

  def install
    on_macos do
      on_arm do
        bin.install "json2arrow"
      end
    end
    on_macos do
      on_intel do
        bin.install "json2arrow"
      end
    end
    on_linux do
      on_intel do
        bin.install "json2arrow"
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
