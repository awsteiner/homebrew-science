
class O2scl < Formula
  homepage "http://o2scl.sourceforge.net"
  url "http://23.115.64.197/o2scl-0.918.tar.gz"
  sha256 "2b5ee94f937472a1a99103f6319f3bebb9f9e0f9118d2870e5f8177ac999586a"

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
    system "make", "o2scl-test" if build.with? "check"
    system "make", "o2scl-examples" if build.with? "check"
    # Would be nice to save the output for o2scl-test and
    # o2scl-examples somewhere where the user can see it?
  end

  test do
    system "acol --version"
  end
end
