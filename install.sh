sudo apt-get install git
git submodule add --force  https://github.com/bats-core/bats-support.git src/tests/test_helper/bats-support
git submodule add --force  https://github.com/bats-core/bats-assert.git src/tests/test_helper/bats-assert
cd ~
sudo rm -rf bats-core
git clone https://github.com/bats-core/bats-core.git
cd bats-core/
sudo ./install.sh /usr/local
which bats
bats --version
 