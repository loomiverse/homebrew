require 'formula'
require 'hardware'

class Qt <Formula
  url 'http://get.qt.nokia.com/qt/source/qt-everywhere-opensource-src-4.7.1.tar.gz'
  version '4.7.1'
  md5 '6f88d96507c84e9fea5bf3a71ebeb6d7'
  sha1 'fcf764d39d982c7f84703821582bd10c3192e341'
  homepage 'http://www.qtsoftware.com'

  def patches
    # build fails due to sse4.2 error.  patch from http://bugs.gentoo.org/show_bug.cgi?id=344915
    DATA
  end

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

__END__
diff --git a/src/corelib/tools/qsimd_p.h b/src/corelib/tools/qsimd_p.h
index 664543b..08da700 100644
--- a/src/corelib/tools/qsimd_p.h
+++ b/src/corelib/tools/qsimd_p.h
@@ -87,9 +87,13 @@ QT_BEGIN_HEADER
 #include <tmmintrin.h>
 #endif
 
-// SSE4.1 and SSE4.2 intrinsics
-#if (defined(QT_HAVE_SSE4_1) || defined(QT_HAVE_SSE4_2)) && (defined(__SSE4_1__) || defined(Q_CC_MSVC))
+// SSE4.1 intrinsics
+#if defined(QT_HAVE_SSE4_1) && (defined(__SSE4_1__) || defined(Q_CC_MSVC))
 #include <smmintrin.h>
+#endif
+
+// SSE4.2 intrinsics
+#if defined(QT_HAVE_SSE4_2) && (defined(__SSE4_2__) || defined(Q_CC_MSVC))
 #include <nmmintrin.h>
 #endif

