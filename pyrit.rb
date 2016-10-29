class Pyrit < Formula
  desc "Attack against WPA-PSK authentication"
  homepage "https://github.com/JPaulMora/Pyrit"
  url "https://github.com/JPaulMora/Pyrit/archive/v0.5.0.tar.gz"
  sha256 "c610b7e5930e71ef466365418e58ce72f4b7dea5a3398c3296192f0c4a7175aa"

  bottle do
    cellar :any
    sha256 "164cafe644cb692ee40c60fa0c753c272dde808a674ecafcf05869a9058e33d5" => :sierra
    sha256 "a7cd2a02fb03bac2d3efde35d2bfdb115158628580e6071414699e8d1506a7eb" => :el_capitan
    sha256 "d896c366eae3e95988385fc8c75f241ba8049666a0a2576a9578ed5a7d609274" => :yosemite
  end

  depends_on "libdnet"
  depends_on "scapy"
  depends_on "openssl"

  def install
    system "python", *Language::Python.setup_install_args(prefix)
  end

  test do
    system "python", "-c", "import pyrit_cli"
  end
end
