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
  homepage "https://neutronstars.utk.edu/code/o2scl"
  head "https://github.com/awsteiner/o2scl.git", :branch => "main"
  stable do
    url "https://github.com/awsteiner/o2scl/releases/download/v0.927/o2scl-0.927.tar.gz"
    sha256 "9bdbea171c1924c1ae7e0d3dc1f80683ac2c4081eec102a884d453494c9635ad"
  end
  license "GPL-3.0-or-later"

  option "with-check", "Run build-time tests"
  option "with-examples", "Run build-time examples"
  option "with-armadillo", "Include armadillo support [not working yet]"
  option "with-eigen", "Include eigen support"
  option "with-openmp", "Include OpenMP support"
  option "with-no-range-check", "Disable range-checking"
  option "with-fast-test", "Skip some tests to run faster"
  option "with-python", "Include Python support"

  depends_on "gsl"
  depends_on "hdf5"
  depends_on "boost"
  depends_on "readline"
  depends_on "armadillo" => :optional
  depends_on "eigen" => :optional
  depends_on "python@3.11" => :optional
  
  # 9/23/2020: I've been having trouble with builds failing because
  # they can't find autoreconf, and this seems to fix it for now, even
  # though these packages really aren't required if you're building
  # from a release. 
  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build

  if build.with? "armadillo"
    depends_on "armadillo"
  end
  if build.with? "eigen"
    depends_on "eigen"
  end
  
