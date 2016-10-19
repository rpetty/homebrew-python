class Scapy < Formula
  desc "Powerful interactive packet manipulation program"
  homepage "http://www.secdev.org/projects/scapy/"
  url "https://github.com/secdev/scapy/archive/v2.3.3.tar.gz"
  sha256 "67642cf7b806e02daeddd588577588caebddc3426db7904e7999a0b0334a63b5"
  head "https://github.com/secdev/scapy.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "873448d2a2b0bffc266193ba39eeb3ae57639f7ac8cef4b1829941eca4ea7821" => :sierra
    sha256 "cdb6108de0ddddea60b87ac8f5a3a41533fa4bd7843398093c493b4e8699fb68" => :el_capitan
    sha256 "d78cf3c59fb17fbb6140943a508a07de57371d8eaf35e0795dca7035c89e07e5" => :yosemite
  end

  depends_on :python
  depends_on "libdnet"

  resource "pylibpcap" do
    url "https://downloads.sourceforge.net/project/pylibpcap/pylibpcap/0.6.4/pylibpcap-0.6.4.tar.gz"
    sha256 "cfc365f2707a7986496acacf71789fef932a5ddbeaa36274cc8f9834831ca3b1"
  end

  def install
    vendor_path = libexec/"vendor/lib/python2.7/site-packages"
    ENV.prepend_create_path "PYTHONPATH", vendor_path
    resource("pylibpcap").stage do
      system "python", *Language::Python.setup_install_args(libexec/"vendor")
    end
    (lib/"python2.7/site-packages/homebrew-scapy-pylibpcap.pth").write "#{vendor_path}\n"
    system "python", *Language::Python.setup_install_args(prefix)
  end

  test do
    command = "rdpcap('#{test_fixtures("test.pcap")}')"
    assert_match "TCP", pipe_output(bin/"scapy", command)
  end
end
