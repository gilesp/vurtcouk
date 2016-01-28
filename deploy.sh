#!/bin/bash

echo -e "\033[0;32mUpdating themse...\033[0m"
git submodule foreach git pull origin master

echo -e "\033[0;32mBuilding site...\033[0m"
rm -rf public/*
hugo 

echo -e "\033[0;32mDeploying...\033[0m"
rsync -r public/* gpaterson@vurt.co.uk:/home/gpaterson/vurt.co.uk/public/

echo -e "\033[0;32mDone.\033[0m"
