#
# Todos:
#
class O2sclpy < Formula
  desc "Python extensions for O2scl"
  homepage "http://web.utk.edu/~asteine1/o2sclpy"
  head "https://github.com/awsteiner/o2sclpy.git"

  depends_on "o2scl"

  # The main installation script
  #
  def install
    #
    system "pip3", "install", "."
  end

  test do
    system "o2graph", "-h"
  end
end
