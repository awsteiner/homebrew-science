class O2scl < Formula
  homepage "http://web.utk.edu/~asteine1/o2scl"
  stable do
    url "https://github.com/awsteiner/o2scl/releases/download/v0.918/o2scl-0.918.tar.gz"
    sha256 "d5c3bafd57dca10ee9b7c8a60708ac0537dfe31eef4e88eafeacfd62b3ee674c"
  end
  devel do
    url "http://web.utk.edu/~asteine1/o2scl/o2scl-0.919.tar.gz"
    sha256 "acf5fb5f376e2f834a1cb8566e8da9b9972cc999ce30f59cb8e0dadb0193b076"
  end

  option "with-check", "Run build-time tests"
  option "with-examples", "Run build-time examples"
  option "with-armadillo", "Include armadillo support [not working yet]"
  option "with-eigen", "Include eigen support"
  option "with-no-range-check", "Disable range-checking"

  depends_on "gsl"
  depends_on "hdf5"
  depends_on "boost"
  depends_on "readline"
  depends_on "armadillo" => :optional
  depends_on "eigen" => :optional
  if build.with? "armadillo"
    depends_on "armadillo"
  end
  if build.with? "eigen"
    depends_on "eigen"
  end

  def install
    if build.with? "armadillo"
      if build.with? "eigen"
        if build.with? "no-range-check"
          ENV["CXXFLAGS"] = "-I/usr/local/include/eigen3 -DO2SCL_NO_RANGE_CHECK"
        else
          ENV["CXXFLAGS"] = "-I/usr/local/include/eigen3"
        end
        system "./configure", "--disable-dependency-tracking",
               "--enable-armadillo","--enable-eigen",
               "--disable-silent-rules",
               "--prefix=#{prefix}"
      else
        if build.with? "no-range-check"
          ENV["CXXFLAGS"] = "-DO2SCL_NO_RANGE_CHECK"
        end
        system "./configure", "--disable-dependency-tracking",
               "--enable-armadillo",
               "--disable-silent-rules",
               "--prefix=#{prefix}"
      end
    else
      if build.with? "eigen"
        if build.with? "no-range-check"
          ENV["CXXFLAGS"] = "-I/usr/local/include/eigen3 -DO2SCL_NO_RANGE_CHECK"
        else
          ENV["CXXFLAGS"] = "-I/usr/local/include/eigen3"
        end
        system "./configure", "--disable-dependency-tracking",
               "--enable-eigen",
               "--disable-silent-rules",
               "--includedir=/usr/local/include/eigen3",
               "--prefix=#{prefix}"
      else
        if build.with? "no-range-check"
          ENV["CXXFLAGS"] = "-DO2SCL_NO_RANGE_CHECK"
        end
        system "./configure", "--disable-dependency-tracking",
               "--disable-silent-rules",
               "--prefix=#{prefix}"
      end
    end
    system "make"
    system "make", "install"
    include.install Dir["include/o2scl/*.h"]
    system "make", "check" if build.with? "check"
    system "make", "o2scl-examples" if build.with? "examples"
    # Would be nice to save the output for make check and
    # o2scl-examples somewhere where the user can see it?
    share.install Dir["examples/ex*.cpp"] if build.with? "examples"
  end

  test do
    system "acol --version"
  end
end
