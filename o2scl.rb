#
# Todos:
#
# - Clean up Eigen integration. See install section below.
#
# - Working with the armadillo library doesn't yet work because it
# requires gcc, so in order to make it work one has to install hdf5
# and boost with gcc as well.
#
# - Create a directory structure for installing the examples?
#
# - Document why include.install Dir["include/o2scl/*.h"] is needed
# below.
#
# - Consider also storing the output of make check and make
# o2scl-examples so the user can see them easily without --verbose?
#
class O2scl < Formula
  desc "Object-oriented Scientific Computing Library"
  homepage "https://isospin.roam.utk.edu/static/o2scl"
  head "https://github.com/awsteiner/o2scl.git"
  stable do
    url "https://github.com/awsteiner/o2scl/releases/download/v0.921/o2scl-0.921.tar.gz"
    sha256 "e807902f90af49dc5640c5f47db1a0a2d7edea34bde2fa6d4b5f7a5c1bcd549c"
  end

  option "with-check", "Run build-time tests"
  option "with-examples", "Run build-time examples"
  option "with-armadillo", "Include armadillo support [not working yet]"
  option "with-eigen", "Include eigen support"
  option "with-openmp", "Include OpenMP support"
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
  if build.head?
    depends_on "autoconf" => :build
    depends_on "automake" => :build
    depends_on "libtool" => :build
  end

  # The main installation script
  #
  def install
    # If we're installing from the repo, then use GNU autotools to make
    # the ./configure script. Note that libtool is often installed with
    # a 'g' prefix by homebrew.
    if build.head?
      mkdir "m4"
      system "autoreconf", "-i"
    end
    # Install considering all of the various options
    if build.with? "armadillo"
      if build.with? "eigen"
        if build.with? "no-range-check"
          ENV["CXXFLAGS"] = "-DO2SCL_NO_RANGE_CHECK"
        end
        if build.with? "openmp"
          system "./configure", "--disable-dependency-tracking",
                 "--enable-armadillo", "--enable-eigen","--enable-gsl2",
                 "--disable-silent-rules","--prefix=#{prefix}"
        else
          system "./configure", "--disable-dependency-tracking",
                 "--enable-armadillo", "--enable-eigen","--enable-gsl2",
                 "--enable-openmp","--disable-silent-rules",
                 "--prefix=#{prefix}"
        end
      else
        if build.with? "no-range-check"
          ENV["CXXFLAGS"] = "-DO2SCL_NO_RANGE_CHECK"
        end
        if build.with? "openmp"
          system "./configure", "--disable-dependency-tracking",
                 "--enable-armadillo","--enable-gsl2",
                 "--enable-openmp","--disable-silent-rules",
                 "--prefix=#{prefix}"
        else
          system "./configure", "--disable-dependency-tracking",
                 "--enable-armadillo","--enable-gsl2",
                 "--disable-silent-rules","--prefix=#{prefix}"
        end
      end
    else
      if build.with? "eigen"
        if build.with? "no-range-check"
          ENV["CXXFLAGS"] = "-DO2SCL_NO_RANGE_CHECK"
        end
        if build.with? "openmp"
          system "./configure", "--disable-dependency-tracking",
                 "--enable-eigen","--enable-gsl2",
                 "--enable-openmp","--disable-silent-rules",
                 "--prefix=#{prefix}"
        else
          system "./configure", "--disable-dependency-tracking",
                 "--enable-eigen","--enable-gsl2",
                 "--disable-silent-rules","--prefix=#{prefix}"
        end
      else
        if build.with? "no-range-check"
          ENV["CXXFLAGS"] = "-DO2SCL_NO_RANGE_CHECK"
        end
        #ENV["LDFLAGS"] = "-L"+buildpath
        if build.with? "openmp"
          system "./configure", "--disable-dependency-tracking",
                 "--disable-silent-rules","--enable-gsl2",
                 "--enable-openmp","--prefix=#{prefix}"
        else
          system "./configure", "--disable-dependency-tracking",
                 "--disable-silent-rules","--enable-gsl2",
                 "--prefix=#{prefix}"
        end
      end
    end
    #
    # If there's no documentation, just add some blank files so
    # that the install target succeeds.
    #
    if build.head?
      system "make", "blank-doc"
    end
    #
    # Unfortunately if we do 'make' and then 'make install', it fails
    # to build acol properly (e.g. on antares), so we just do 'make
    # install'.
    #
    # 2/24/17: Actually this most recent time it worked better
    # with 'make' and 'make install' on antares, so I leave it
    # this way for now. Alternatively, there is an LDFLAGS
    # setting above which I can try if I'm still having problems.
    #
    #
    system "make"
    system "make", "install"
    #
    # FIXME: should document why this is necessary
    #
    include.install Dir["include/o2scl/*.h"]
    system "make", "check" if build.with? "check"
    system "make", "o2scl-examples" if build.with? "examples"
    share.install Dir["examples/ex*.cpp"] if build.with? "examples"
  end

  test do
    system "acol", "--version"
  end
end
