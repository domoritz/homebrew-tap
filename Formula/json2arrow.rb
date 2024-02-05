class Json2arrow < Formula
  desc "Convert JSON files to Arrow"
  version "0.17.10"
  on_macos do
    on_arm do
      url "https://github.com/domoritz/arrow-tools/releases/download/v0.17.10/json2arrow-aarch64-apple-darwin.tar.xz"
      sha256 "116643a187911797954a9e3bdf63b50517e992ebf4eb30efb5c623778ff37f3e"
    end
    on_intel do
      url "https://github.com/domoritz/arrow-tools/releases/download/v0.17.10/json2arrow-x86_64-apple-darwin.tar.xz"
      sha256 "32626bf4d9ec356ffeb2aa595dfcc7d9d16dd05a88a95b35532645347a63278e"
    end
  end
  on_linux do
    on_intel do
      url "https://github.com/domoritz/arrow-tools/releases/download/v0.17.10/json2arrow-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "ff8cfbe1f6a5e02850603b2baf74da64740affe752906033050bbcd17587cea5"
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
