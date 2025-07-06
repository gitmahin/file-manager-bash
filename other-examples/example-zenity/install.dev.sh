# !/bin/bash

current_path=$(pwd)

sudo apt-get install git
cd ~
sudo rm -rf bats-core
# Clone the Bats testing framework from GitHub
git clone https://github.com/bats-core/bats-core.git
# Navigate into the cloned bats-core directory
cd bats-core/
# Install Bats to /usr/local (you'll need sudo for this)
sudo ./install.sh /usr/local
# Install Bats to /usr/local (you'll need sudo for this)
which bats
bats --version

cd "$current_path"
chmod -v 755 start.dev.sh test.sh
 