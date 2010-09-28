require 'formula'

class QtCreator <Formula
  url 'http://get.qt.nokia.com/qtcreator/qt-creator-2.0.1-src.tgz'
  homepage 'http://qt.nokia.com/products/developer-tools'
  version '2.0.1'
  md5 'be594ed4f935b429a6bd8612fe2a4767'

  def install
    system "qmake qtcreator.pro"
    system "make -j 2"
    prefix.install "bin/Qt\ Creator.app"
  end
end
