#!/usr/bin/env bash

# Install command-line tools using Homebrew.

# Ask for the administrator password upfront.
sudo -v

# Keep-alive: update existing `sudo` time stamp until the script has finished.
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# Make sure we’re using the latest Homebrew.
brew update

# Upgrade any already-installed formulae.
brew upgrade

# Install GNU core utilities (those that come with OS X are outdated).
# Don’t forget to add `$(brew --prefix coreutils)/libexec/gnubin` to `$PATH`.
brew install coreutils
sudo ln -s /usr/local/bin/gsha256sum /usr/local/bin/sha256sum

# Install some other useful utilities like `sponge`.
brew install moreutils
# Install GNU `find`, `locate`, `updatedb`, and `xargs`, `g`-prefixed.
brew install findutils
# Install GNU `sed`, overwriting the built-in `sed`.
brew install gnu-sed --with-default-names
# Install Bash 4.
# Note: don’t forget to add `/usr/local/bin/bash` to `/etc/shells` before
# running `chsh`.
brew install bash
brew install bash-completion
grep /usr/local/bin/bash /etc/shells > /dev/null
if [ $? -eq 1 ]; then
  echo /usr/local/bin/bash | sudo tee -a /etc/shells
fi
chsh -s /usr/local/bin/bash


# Install `wget` with IRI support.
brew install wget --with-iri

# Install RingoJS and Narwhal.
# Note that the order in which these are installed is important;
# see http://git.io/brew-narwhal-ringo.
brew install ringojs
brew install narwhal

# Install more recent versions of some OS X tools.
brew install vim --override-system-vi
brew install homebrew/dupes/grep
brew install homebrew/dupes/screen

# Picturae - install openssl first before php
brew install openssl

brew install homebrew/php/php55 --with-gmp

# Install some CTF tools; see https://github.com/ctfs/write-ups.
brew install bfg
brew install binutils
brew install binwalk
brew install cifer
#brew install dex2jar
#brew install dns2tcp
brew install fcrackzip
brew install foremost
#brew install hashpump
#brew install hydra
#brew install john
#brew install knock
brew install nmap
brew install pngcheck
#brew install socat
brew install sqlmap
brew install tcpflow
brew install tcpreplay
brew install tcptrace
brew install ucspi-tcp # `tcpserver` etc.
brew install xpdf
brew install xz

# Install other useful binaries.
brew install ack
#brew install exiv2
brew install git
brew install imagemagick --with-webp
brew install lua
brew install lynx
brew install p7zip
brew install pigz
brew install pv
brew install rename
brew install rhino
brew install speedtest_cli
brew install tree
brew install webkit2png
brew install zopfli

# Install Node.js. Note: this installs `npm` too, using the recommended
# installation method.
#brew install node

#
# Picturae packages
#
brew install nvm
brew install composer

# Install subversion and replace the /usr/bin versions to ensure that phing uses the correct svn version
# Phing hardcodes the path to svn (/usr/bin/svn)
brew install svn
FILES="svn svnadmin svndumpfilter svnlook svnserve svnsync svnversion"
for file in ${FILES}
do
  if [ -f /usr/bin/${file} ]
  then
    sudo mv /usr/bin/${file} /usr/bin/${file}.orig
    sudo ln -s /usr/local/bin/${file} /usr/bin/${file}
  fi
done

brew install mysql
brew install closure-compiler
brew install boot2docker
brew install gpg
brew install php55-mongo
brew install php55-phalcon
brew install caskroom/cask/brew-cask
brew tap caskroom/versions
brew cask install phpstorm
brew cask install pgadmin3
brew cask install java
brew cask install google-chrome
brew cask install google-chrome-canary
brew cask install imagealpha
brew cask install imageoptim
brew cask install iterm2
#brew cask install macvim
brew cask install miro-video-converter
brew cask install opera
brew cask install sublime-text
brew cask install the-unarchiver
brew cask install ukelele
brew cask install virtualbox
brew cask install vlc

# configure nvm
grep "source $(brew --prefix nvm)/nvm.sh" ~/.bash_profile > /dev/null
if [ $? -eq 1 ]; then
  echo export NVM_DIR=~/.nvm >> ~/.bash_profile
  echo source $(brew --prefix nvm)/nvm.sh >> ~/.bash_profile
fi

# Remove outdated versions from the cellar.
brew cleanup
