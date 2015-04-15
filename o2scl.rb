
class O2scl < Formula
  homepage "http://o2scl.sourceforge.net"
  url "http://web.utk.edu/~asteine1/o2scl-0.918.tar.gz"
  sha256 "ef4f7caf448478e2ae33714b36f12a10cd11b2ce54ae8a6f4197135954920630"

  option "with-check", "Run build-time tests"
  option "with-examples", "Run build-time examples"

  depends_on "gsl"
  depends_on "hdf5"
  depends_on "boost"
  depends_on "readline"

  def install
    system "./configure", "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}"
    system "make"
    system "make", "install"
    system "make", "check" if build.with? "check"
    system "make", "o2scl-examples" if build.with? "check"
    # Would be nice to save the output for make check and
    # o2scl-examples somewhere where the user can see it?
  end

  test do
    system "acol --version"
  end
end
