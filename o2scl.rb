
class O2scl < Formula
  homepage "http://o2scl.sourceforge.net"
  url "http://web.utk.edu/~asteine1/o2scl-0.918.tar.gz"
  sha256 "22c25d02779df3f8831230c61040e2ba635762795adb2941cd5d5ffe103e1e5b"

  option "with-check", "Run build-time tests"
  option "with-examples", "Run build-time examples"
  option "with-armadillo", "Include armadillo support"
  option "with-eigen", "Include eigen support"

  depends_on "gsl"
  depends_on "hdf5"
  depends_on "boost"
  depends_on "readline"
  if build.with? "armadillo"
    depends_on "armadillo"
  end
  if build.with? "eigen"
    depends_on "eigen"
  end

  def install
    if build.with? "armadillo"
      if build.with? "eigen"
        system "./configure", "--disable-dependency-tracking",
               "--enable-armadillo","--enable-eigen",
               "--includedir=/usr/local/include/eigen3",
               "--disable-silent-rules",
               "--prefix=#{prefix}"
      else
        system "./configure", "--disable-dependency-tracking",
               "--enable-armadillo",
               "--disable-silent-rules",
               "--prefix=#{prefix}"
      end
    else
      if build.with? "eigen"
        system "./configure", "--disable-dependency-tracking",
               "--enable-eigen",
               "--disable-silent-rules",
               "--includedir=/usr/local/include/eigen3",
               "--prefix=#{prefix}"
      else
        system "./configure", "--disable-dependency-tracking",
               "--disable-silent-rules",
               "--prefix=#{prefix}"
      end
    end
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
