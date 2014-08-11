#!/bin/bash
echo Content-type: text/plain
echo

export PATH=~/bin/:$PATH

git --git-dir=/home/gpaterson/vurt.co.uk/public/.git --work-tree=/home/gpaterson/vurt.co.uk/public pull 2>&1
echo DONE
