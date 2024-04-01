class Json2arrow < Formula
  desc "Convert JSON files to Arrow"
  version "0.18.0"
  on_macos do
    on_arm do
      url "https://github.com/domoritz/arrow-tools/releases/download/v0.18.0/json2arrow-aarch64-apple-darwin.tar.xz"
      sha256 "95b3cb76b7083c2a4a3930946abb0102d6a2f7098a4b96e511567bd880551f1e"
    end
    on_intel do
      url "https://github.com/domoritz/arrow-tools/releases/download/v0.18.0/json2arrow-x86_64-apple-darwin.tar.xz"
      sha256 "16a062a1341dfba2fa2eb6e9aa9b6890495516eec10834238a0df71631d6a786"
    end
  end
  on_linux do
    on_intel do
      url "https://github.com/domoritz/arrow-tools/releases/download/v0.18.0/json2arrow-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "81daccdcf336ae6530ecc0059d0a533188295b57a4eb1b807ae668ac44ba5f0a"
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
