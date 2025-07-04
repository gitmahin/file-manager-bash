current_path=$(pwd)

sudo apt-get install git
cd ~
sudo rm -rf bats-core
git clone https://github.com/bats-core/bats-core.git
cd bats-core/
sudo ./install.sh /usr/local
which bats
bats --version

cd "$current_path"
chmod -v 755 install.sh permission.sh start.sh test.sh
chmod -v 755 src/filemanager.sh
source "./test.sh"
cd src
"./filemanager.sh"
 