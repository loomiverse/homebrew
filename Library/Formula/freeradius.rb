require 'formula'

class Freeradius <Formula
  url 'ftp://ftp.freeradius.org//pub/freeradius//freeradius-server-2.1.10.tar.bz2'
  homepage 'http://www.freeradius.org/'
  md5 '8ea2bd39460a06212decf2c14fdf3fb8'
  sha1 '3651ac3d50ec8b01ae46f9df5a50e31379c1e522'

  version '2.1.10'

  def install
    system "./configure", "--disable-debug", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"

    system "make"
    system "make -j1 install"
  end
end
