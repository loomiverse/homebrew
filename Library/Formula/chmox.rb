require 'formula'

class Chmox <Formula
  head 'cvs://:pserver:anonymous@chmox.cvs.sourceforge.net:/cvsroot/chmox:Sources'
  homepage 'http://chmox.sourceforge.net'

  def install
    system "xcodebuild"
    prefix.install "build/Default/Chmox.app"
  end
<<<<<<< HEAD

  def caveats; <<-EOS.undent
    Chmox.app installed to:
      #{prefix}
    Use \"brew linkapps\" to symlink into ~/Applications.
    EOS
  end
=======
>>>>>>> 4777429c34f7a6ca4f202dc2b31a95fc60e804ee
end
