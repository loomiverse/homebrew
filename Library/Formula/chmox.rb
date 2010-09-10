require 'formula'

class Chmox <Formula
  head 'cvs://:pserver:anonymous@chmox.cvs.sourceforge.net:/cvsroot/chmox:Sources'
  homepage 'http://chmox.sourceforge.net'
  md5 ''

  def install
    system "xcodebuild"
    prefix.install "build/Default/Chmox.app"
  end
end
