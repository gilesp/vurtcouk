#!/bin/bash
echo Content-type: text/plain
echo

export PATH=~/bin/:$PATH

git --git-dir=/home/gpaterson/vurt.co.uk/.git --work-tree=/home/gpaterson/vurt.co.uk pull 2>&1
hugo --theme=vurt --source=/home/gpaterson/vurt.co.uk --destination=/home/gpaterson/vurt.co.uk/public --config=config -v
echo DONE