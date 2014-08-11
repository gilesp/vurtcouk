#!/bin/bash

echo -e "\033[0;32mDeploying updates to prod_live...\033[0m"

#Delete old public folder content
rm -rf public/*

#Build the project
hugo -t vurt

#Add changes to git.
git add -A

#Commit changes
msg="Updating site `date`"
if [$# -eq 1]
    then msg="$1"
fi
git commit -m "$msg"

#Push source and build repos
git push origin master
git subtree push --prefix=public git@github.com:gilesp/vurtcouk.git public_prod
