require 'formula'

class DfuProgrammer <Formula

  depends_on 'libusb-compat'
  url 'http://downloads.sourceforge.net/project/dfu-programmer/dfu-programmer/0.5.2/dfu-programmer-0.5.2.tar.gz'
  homepage 'http://sourceforge.net/projects/dfu-programmer/'
  md5 'ce882d37383df698a1c530080724b191'

  def install
    system "./configure", "--disable-debug", "--disable-dependency-tracking", "--prefix=#{prefix}"
    system "make install"
  end
end
