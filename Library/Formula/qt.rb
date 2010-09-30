require 'formula'
require 'hardware'

class Qt <Formula
  url 'http://get.qt.nokia.com/qt/source/qt-everywhere-opensource-src-4.7.0.tar.gz'
  version '4.7.0'
  md5 '3a2f25b9b115037277f4fb759194a7a5'
  homepage 'http://www.qtsoftware.com'

  def options
    [
      ['--with-qtdbus', "Enable QtDBus module."],
    ]
  end

  depends_on "d-bus" if ARGV.include? '--with-qtdbus'
  depends_on 'sqlite' if MACOS_VERSION <= 10.5

  def install
    args = ["-prefix", prefix, "-release", 
            "-confirm-license", "-opensource"]

    # See: http://github.com/mxcl/homebrew/issues/issue/744
    args << "-system-sqlite" if MACOS_VERSION <= 10.5
    args << "-plugin-sql-mysql" if (HOMEBREW_CELLAR+"mysql").directory?

    if ARGV.include? '--with-qtdbus'
      args << "-I#{Formula.factory('d-bus').lib}/dbus-1.0/include"
      args << "-I#{Formula.factory('d-bus').include}/dbus-1.0"
      args << "-L#{Formula.factory('d-bus').lib}"
      args << "-ldbus-1"
      args << "-dbus-linked"
    end

    if snow_leopard_64?
      args << '-arch' << 'x86_64'
    else
      args << '-arch' << 'x86'
    end

    system "./configure", *args
    system "make"
    system "make install"

    # remove porting file for non-humans
    (prefix+'q3porting.xml').unlink

    # Some config scripts will only find Qt in a "Frameworks" folder
    # VirtualBox is an example of where this is needed
    # See: http://github.com/mxcl/homebrew/issues/issue/745
    cd prefix do
      ln_s lib, "Frameworks"
    end
  end

  def caveats
    "We agreed to the Qt opensource license for you.\nIf this is unacceptable you should uninstall."
  end
end
