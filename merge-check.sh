#!/bin/bash
git difftool -d `git merge-base $1 $2`..$2
