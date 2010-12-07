#!/bin/sh
rsync -r public/ seanmcgivern@tombstone.org.uk:~/domains/sean.mcgivern.me.uk/graph-database/ --exclude=.gitignore
