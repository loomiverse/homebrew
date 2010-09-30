require 'formula'

class Vlc <Formula
  url 'http://download.videolan.org/pub/videolan/vlc/1.1.4.1/vlc-1.1.4.1.tar.bz2'
  homepage 'http://www.videolan.org/'
  version '1.1.4.1'
  md5 'ce17c335b38b322949694313173fcd49'

  depends_on 'lua'
  depends_on 'libcdio'
  depends_on 'vcdimager'
  depends_on 'libogg'
  depends_on 'libshout'
  depends_on 'mad'
  depends_on 'two-lame'
  depends_on 'a52dec'
  depends_on 'flac'
  depends_on 'fribidi'
  depends_on 'libcaca'
  depends_on 'ffmpeg'
  depends_on 'sqlite'
  depends_on 'libdvdread'
  depends_on 'libdvdcss'

  def patches
    # build fails because the Sparkle framework path doesn't get set properly
    DATA
  end

  def install
    cd 'extras/contrib' do
      system "./bootstrap", "x86_64-apple-darwin"
      system "make"
    end
    system "./configure", "--disable-debug", "--disable-dependency-tracking",
                          "--prefix=#{prefix}", "--disable-postproc",
			  "--build=x86_64-apple-darwin10", "--disable-libxml2"
    system "make"
  
    #fixes for plugins stuff
    rm "VLC.app/Contents/MacOS/plugins"
    cp_r "modules", "VLC.app/Contents/MacOS/plugins"
    
    #install
    system "make install"
    ln_s "#{prefix}/lib/vlc/plugins", "#{prefix}/plugins"
    prefix.install "VLC.app"
  end
end

__END__
diff --git a/Makefile.am b/Makefile.am
index e890ba2..9101b4f 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -455,7 +455,7 @@ VLC-release.app: vlc
 	  cp "$(srcdir)/$$i" $(top_builddir)/tmp; \
 	done
 	mkdir -p $(top_builddir)/tmp/extras/contrib/Sparkle
-	cp -R $(CONTRIB_DIR)/Sparkle/Sparkle.framework $(top_builddir)/tmp/extras/contrib/Sparkle
+	cp -R extras/contrib/build/Sparkle/Sparkle.framework $(top_builddir)/tmp/extras/contrib/Sparkle
 	mkdir -p $(top_builddir)/tmp/modules/audio_output
 	mkdir -p $(top_builddir)/tmp/modules/gui/macosx
 	for i in \
@@ -608,7 +608,7 @@ VLC.app: vlc $(top_builddir)/src/.libs/libvlccore.dylib $(top_builddir)/src/.lib
 	  cp "$(srcdir)/$$i" $(top_builddir)/tmp; \
 	done
 	mkdir -p $(top_builddir)/tmp/extras/contrib/Sparkle
-	cp -R $(CONTRIB_DIR)/Sparkle/Sparkle.framework $(top_builddir)/tmp/extras/contrib/Sparkle
+	cp -R extras/contrib/build/Sparkle/Sparkle.framework $(top_builddir)/tmp/extras/contrib/Sparkle
 	mkdir -p $(top_builddir)/tmp/modules/audio_output
 	mkdir -p $(top_builddir)/tmp/modules/gui/macosx
 	for i in \
diff --git a/Makefile.in b/Makefile.in
index eb0c3b9..f859c1c 100644
--- a/Makefile.in
+++ b/Makefile.in
@@ -1645,7 +1645,7 @@ VLC-release.app: vlc
 	  cp "$(srcdir)/$$i" $(top_builddir)/tmp; \
 	done
 	mkdir -p $(top_builddir)/tmp/extras/contrib/Sparkle
-	cp -R $(CONTRIB_DIR)/Sparkle/Sparkle.framework $(top_builddir)/tmp/extras/contrib/Sparkle
+	cp -R extras/contrib/build/Sparkle/Sparkle.framework $(top_builddir)/tmp/extras/contrib/Sparkle
 	mkdir -p $(top_builddir)/tmp/modules/audio_output
 	mkdir -p $(top_builddir)/tmp/modules/gui/macosx
 	for i in \
@@ -1798,7 +1798,7 @@ VLC.app: vlc $(top_builddir)/src/.libs/libvlccore.dylib $(top_builddir)/src/.lib
 	  cp "$(srcdir)/$$i" $(top_builddir)/tmp; \
 	done
 	mkdir -p $(top_builddir)/tmp/extras/contrib/Sparkle
-	cp -R $(CONTRIB_DIR)/Sparkle/Sparkle.framework $(top_builddir)/tmp/extras/contrib/Sparkle
+	cp -R extras/contrib/build/Sparkle/Sparkle.framework $(top_builddir)/tmp/extras/contrib/Sparkle
 	mkdir -p $(top_builddir)/tmp/modules/audio_output
 	mkdir -p $(top_builddir)/tmp/modules/gui/macosx
 	for i in \
diff --git a/configure b/configure
index a4d868f..ab38f8c 100755
--- a/configure
+++ b/configure
@@ -43867,13 +43867,13 @@ then
 
 
 
-    eval "LDFLAGS_macosx="'"-F${CONTRIB_DIR}/Sparkle -Wl,-framework,Sparkle $'"{LDFLAGS_macosx}"'"'
+    eval "LDFLAGS_macosx="'"-F${topdir}/extras/contrib/build/Sparkle -Wl,-framework,Sparkle $'"{LDFLAGS_macosx}"'"'
     am_modules_with_ldflags="${am_modules_with_ldflags} macosx"
 
 
 
 
-    eval "OBJCFLAGS_macosx="'"$'"{OBJCFLAGS_macosx} -F${CONTRIB_DIR}/Sparkle"'"'
+    eval "OBJCFLAGS_macosx="'"$'"{OBJCFLAGS_macosx} -F${topdir}/extras/contrib/build/Sparkle"'"'
     am_modules_with_objcflags="${am_modules_with_objcflags} macosx"
 
 

