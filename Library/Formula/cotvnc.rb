require 'formula'

class Cotvnc <Formula
  url 'http://downloads.sourceforge.net/project/cotvnc/cotvnc/Chicken%20of%20the%20VNC%202.0b4/cotvnc-20b4-source.tgz'
  homepage 'http://sourceforge.net/projects/cotvnc/'
  version '2.0b4'
  md5 '9383068b0a381857551404c86bd05dc1'

  def install
    system "xcodebuild"
    prefix.install "build/Development/Chicken\ of\ the\ VNC.app"
  end

  def caveats; <<-EOS.undent
    Chmox.app installed to:
      #{prefix}
    Use \"brew linkapps\" to symlink into ~/Applications.
    EOS
  end
end