#  if build.head?
#    depends_on "autoconf" => :build
#    depends_on "automake" => :build
#    depends_on "libtool" => :build
#  end

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
          if build.with? "fast-test"
            if build.with? "python"
              ENV["CXXFLAGS"] = "-DO2SCL_NO_RANGE_CHECK -DO2SCL_FAST_TEST -I/usr/local/lib/python3.11/site-packages/numpy/core/include -I/usr/local/opt/python@3.11/Frameworks/Python.framework/Versions/3.11/include/python3.11 -I/usr/local/opt/python@3.11/Frameworks/Python.framework/Versions/3.11/include/python3.11"
              system "echo", "e1"
            else
              ENV["CXXFLAGS"] = "-DO2SCL_NO_RANGE_CHECK -DO2SCL_FAST_TEST"
              system "echo", "e2"
            end
          else
            if build.with? "python"
              ENV["CXXFLAGS"] = "-DO2SCL_NO_RANGE_CHECK -I/usr/local/lib/python3.11/site-packages/numpy/core/include -I/usr/local/opt/python@3.11/Frameworks/Python.framework/Versions/3.11/include/python3.11 -I/usr/local/opt/python@3.11/Frameworks/Python.framework/Versions/3.11/include/python3.11"
              system "echo", "e3"
            else
              ENV["CXXFLAGS"] = "-DO2SCL_NO_RANGE_CHECK"
              system "echo", "e4"
            end
          end
        end
        if build.with? "openmp"
          if build.with? "python"
            system "./configure", "--disable-dependency-tracking",
                   "--enable-armadillo", "--enable-eigen","--enable-gsl2",
                   "--enable-python",
                   "--disable-silent-rules","--prefix=#{prefix}"
          else
            system "./configure", "--disable-dependency-tracking",
                   "--enable-armadillo", "--enable-eigen","--enable-gsl2",
                   "--disable-silent-rules","--prefix=#{prefix}"
          end
        else
          if build.with? "python"
            system "./configure", "--disable-dependency-tracking",
                   "--enable-armadillo", "--enable-eigen","--enable-gsl2",
                   "--enable-python",
                   "--enable-openmp","--disable-silent-rules",
                   "--prefix=#{prefix}"
          else
            system "./configure", "--disable-dependency-tracking",
                   "--enable-armadillo", "--enable-eigen","--enable-gsl2",
                   "--enable-openmp","--disable-silent-rules",
                   "--prefix=#{prefix}"
          end
        end
      else
        if build.with? "fast-test"
          if build.with? "python"
            ENV["CXXFLAGS"] = "-DO2SCL_NO_RANGE_CHECK -DO2SCL_FAST_TEST -I/usr/local/lib/python3.11/site-packages/numpy/core/include -I/usr/local/opt/python@3.11/Frameworks/Python.framework/Versions/3.11/include/python3.11 -I/usr/local/opt/python@3.11/Frameworks/Python.framework/Versions/3.11/include/python3.11"
            system "echo", "e5"
          else
            ENV["CXXFLAGS"] = "-DO2SCL_NO_RANGE_CHECK -DO2SCL_FAST_TEST"
            system "echo", "e6"
          end
        else
          if build.with? "python"
            ENV["CXXFLAGS"] = "-DO2SCL_NO_RANGE_CHECK -I/usr/local/lib/python3.11/site-packages/numpy/core/include -I/usr/local/opt/python@3.11/Frameworks/Python.framework/Versions/3.11/include/python3.11 -I/usr/local/opt/python@3.11/Frameworks/Python.framework/Versions/3.11/include/python3.11"
            system "echo", "e7"
          else
            ENV["CXXFLAGS"] = "-DO2SCL_NO_RANGE_CHECK"
            system "echo", "e8"
          end
        end
        if build.with? "openmp"
          if build.with? "python"
            system "./configure", "--disable-dependency-tracking",
                   "--enable-armadillo","--enable-gsl2",
                   "--enable-python",
                   "--enable-openmp","--disable-silent-rules",
                   "--prefix=#{prefix}"
          else
            system "./configure", "--disable-dependency-tracking",
                   "--enable-armadillo","--enable-gsl2",
                   "--enable-openmp","--disable-silent-rules",
                   "--prefix=#{prefix}"
          end
        else
          if build.with? "python"
            system "./configure", "--disable-dependency-tracking",
                   "--enable-armadillo","--enable-gsl2",
                   "--enable-python",
                   "--disable-silent-rules","--prefix=#{prefix}"
          else
            system "./configure", "--disable-dependency-tracking",
                   "--enable-armadillo","--enable-gsl2",
                   "--disable-silent-rules","--prefix=#{prefix}"
          end
        end
      end
    else
      if build.with? "eigen"
        if build.with? "fast-test"
          if build.with? "python"
            ENV["CXXFLAGS"] = "-DO2SCL_NO_RANGE_CHECK -DO2SCL_FAST_TEST -I/usr/local/lib/python3.11/site-packages/numpy/core/include -I/usr/local/opt/python@3.11/Frameworks/Python.framework/Versions/3.11/include/python3.11 -I/usr/local/opt/python@3.11/Frameworks/Python.framework/Versions/3.11/include/python3.11"
            system "echo", "e9"
          else
            ENV["CXXFLAGS"] = "-DO2SCL_NO_RANGE_CHECK -DO2SCL_FAST_TEST"
            system "echo", "e10"
          end
        else
          if build.with? "python"
            ENV["CXXFLAGS"] = "-DO2SCL_NO_RANGE_CHECK -I/usr/local/lib/python3.11/site-packages/numpy/core/include -I/usr/local/opt/python@3.11/Frameworks/Python.framework/Versions/3.11/include/python3.11 -I/usr/local/opt/python@3.11/Frameworks/Python.framework/Versions/3.11/include/python3.11"
            system "echo", "e11"
          else
            ENV["CXXFLAGS"] = "-DO2SCL_NO_RANGE_CHECK"
            system "echo", "e12"
          end
        end
        if build.with? "openmp"
          if build.with? "python"
            system "./configure", "--disable-dependency-tracking",
                   "--enable-eigen","--enable-gsl2",
                   "--enable-python",
                   "--enable-openmp","--disable-silent-rules",
                   "--prefix=#{prefix}"
          else
            system "./configure", "--disable-dependency-tracking",
                   "--enable-eigen","--enable-gsl2",
                   "--enable-openmp","--disable-silent-rules",
                   "--prefix=#{prefix}"
          end
        else
          if build.with? "python"
            system "./configure", "--disable-dependency-tracking",
                   "--enable-python",
                   "--enable-eigen","--enable-gsl2",
                   "--disable-silent-rules","--prefix=#{prefix}"
          else
            system "./configure", "--disable-dependency-tracking",
                   "--enable-eigen","--enable-gsl2",
                   "--disable-silent-rules","--prefix=#{prefix}"
          end
        end
      else
        if build.with? "fast-test"
          if build.with? "python"
            ENV["CXXFLAGS"] = "-DO2SCL_NO_RANGE_CHECK -DO2SCL_FAST_TEST -I/usr/local/lib/python3.11/site-packages/numpy/core/include -I/usr/local/opt/python@3.11/Frameworks/Python.framework/Versions/3.11/include/python3.11 -I/usr/local/opt/python@3.11/Frameworks/Python.framework/Versions/3.11/include/python3.11"
            system "echo", "e13"
          else
            ENV["CXXFLAGS"] = "-DO2SCL_NO_RANGE_CHECK -DO2SCL_FAST_TEST"
            system "echo", "e14"
          end
        else
          if build.with? "python"
            ENV["CXXFLAGS"] = "-DO2SCL_NO_RANGE_CHECK -I/usr/local/lib/python3.11/site-packages/numpy/core/include -I/usr/local/opt/python@3.11/Frameworks/Python.framework/Versions/3.11/include/python3.11 -I/usr/local/opt/python@3.11/Frameworks/Python.framework/Versions/3.11/include/python3.11"
            system "echo", "e15"
          else
            ENV["CXXFLAGS"] = "-DO2SCL_NO_RANGE_CHECK"
            system "echo", "e16"
          end
        end
        #ENV["LDFLAGS"] = "-L"+buildpath
        if build.with? "openmp"
          if build.with? "python"
            system "./configure", "--disable-dependency-tracking",
                   "--disable-silent-rules","--enable-gsl2",
                   "--enable-python",
                   "--enable-openmp","--prefix=#{prefix}"
          else
            system "./configure", "--disable-dependency-tracking",
                   "--disable-silent-rules","--enable-gsl2",
                   "--enable-openmp","--prefix=#{prefix}"
          end
        else
          if build.with? "python"
            system "./configure", "--disable-dependency-tracking",
                   "--disable-silent-rules","--enable-gsl2",
                   "--enable-python",
                   "--prefix=#{prefix}"
          else
            system "./configure", "--disable-dependency-tracking",
                   "--disable-silent-rules","--enable-gsl2",
                   "--prefix=#{prefix}"
          end
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
    # 9/28/17: I'm having problems with acol again on mimosa,
    # so I just do 'make install'

    ENV.deparallelize
    
    #system "make"
    system "make", "install"

    #
    # FIXME: should document why this is necessary
    #
    if build.with? "check"
      system "make", "check"
    end
    if build.with? "examples"
      system "make", "o2scl-examples"
    end
    include.install Dir["include/o2scl/*.h"]
    if build.with? "examples"
      share.install Dir["examples/ex*.cpp"]
    end
  end

  test do
    system "acol", "--version"
  end
end
