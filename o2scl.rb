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

  resource "certifi" do
    url "https://files.pythonhosted.org/packages/37/f7/2b1b0ec44fdc30a3d31dfebe52226be9ddc40cd6c0f34ffc8923ba423b69/certifi-2022.12.7.tar.gz"
    sha256 "35824b4c3a97115964b408844d64aa14db1cc518f6562e8d7261699d1350a9e3"
  end

  resource "charset-normalizer" do
    url "https://files.pythonhosted.org/packages/96/d7/1675d9089a1f4677df5eb29c3f8b064aa1e70c1251a0a8a127803158942d/charset-normalizer-3.0.1.tar.gz"
    sha256 "ebea339af930f8ca5d7a699b921106c6e29c617fe9606fa7baa043c1cdae326f"
  end

  resource "contourpy" do
    url "https://files.pythonhosted.org/packages/b4/9b/6edb9d3e334a70a212f66a844188fcb57ddbd528cbc3b1fe7abfc317ddd7/contourpy-1.0.7.tar.gz"
    sha256 "d8165a088d31798b59e91117d1f5fc3df8168d8b48c4acc10fc0df0d0bdbcc5e"
  end

  resource "cycler" do
    url "https://files.pythonhosted.org/packages/34/45/a7caaacbfc2fa60bee42effc4bcc7d7c6dbe9c349500e04f65a861c15eb9/cycler-0.11.0.tar.gz"
    sha256 "9c87405839a19696e837b3b818fed3f5f69f16f1eec1a1ad77e043dcea9c772f"
  end

  resource "fonttools" do
    url "https://files.pythonhosted.org/packages/2f/7c/20b9289a88e35c2015541ab869c999178d5e4ad2c9dec49544ed0e34ae01/fonttools-4.39.4.zip"
    sha256 "dba8d7cdb8e2bac1b3da28c5ed5960de09e59a2fe7e63bb73f5a59e57b0430d2"
  end

  resource "h5py" do
    url "https://files.pythonhosted.org/packages/69/f4/3172bb63d3c57e24aec42bb93fcf1da4102752701ab5ad10b3ded00d0c5b/h5py-3.8.0.tar.gz"
    sha256 "6fead82f0c4000cf38d53f9c030780d81bfa0220218aee13b90b7701c937d95f"
  end

  resource "idna" do
    url "https://files.pythonhosted.org/packages/8b/e1/43beb3d38dba6cb420cefa297822eac205a277ab43e5ba5d5c46faf96438/idna-3.4.tar.gz"
    sha256 "814f528e8dead7d329833b91c5faa87d60bf71824cd12a7530b5526063d02cb4"
  end

  resource "kiwisolver" do
    url "https://files.pythonhosted.org/packages/5f/5c/272a7dd49a1914f35cd8d6d9f386defa8b047f6fbd06badd6b77b3ba24e7/kiwisolver-1.4.4.tar.gz"
    sha256 "d41997519fcba4a1e46eb4a2fe31bc12f0ff957b2b81bac28db24744f333e955"
  end

  resource "matplotlib" do
    url "https://files.pythonhosted.org/packages/b7/65/d6e00376dbdb6c227d79a2d6ec32f66cfb163f0cd924090e3133a4f85a11/matplotlib-3.7.1.tar.gz"
    sha256 "7b73305f25eab4541bd7ee0b96d87e53ae9c9f1823be5659b806cd85786fe882"
  end

  resource "numpy" do
    url "https://files.pythonhosted.org/packages/2c/d4/590ae7df5044465cc9fa2db152ae12468694d62d952b1528ecff328ef7fc/numpy-1.24.3.tar.gz"
    sha256 "ab344f1bf21f140adab8e47fdbc7c35a477dc01408791f8ba00d018dd0bc5155"
  end

  resource "o2sclpy" do
    url "https://files.pythonhosted.org/packages/4a/4f/98ff9ac3eea9d3475e8cbe48720c79235c5c2810cd8e7c9389021fa863eb/o2sclpy-0.927.post1.tar.gz"
    sha256 "ee4f4b5eb4a4a27f984f63a0e101bccc40ef0cbd3c774ea1a31fb2baec3fbf57"
  end

  resource "packaging" do
    url "https://files.pythonhosted.org/packages/b9/6c/7c6658d258d7971c5eb0d9b69fa9265879ec9a9158031206d47800ae2213/packaging-23.1.tar.gz"
    sha256 "a392980d2b6cffa644431898be54b0045151319d1e7ec34f0cfed48767dd334f"
  end

  resource "Pillow" do
    url "https://files.pythonhosted.org/packages/00/d5/4903f310765e0ff2b8e91ffe55031ac6af77d982f0156061e20a4d1a8b2d/Pillow-9.5.0.tar.gz"
    sha256 "bf548479d336726d7a0eceb6e767e179fbde37833ae42794602631a070d630f1"
  end

  resource "pyparsing" do
    url "https://files.pythonhosted.org/packages/71/22/207523d16464c40a0310d2d4d8926daffa00ac1f5b1576170a32db749636/pyparsing-3.0.9.tar.gz"
    sha256 "2b020ecf7d21b687f219b71ecad3631f644a47f01403fa1d1036b0c6416d70fb"
  end

  resource "python-dateutil" do
    url "https://files.pythonhosted.org/packages/4c/c4/13b4776ea2d76c115c1d1b84579f3764ee6d57204f6be27119f13a61d0a9/python-dateutil-2.8.2.tar.gz"
    sha256 "0123cacc1627ae19ddf3c27a5de5bd67ee4586fbdd6440d9748f8abb483d3e86"
  end

  resource "requests" do
    url "https://files.pythonhosted.org/packages/9d/ee/391076f5937f0a8cdf5e53b701ffc91753e87b07d66bae4a09aa671897bf/requests-2.28.2.tar.gz"
    sha256 "98b1b2782e3c6c4904938b84c0eb932721069dfdb9134313beff7c83c2df24bf"
  end

  resource "six" do
    url "https://files.pythonhosted.org/packages/71/39/171f1c67cd00715f190ba0b100d606d440a28c93c7714febeca8b79af85e/six-1.16.0.tar.gz"
    sha256 "1e61c37477a1626458e36f7b1d82aa5c9b094fa4802892072e49de9c60c4c926"
  end

  resource "urllib3" do
    url "https://files.pythonhosted.org/packages/c5/52/fe421fb7364aa738b3506a2d99e4f3a56e079c0a798e9f4fa5e14c60922f/urllib3-1.26.14.tar.gz"
    sha256 "076907bf8fd355cde77728471316625a4d2f7e713c125f51953bb5b3eecf4f72"
  end

  option "with-check", "Run build-time tests"
  option "with-examples", "Run build-time examples"
  option "with-armadillo", "Include armadillo support [not working yet]"
  option "with-eigen", "Include eigen support"
  option "with-openmp", "Include OpenMP support"
  option "with-no-range-check", "Disable range-checking"
  option "with-fast-test", "Skip some tests to run faster"
  option "with-python", "Automatic python support"

  depends_on "gsl"
  depends_on "hdf5"
  depends_on "boost"
  depends_on "readline"
  depends_on "armadillo" => :optional
  depends_on "eigen" => :optional
  depends_on "python@3.11"
  
  # 9/23/2020: I've been having trouble with builds failing because
  # they can't find autoreconf, and this seems to fix it for now, even
  # though these packages really aren't required if you're building
  # from a release. 
  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build

  include Language::Python::Virtualenv
  
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
            else
              ENV["CXXFLAGS"] = "-DO2SCL_NO_RANGE_CHECK -DO2SCL_FAST_TEST"
            end
          else
            if build.with? "python"
              ENV["CXXFLAGS"] = "-DO2SCL_NO_RANGE_CHECK -I/usr/local/lib/python3.11/site-packages/numpy/core/include -I/usr/local/opt/python@3.11/Frameworks/Python.framework/Versions/3.11/include/python3.11 -I/usr/local/opt/python@3.11/Frameworks/Python.framework/Versions/3.11/include/python3.11"
            else
              ENV["CXXFLAGS"] = "-DO2SCL_NO_RANGE_CHECK"
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
          else
            ENV["CXXFLAGS"] = "-DO2SCL_NO_RANGE_CHECK -DO2SCL_FAST_TEST"
          end
        else
          if build.with? "python"
            ENV["CXXFLAGS"] = "-DO2SCL_NO_RANGE_CHECK -I/usr/local/lib/python3.11/site-packages/numpy/core/include -I/usr/local/opt/python@3.11/Frameworks/Python.framework/Versions/3.11/include/python3.11 -I/usr/local/opt/python@3.11/Frameworks/Python.framework/Versions/3.11/include/python3.11"
          else
            ENV["CXXFLAGS"] = "-DO2SCL_NO_RANGE_CHECK"
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
          else
            ENV["CXXFLAGS"] = "-DO2SCL_NO_RANGE_CHECK -DO2SCL_FAST_TEST"
          end
        else
          if build.with? "python"
            ENV["CXXFLAGS"] = "-DO2SCL_NO_RANGE_CHECK -I/usr/local/lib/python3.11/site-packages/numpy/core/include -I/usr/local/opt/python@3.11/Frameworks/Python.framework/Versions/3.11/include/python3.11 -I/usr/local/opt/python@3.11/Frameworks/Python.framework/Versions/3.11/include/python3.11"
          else
            ENV["CXXFLAGS"] = "-DO2SCL_NO_RANGE_CHECK"
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
          else
            ENV["CXXFLAGS"] = "-DO2SCL_NO_RANGE_CHECK -DO2SCL_FAST_TEST"
          end
        else
          if build.with? "python"
            ENV["CXXFLAGS"] = "-DO2SCL_NO_RANGE_CHECK -I/usr/local/lib/python3.11/site-packages/numpy/core/include -I/usr/local/opt/python@3.11/Frameworks/Python.framework/Versions/3.11/include/python3.11 -I/usr/local/opt/python@3.11/Frameworks/Python.framework/Versions/3.11/include/python3.11"
          else
            ENV["CXXFLAGS"] = "-DO2SCL_NO_RANGE_CHECK"
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
    
    if build.with? "python"

      venv = virtualenv_create(libexec, "python3.11")
      # Install all of the resources declared on the formula into the virtualenv.
      resources.each do |r|
        venv.pip_install r
      end
      venv.pip_install_and_link buildpath
    
    end
    
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
