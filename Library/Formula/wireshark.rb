require 'formula'

class Wireshark <Formula
  url 'http://media-2.cacetech.com/wireshark/src/wireshark-1.4.0.tar.bz2'
  md5 '13b188baea23cdad40b7a55921384a77'
  homepage 'http://www.wireshark.org'

  depends_on 'gnutls' => :optional
  depends_on 'pcre' => :optional
  depends_on 'glib'
  depends_on 'gtk+'

  def install
    system "./configure", "--prefix=#{prefix}",
                          "--disable-dependency-tracking"
                          #"--disable-wireshark" # actually just disables the GTK GUI
    system "make"
    
    ENV.j1 # Install failed otherwise.
    system "make install"

    #build Wireshark.app
    inreplace "packaging/macosx/osx-app.sh", "/opt/local", HOMEBREW_PREFIX 
    system "make osx-app"
    mkdir "packaging/macosx/Wireshark.app/Contents/Resources/Cellar"
    cp_r "#{HOMEBREW_PREFIX}/Cellar/gtk+", "packaging/macosx/Wireshark.app/Contents/Resources/Cellar"
    cp_r "#{HOMEBREW_PREFIX}/Cellar/pango", "packaging/macosx/Wireshark.app/Contents/Resources/Cellar"

    prefix.install "packaging/macosx/Wireshark.app"
  end

  def caveats
    "We don't build the X11-enabled GUI by default"
  end
end
