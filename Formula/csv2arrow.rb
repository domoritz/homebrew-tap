class Csv2arrow < Formula
  desc "Convert CSV files to Arrow"
  version "0.18.0"
  on_macos do
    on_arm do
      url "https://github.com/domoritz/arrow-tools/releases/download/v0.18.0/csv2arrow-aarch64-apple-darwin.tar.xz"
      sha256 "0178f2b9c90299a5b482eb546d6f412fe2ffb223d15113823ad620979d54ae59"
    end
    on_intel do
      url "https://github.com/domoritz/arrow-tools/releases/download/v0.18.0/csv2arrow-x86_64-apple-darwin.tar.xz"
      sha256 "c099cb95e280ac82cf82b465b92d0e47635458783df1aaeb2c6d1656620e00f1"
    end
  end
  on_linux do
    on_intel do
      url "https://github.com/domoritz/arrow-tools/releases/download/v0.18.0/csv2arrow-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "f80e739945554c60b924488d8d82d95aef17fcedc05feda42c9fc819865998a7"
    end
  end
  license "MIT/Apache-2.0"

  def install
    on_macos do
      on_arm do
        bin.install "csv2arrow"
      end
    end
    on_macos do
      on_intel do
        bin.install "csv2arrow"
      end
    end
    on_linux do
      on_intel do
        bin.install "csv2arrow"
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
