class Json2arrow < Formula
  desc "Convert JSON files to Arrow"
  version "0.17.8"
  on_macos do
    on_arm do
      url "https://github.com/domoritz/arrow-tools/releases/download/v0.17.8/json2arrow-aarch64-apple-darwin.tar.xz"
      sha256 "0e1268799bf29f0658706af84ae24adc0ff7cbfdaf967b8b267e677c15a73f23"
    end
    on_intel do
      url "https://github.com/domoritz/arrow-tools/releases/download/v0.17.8/json2arrow-x86_64-apple-darwin.tar.xz"
      sha256 "d531a6fe5615c904ee52e4d89c88f7075637cb4de44c8881393ded9e4c9d1d9c"
    end
  end
  on_linux do
    on_intel do
      url "https://github.com/domoritz/arrow-tools/releases/download/v0.17.8/json2arrow-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "10edab672778cf580b65d719e71fd4eb60dc81a20f7fc8fe8679b906f626e79b"
    end
  end
  license "MIT/Apache-2.0"

  def install
    bin.install "json2arrow"

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install *leftover_contents unless leftover_contents.empty?
  end
end
