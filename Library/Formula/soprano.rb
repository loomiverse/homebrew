require 'formula'

class Soprano < Formula
  url 'http://downloads.sourceforge.net/project/soprano/Soprano/2.7.4/soprano-2.7.4.tar.bz2'

  homepage 'http://soprano.sourceforge.net/'
  md5 '783fb07f9679f45e987aff7a17bef649'

  depends_on 'cmake' => :build
  depends_on 'qt'
  depends_on 'clucene' => :optional
  depends_on 'raptor' => :optional
  depends_on 'redland' => :optional

  def patches
    # generate qch file for documentation
    DATA
  end

  def install
    ENV['CLUCENE_HOME'] = HOMEBREW_PREFIX

    system "cmake . #{std_cmake_parameters}"
    system "make apidox"
    system "make install"
    prefix.install Dir['docs']
  end
end

__END__
diff --git a/Doxyfile.cmake b/Doxyfile.cmake
index cb8e9ad..8ec05a0 100644
--- a/Doxyfile.cmake
+++ b/Doxyfile.cmake
@@ -1,6 +1,16 @@
 # Doxyfile 1.5.3
 
 #---------------------------------------------------------------------------
+# qch related configuration options
+#---------------------------------------------------------------------------
+GENERATE_QHP            = yes
+QHP_NAMESPACE           = "org.kde.soprano"
+QHP_VIRTUAL_FOLDER      = "soprano"
+
+QCH_FILE                = "../soprano.qch"
+QHG_LOCATION            = "qhelpgenerator"
+
+#---------------------------------------------------------------------------
 # Project related configuration options
 #---------------------------------------------------------------------------
 DOXYFILE_ENCODING      = UTF-8

