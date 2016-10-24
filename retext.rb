class Retext < Formula
  include Language::Python::Virtualenv

  desc "Powerful editor for Markdown and reStructuredText"
  homepage "https://github.com/retext-project/retext"
  url "https://files.pythonhosted.org/packages/0e/2b/eb0aafef02337a26b3d497fa1f99f25f1f6039fcd063a4edfe3c174acc7a/ReText-6.0.2.tar.gz"
  sha256 "ce28b20673627bd4e17c750d71b73e073776e291b2a1736dd561a1a24aa7f70b"
  head "https://github.com/retext-project/retext.git"

  bottle do
    sha256 "fa25d5c39111e50f65ab9071c86bf6f36ed4d1b39f4883ed36833d2ad4d09227" => :sierra
    sha256 "0e316206af9ce862b3c851d8af62804c8f829755b78dc091ebb7298641e01c35" => :el_capitan
    sha256 "817c167107ef505c6209dc40bcc0f61ae68c763661ecbabcaaa2245bd300304f" => :yosemite
  end

  depends_on "enchant"
  depends_on :python3
  depends_on "pyqt5"
  depends_on "sip" => "with-python3"

  resource "docutils" do
    url "https://files.pythonhosted.org/packages/37/38/ceda70135b9144d84884ae2fc5886c6baac4edea39550f28bcd144c1234d/docutils-0.12.tar.gz"
    sha256 "c7db717810ab6965f66c8cf0398a98c9d8df982da39b4cd7f162911eb89596fa"
  end

  resource "Markdown" do
    url "https://files.pythonhosted.org/packages/d4/32/642bd580c577af37b00a1eb59b0eaa996f2d11dfe394f3dd0c7a8a2de81a/Markdown-2.6.7.tar.gz"
    sha256 "daebf24846efa7ff269cfde8c41a48bb2303920c7b2c7c5e04fa82e6282d05c0"
  end

  resource "Markups" do
    url "https://files.pythonhosted.org/packages/0b/98/3a20a868437c17db37cec47cc82fbd1030aa55765faf06207ab832e85152/Markups-2.0.0.tar.gz"
    sha256 "5639ddd76d74e0a5335e5b66ff2f1b3f9a9f0ab6eeff76a1003f59ed0ec2b721"
  end

  resource "pyenchant" do
    url "https://files.pythonhosted.org/packages/73/73/49f95fe636ab3deed0ef1e3b9087902413bcdf74ec00298c3059e660cfbb/pyenchant-1.6.8.tar.gz"
    sha256 "7ead2ee74f1a4fc2a7199b3d6012eaaaceea03fbcadcb5df67d2f9d0d51f050a"
  end

  resource "Pygments" do
    url "https://files.pythonhosted.org/packages/b8/67/ab177979be1c81bc99c8d0592ef22d547e70bb4c6815c383286ed5dec504/Pygments-2.1.3.tar.gz"
    sha256 "88e4c8a91b2af5962bfa5ea2447ec6dd357018e86e94c7d14bd8cacbc5b55d81"
  end

  resource "icons" do
    url "https://downloads.sourceforge.net/project/retext/Icons/ReTextIcons_r4.tar.gz"
    sha256 "c0a8c9791d320ef685a9087f230418f3308e6ccbefbf768b827490cde4084fd9"
  end

  def install
    py_version = Language::Python.major_minor_version "python3"
    ENV["PYTHONPATH"] = libexec/"lib/python#{py_version}/site-packages"

    venv = virtualenv_create(libexec, "python3")
    res = %w[Markups Markdown docutils pyenchant]
    venv.pip_install res
    venv.pip_install_and_link buildpath

    retext_dir = libexec/"lib/python#{py_version}/site-packages/ReText/"
    icons_dir = retext_dir/"icons"
    icons_dir.install resource("icons")
    inreplace retext_dir/"__init__.py", "icon_path = 'icons/'",
                                        "icon_path = '#{icons_dir}/'"
  end

  test do
    py_version = Language::Python.major_minor_version "python3"
    ENV["PYTHONPATH"] = libexec/"lib/python#{py_version}/site-packages"
    cmd = "python3 -c 'from ReText import app_version; print(app_version)'"
    if stable?
      assert_equal stable.version.to_s, shell_output(cmd).chomp
    elsif head?
      assert_match "(Git)", shell_output(cmd)
    end
  end
end
