sudo apt-get install git
cd ~
sudo rm -rf bats-core
git clone https://github.com/bats-core/bats-core.git
cd bats-core/
sudo ./install.sh /usr/local
which bats
bats --version
 