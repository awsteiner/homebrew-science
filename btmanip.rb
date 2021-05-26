#
# Todos:
#
class Btmanip < Formula
  desc "BibTeX File Manipulation Utility"
  homepage "https://isospin.roam.utk.edu/static/code/btmanip"
  head "https://github.com/awsteiner/btmanip.git", :branch => "main"

  depends_on "o2scl"

  # The main installation script
  #
  def install
    #
    system "make"
    bin.install "btmanip"
  end

  test do
    system "btmanip", "-h"
  end
end
