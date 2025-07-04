# !/bin/bash

chmod -v 755 test.sh start.sh
chmod -v 755 src/filemanager.sh
pnpm i
pnpm test
pnpm start