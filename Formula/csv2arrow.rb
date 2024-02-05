class Csv2arrow < Formula
  desc "Convert CSV files to Arrow"
  version "0.17.9"
  on_macos do
    on_arm do
      url "https://github.com/domoritz/arrow-tools/releases/download/v0.17.9/csv2arrow-aarch64-apple-darwin.tar.xz"
      sha256 "32df43da1dc97b715849d2284f3ceb60d06e62c559e740894fbe145ecedaafbe"
    end
    on_intel do
      url "https://github.com/domoritz/arrow-tools/releases/download/v0.17.9/csv2arrow-x86_64-apple-darwin.tar.xz"
      sha256 "2ab891ad958659073ae28f242ac14774d7ff4969becb0ffec172a31de1fae4a2"
    end
  end
  on_linux do
    on_intel do
      url "https://github.com/domoritz/arrow-tools/releases/download/v0.17.9/csv2arrow-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "03554f1b4b7cb93c3017218e53aeb88b020691c40e6f71983064d13b62ebce95"
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
