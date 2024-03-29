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
    url "https://github.com/awsteiner/o2scl/releases/download/v0.928/o2scl-0.928.tar.gz"
    sha256 "55843e5aa1eb2f45b2c0e12cf18b403eccc24ce474562f60989fc07a23afc830"
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

    # Set up CXXFLAGS
    if build.with? "no-range-check"
      if build.with? "fast-test"
        if build.with? "python"
          # no-range-check, fast-test, python
          ENV["CXXFLAGS"] = "-DO2SCL_NO_RANGE_CHECK -DO2SCL_FAST_TEST -I/usr/local/lib/python3.11/site-packages/numpy/core/include -I/usr/local/opt/python@3.11/Frameworks/Python.framework/Versions/3.11/include/python3.11"
          system "echo", "e1"
        else # else for if python
          # no-range-check, fast-test, no python
          ENV["CXXFLAGS"] = "-DO2SCL_NO_RANGE_CHECK -DO2SCL_FAST_TEST"
          system "echo", "e2"
        end # end of if python
      else # else for fast-test
        if build.with? "python"
          #  no-range-check, no fast-test, python
          ENV["CXXFLAGS"] = "-DO2SCL_NO_RANGE_CHECK -I/usr/local/lib/python3.11/site-packages/numpy/core/include -I/usr/local/opt/python@3.11/Frameworks/Python.framework/Versions/3.11/include/python3.11"
          system "echo", "e3"
        else # else for if python
          # no-range-check, no fast-test, no python
          ENV["CXXFLAGS"] = "-DO2SCL_NO_RANGE_CHECK"
          system "echo", "e4"
        end # end of if python
      end # end of if fast-test
    else # else for if no-range-check
      if build.with? "fast-test"
        if build.with? "python"
          #  with range-check, fast-test, python
          ENV["CXXFLAGS"] = "-DO2SCL_FAST_TEST -I/usr/local/lib/python3.11/site-packages/numpy/core/include -I/usr/local/opt/python@3.11/Frameworks/Python.framework/Versions/3.11/include/python3.11"
          system "echo", "e5"
        else # else for python
          #  with range-check, fast-test, no python
          ENV["CXXFLAGS"] = "-DO2SCL_FAST_TEST"
          system "echo", "e6"
        end # end of if python
      else # else for fast-test
        if build.with? "python"
          #  with range-check, no fast-test, python
          ENV["CXXFLAGS"] = "-I/usr/local/lib/python3.11/site-packages/numpy/core/include -I/usr/local/opt/python@3.11/Frameworks/Python.framework/Versions/3.11/include/python3.11"
          system "echo", "e7"
        else
          #  with range-check, no fast-test, no python
          ENV["CXXFLAGS"] = ""
          system "echo", "e8"
        end # end of if python
      end # end of if fast-test
    end # end of if no-range-check

    # ------------------------------------------------------------
    # Set up ./configure script
    
    if build.with? "armadillo"
      if build.with? "eigen"
        if build.with? "openmp"
          if build.with? "python"
            # armadillo, eigen, openmp, python
            system "./configure", "--disable-dependency-tracking",
                   "--enable-armadillo", "--enable-eigen",
                   "--enable-python","--enable-openmp",
                   "--disable-silent-rules","--prefix=#{prefix}"
          else
            # armadillo, eigen, openmp, no python
            system "./configure", "--disable-dependency-tracking",
                   "--enable-armadillo", "--enable-eigen",
                   "--enable-openmp",
                   "--disable-silent-rules","--prefix=#{prefix}"
          end
        else
          if build.with? "python"
            # armadillo, eigen, no openmp, python
            system "./configure", "--disable-dependency-tracking",
                   "--enable-armadillo", "--enable-eigen",
                   "--enable-python",
                   "--disable-silent-rules","--prefix=#{prefix}"
          else
            # armadillo, eigen, no openmp, no python
            system "./configure", "--disable-dependency-tracking",
                   "--enable-armadillo", "--enable-eigen",
                   "--disable-silent-rules","--prefix=#{prefix}"
          end
        end
      else 
        if build.with? "openmp"
          if build.with? "python"
            # armadillo, no eigen, openmp, python
            system "./configure", "--disable-dependency-tracking",
                   "--enable-armadillo",
                   "--enable-python",
                   "--enable-openmp","--disable-silent-rules",
                   "--prefix=#{prefix}"
          else
            # armadillo, no eigen, openmp, no python
            system "./configure", "--disable-dependency-tracking",
                   "--enable-armadillo",
                   "--enable-openmp","--disable-silent-rules",
                   "--prefix=#{prefix}"
          end
        else
          if build.with? "python"
            # armadillo, no eigen, no openmp, python
            system "./configure", "--disable-dependency-tracking",
                   "--enable-armadillo",
                   "--enable-python",
                   "--disable-silent-rules","--prefix=#{prefix}"
          else
            # armadillo, no eigen, no openmp, no python
            system "./configure", "--disable-dependency-tracking",
                   "--enable-armadillo",
                   "--disable-silent-rules","--prefix=#{prefix}"
          end
        end
      end
    else
      if build.with? "eigen"
        if build.with? "openmp"
          if build.with? "python"
            # no armadillo, eigen, openmp, python
            system "./configure", "--disable-dependency-tracking",
                   "--enable-eigen",
                   "--enable-python",
                   "--enable-openmp","--disable-silent-rules",
                   "--prefix=#{prefix}"
          else
            # no armadillo, eigen, openmp, no python
            system "./configure", "--disable-dependency-tracking",
                   "--enable-eigen",
                   "--enable-openmp","--disable-silent-rules",
                   "--prefix=#{prefix}"
          end
        else
          if build.with? "python"
            # no armadillo, eigen, no openmp, python
            system "./configure", "--disable-dependency-tracking",
                   "--enable-python",
                   "--enable-eigen",
                   "--disable-silent-rules","--prefix=#{prefix}"
          else
            # no armadillo, eigen, no openmp, no python
            system "./configure", "--disable-dependency-tracking",
                   "--enable-eigen",
                   "--disable-silent-rules","--prefix=#{prefix}"
          end
        end
      else
        if build.with? "openmp"
          if build.with? "python"
            # no armadillo, no eigen, openmp, python
            system "./configure", "--disable-dependency-tracking",
                   "--disable-silent-rules",
                   "--enable-python",
                   "--enable-openmp","--prefix=#{prefix}"
          else
            # no armadillo, no eigen, openmp, no python
            system "./configure", "--disable-dependency-tracking",
                   "--disable-silent-rules",
                   "--enable-openmp","--prefix=#{prefix}"
          end
        else
          if build.with? "python"
            # no armadillo, no eigen, no openmp, python
            system "./configure", "--disable-dependency-tracking",
                   "--disable-silent-rules",
                   "--enable-python",
                   "--prefix=#{prefix}"
          else
            # no armadillo, no eigen, no openmp, no python
            system "./configure", "--disable-dependency-tracking",
                   "--disable-silent-rules",
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
