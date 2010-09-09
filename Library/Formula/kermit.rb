require 'formula'

class Kermit <Formula
  url 'ftp://kermit.columbia.edu/kermit/archives/cku211.tar.gz'
  homepage 'http://www.columbia.edu/kermit/'
  md5 '5767ec5e6ff0857cbfe2d3ec1ee0e2bc'
  version '8.0.211'

  # depends_on 'cmake'

  def install
    system "make macosx103"
    system "mkdir -p #{prefix}/share/man/man1"
    system "make", "prefix=#{prefix}", "manroot=#{prefix}/share", "install"
  end
end
