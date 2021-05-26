#
# Todos:
#
class O2sclpy < Formula
  desc "Python extensions for O2scl"
  homepage "http://isospin.roam.utk.edu/static/code/o2sclpy"
  head "https://github.com/awsteiner/o2sclpy.git", :branch => "main"
  stable do
    url "https://files.pythonhosted.org/packages/38/86/554aafc9f3458a51da91c054e3036630608a64805eb414f618dafd4760c9/o2sclpy-0.921.tar.gz"
    sha256 "bd44df9d29f547a882445ae88bdc286f6f5e375146d311e4e814304a634a68fa"
  end

  depends_on "o2scl"

  # The main installation script
  #
  def install
    virtualenv_install_with_resources
    #system "pip3", "install", "."
  end

  #test do
    #system "o2graph", "-h"
  #end
end
