class Pymummer < Formula
  desc "Python3 wrapper for running MUMmer and parsing the output"
  homepage "https://github.com/sanger-pathogens/pymummer"
  url "https://github.com/sanger-pathogens/pymummer/archive/v0.9.0.tar.gz"
  sha256 "e0c8bead3dacd1ecb29cdb1bdd60d7b52f13073dfbb152eefcfe08a147b9b3a1"
  head "https://github.com/sanger-pathogens/pymummer.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "f56b0078fbf1ce577128883d9c61d08261694c4da2f3eb3eca823f1146945bd1" => :sierra
    sha256 "f56b0078fbf1ce577128883d9c61d08261694c4da2f3eb3eca823f1146945bd1" => :el_capitan
    sha256 "f56b0078fbf1ce577128883d9c61d08261694c4da2f3eb3eca823f1146945bd1" => :yosemite
  end

  # tag "bioinformatics"

  depends_on :python3
  depends_on "homebrew/science/mummer"

  resource "pyfastaq" do
    url "https://files.pythonhosted.org/packages/2a/46/6ece19838a79489556c97092e832bafeb46e7b28c52418a6c5a7568da999/pyfastaq-3.13.0.tar.gz"
    sha256 "79bfe342e053d51efbc7a901489c62e996566b4baf0f33cde1caff3a387756af"
  end

  def install
    version = Language::Python.major_minor_version "python3"
    ENV.prepend_create_path "PYTHONPATH", libexec/"vendor/lib/python#{version}/site-packages"

    resource("pyfastaq").stage do
      system "python3", *Language::Python.setup_install_args(libexec/"vendor")
      pyfastaq_path = libexec/"vendor/lib/python#{version}/site-packages"
      dest_path = lib/"python#{version}/site-packages"
      mkdir_p dest_path
      (dest_path/"homebrew-pymummer-pyfastaq.pth").write "#{pyfastaq_path}\n"
    end

    ENV.prepend_create_path "PYTHONPATH", prefix/"lib/python#{version}/site-packages"
    system "python3", *Language::Python.setup_install_args(prefix)
  end

  test do
    system "python3", "-c", "from pymummer import coords_file, alignment, nucmer; nucmer.Runner('ref', 'qry', 'outfile')"
  end
end
