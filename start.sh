#! /bin/bash

. $NVM_DIR/nvm.sh

workdir=$1

test -d "$workdir" && cd $workdir

npm install
npm start
