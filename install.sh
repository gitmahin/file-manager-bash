# !/bin/bash

chmod -v 755 install.sh test.sh start.sh
chmod -v 755 src/filemanager.sh
source "./test.sh"
pnpm i
pnpm test
pnpm start