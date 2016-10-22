class Pyrit < Formula
  desc "Attack against WPA-PSK authentication"
  homepage "https://github.com/JPaulMora/Pyrit"
  url "https://github.com/JPaulMora/Pyrit/archive/v0.5.0.tar.gz"
  sha256 "c610b7e5930e71ef466365418e58ce72f4b7dea5a3398c3296192f0c4a7175aa"

  bottle do
    sha256 "988ba5e46df34c95ebf72294a146338ade7e3972d82ca76f1182f720717bf417" => :yosemite
    sha256 "f56281afb83a401d5af004a5e19dedf5ada98ebfcb08898015f4a941284555e5" => :mavericks
    sha256 "ca269489116ea7b57727d243200b696b0f72780c0836b27fa79b6de0f7e14cd3" => :mountain_lion
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
