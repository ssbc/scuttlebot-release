#! /bin/bash

rm npm-shrinkwrap.json
npm install scuttlebot@$1 --package-lock && {
  npm shrinkwrap
  node update.js $1 $2
  npm install #install dev deps
  hash=`shasum -a 256 < npm-shrinkwrap.json`
  echo $1$2 ${hash:0:64} >> hashes.txt
  git add .
  git commit -m $1$2
  npm test && {
    npm publish
  }
}


