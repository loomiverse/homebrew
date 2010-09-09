require 'formula'

class Lrzsz <Formula
  url 'http://www.ohse.de/uwe/releases/lrzsz-0.12.20.tar.gz'
  homepage 'http://www.ohse.de/uwe/software/lrzsz.html'
  md5 'b5ce6a74abc9b9eb2af94dffdfd372a4'
  version '0.12.20'

  def install
    system "./configure", "--disable-debug", "--disable-dependency-tracking",
                          "--prefix=#{prefix}", "--mandir=#{man}", 
			  "--program-transform-name=s/l//", "--infodir=#{info}"
    system "make"
    system "make -j 1 install"
  end
end
