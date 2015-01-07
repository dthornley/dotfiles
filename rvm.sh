gpg --keyserver hkp://keys.gnupg.net --recv-keys D39DC0E3
\curl -sSL https://get.rvm.io | bash -s stable --auto-dotfiles
source .bash_profile
rvm install 2.2.0
