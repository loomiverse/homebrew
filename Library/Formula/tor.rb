require 'formula'

class Tor <Formula
  url 'https://www.torproject.org/dist/tor-0.2.1.28.tar.gz'
  homepage 'https://www.torproject.org/'
  md5 '11e8384414623b50fe50ba7da85893db'
  sha1 '31c6995314a7a205a5d685bffbe966a766c84d7b'

  depends_on 'libevent'

#  def patches
#    {:p0 => 'https://gist.github.com/raw/344132/d27d1cd3042d7c58120688d79ed25a2fc959a2de/config.guess-x86_64patch.diff' }
#  end

  def install
    system "./configure", "--prefix=#{prefix}", "--disable-debug", "--disable-dependency-tracking"
    system "make install"
  end
end
