#
# Notes: armadillo doesn't yet work because it requires gcc, so
# in order to make it work one has to install hdf5 and boost
# with gcc as well.
#
class O2scl < Formula
  homepage "http://web.utk.edu/~asteine1/o2scl"
  stable do
    url "https://github.com/awsteiner/o2scl/releases/download/v0.918/o2scl-0.918.tar.gz"
    sha256 "d5c3bafd57dca10ee9b7c8a60708ac0537dfe31eef4e88eafeacfd62b3ee674c"
  end
  devel do
    head "http://github.com/awsteiner/o2scl.git"
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
  depends_on "autoconf" => :optional
  depends_on "automake" => :optional
  depends_on "libtool" => :optional

  if build.with? "armadillo"
    depends_on "armadillo"
  end
  if build.with? "eigen"
    depends_on "eigen"
  end
  if build.devel?
    depends_on "autoconf"
    depends_on "automake"
    depends_on "libtool"
  end

  # The main installation script
  #
  # The Eigen formula installs in eigen3/Eigen instead of just Eigen.
  # The current fix for this is to install o2scl into eigen3 also, so
  # that o2scl can find the Eigen directory. This should be improved
  # in the future.
  def install
    # If we're installing from the repo, then use GNU autotools to make
    # the ./configure script
    if build.devel?
      system "mkdir", "m4"
      system "autoreconf", "-i"
      system "autoconf"
      system "automake", "-a", "--gnu"
    end
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
    #
    # If there's no documentation, just add some blank files so
    # that the install target succeeds
    #
    if build.devel?
      system "make", "blank-doc"
    end
    system "make"
    system "make", "install"
    #
    # Fixme: should document why this is necessary
    #
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
