class Csv2arrow < Formula
  desc "Convert CSV files to Arrow"
  version "0.17.10"
  on_macos do
    on_arm do
      url "https://github.com/domoritz/arrow-tools/releases/download/v0.17.10/csv2arrow-aarch64-apple-darwin.tar.xz"
      sha256 "643ff1e9a036e102ecbc49d3a403a1c4594ed384d04b77015e6712a3c0937776"
    end
    on_intel do
      url "https://github.com/domoritz/arrow-tools/releases/download/v0.17.10/csv2arrow-x86_64-apple-darwin.tar.xz"
      sha256 "46171965993b8b33ad1aee57a81cf0852b01e4ba648aa7662146fddff15b4428"
    end
  end
  on_linux do
    on_intel do
      url "https://github.com/domoritz/arrow-tools/releases/download/v0.17.10/csv2arrow-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "f77213809ce12f068193a0cf1414f1d38e7c21134c711bff8d5bb5d18c00dc96"
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
