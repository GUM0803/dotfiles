#!/bin/bash

# .gitconfigに以下を記述する
# [diff]
#   tool = meld
# [difftool "meld"]
#   cmd = meld $LOCAL $REMOTE
# [merge]
#   tool = meld
# [mergetool "meld"]
#   cmd = meld $LOCAL $BASE $REMOTE --auto-merge

git difftool -d `git merge-base $1 $2`..$2
