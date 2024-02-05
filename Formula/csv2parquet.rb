class Csv2parquet < Formula
  desc "Convert CSV files to Parquet"
  version "0.17.9"
  on_macos do
    on_arm do
      url "https://github.com/domoritz/arrow-tools/releases/download/v0.17.9/csv2parquet-aarch64-apple-darwin.tar.xz"
      sha256 "848de0f17b5824c1bbc2ff3f9beef436e3a47e98e07898feafc12e1c250056b7"
    end
    on_intel do
      url "https://github.com/domoritz/arrow-tools/releases/download/v0.17.9/csv2parquet-x86_64-apple-darwin.tar.xz"
      sha256 "5baeff5006735ebf53bcedb2b99e5b2a9ad410662a18635fd3346fcf9701a41a"
    end
  end
  on_linux do
    on_intel do
      url "https://github.com/domoritz/arrow-tools/releases/download/v0.17.9/csv2parquet-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "1eb85d555b2f3e4cdad0e87c5947dc9acc6f3169325a2b59b5e27ef0782296b6"
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
