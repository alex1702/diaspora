#!/bin/bash

set -e
set -x

git checkout master
git pull upstream master
git push origin master
git checkout social-elaon-de
git merge master
git push origin social-elaon-de
