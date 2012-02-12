require 'formula'

<<<<<<< HEAD
class Tor < Formula
  url 'https://www.torproject.org/dist/tor-0.2.2.35.tar.gz'
  homepage 'https://www.torproject.org/'
  md5 'dcecf699c4b929319d5f1ce0358d4835'

  depends_on 'libevent'

=======
class Tor <Formula
  url 'https://www.torproject.org/dist/tor-0.2.1.28.tar.gz'
  homepage 'https://www.torproject.org/'
  md5 '11e8384414623b50fe50ba7da85893db'
  sha1 '31c6995314a7a205a5d685bffbe966a766c84d7b'

  depends_on 'libevent'

#  def patches
#    {:p0 => 'https://gist.github.com/raw/344132/d27d1cd3042d7c58120688d79ed25a2fc959a2de/config.guess-x86_64patch.diff' }
#  end

>>>>>>> 515f8c07ea8fa244433c700106eb12398d95f84c
  def install
    system "./configure", "--disable-debug", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make install"

    plist_path.write startup_plist
    plist_path.chmod 0644
  end

  def startup_plist
    return <<-EOPLIST
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
  <dict>
    <key>Label</key>
    <string>#{plist_name}</string>
    <key>RunAtLoad</key>
    <true/>
    <key>KeepAlive</key>
    <true/>
    <key>UserName</key>
    <string>#{`whoami`.chomp}</string>
    <key>ProgramArguments</key>
    <array>
        <string>#{HOMEBREW_PREFIX}/bin/tor</string>
    </array>
    <key>WorkingDirectory</key>
    <string>#{HOMEBREW_PREFIX}</string>
  </dict>
</plist>
    EOPLIST
  end

  def caveats; <<-EOS.undent
    You can start tor automatically on login with:
      mkdir -p ~/Library/LaunchAgents
      cp #{plist_path} ~/Library/LaunchAgents/
      launchctl load -w ~/Library/LaunchAgents/#{plist_path.basename}
    EOS
  end
end
