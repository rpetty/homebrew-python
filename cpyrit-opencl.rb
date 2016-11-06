class CpyritOpencl < Formula
  desc "GPU-accelerated attack against WPA-PSK auth"
  homepage "https://github.com/JPaulMora/Pyrit"
  url "https://github.com/JPaulMora/Pyrit/archive/v0.5.0.tar.gz"
  sha256 "c610b7e5930e71ef466365418e58ce72f4b7dea5a3398c3296192f0c4a7175aa"

  bottle do
    cellar :any
    sha256 "164cafe644cb692ee40c60fa0c753c272dde808a674ecafcf05869a9058e33d5" => :sierra
    sha256 "a18be7044c7228e3b8dd43bfbd1bd80f6ee64fbbf5e1a85d1f777075409eb15a" => :yosemite
    sha256 "e77974aa1fc02c0dc3396935ec4706e22f355fd238af6c190779327851132886" => :mavericks
    sha256 "63505ec80d2ec87a287e50c6c48756732a4b2999b052c4d85057135bfbbec016" => :mountain_lion
  end

  depends_on "libdnet"
  depends_on "pyrit"
  depends_on "scapy"

  def install
    system "python", *Language::Python.setup_install_args(prefix)
  end

  test do
    interactive_shell
    system "python", "-c", "import cpyrit._cpyrit_opencl"
  end
end

