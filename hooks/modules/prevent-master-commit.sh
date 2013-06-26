#!/bin/sh

h1 "Master protection"

branch=`git symbolic-ref HEAD`
if [ $branch == "refs/heads/master" ]; then
    fail "Direct commits to the branch master are not allowed"
    exit 1
else
	ok "Branch is not master"
fi