require 'formula'

class QtCreator < Formula
  homepage 'http://qt.nokia.com/products/developer-tools'
  url 'http://get.qt.nokia.com/qtcreator/qt-creator-2.4.1-src.zip'
  md5 '52579f6c42ee1553742bde58bb291859'

  def install
    system "qmake qtcreator.pro"
    system "make"
    prefix.install "bin/Qt\ Creator.app"
  end

  def test
    # This test will fail and we won't accept that! It's enough to just
    # replace "false" with the main program this formula installs, but
    # it'd be nice if you were more thorough. Test the test with
    # `brew test qt-creator`. Remove this comment before submitting
    # your pull request!
    system "false"
  end
end
