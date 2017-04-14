#
# Todos:
#
class Btmanip < Formula
  desc "BibTeX File Manipulation Utility"
  homepage "http://web.utk.edu/~asteine1/btmanip"
  head "https://github.com/awsteiner/btmanip.git"

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
