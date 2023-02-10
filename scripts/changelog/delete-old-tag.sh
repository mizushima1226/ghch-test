#!/bin/sh

git config user.name $user_name
git config user.email $user_email

tag_stg=stg.latest

set +e
git tag | grep $tag_stg
exists_tag=$?
set -e

# 既存のstg.latestタグを削除
if [ $exists_tag = 0 ]; then
  # stg.latestタグとセットになっているバージョンタグを取得
  commit_log=`git show $tag_stg | grep commit` # commit 12345
  commit_hash=`echo $commit_log | cut -d ' ' -f 2` # 12345
  tag_version=`git tag -l --contains $commit_hash | grep -v $tag_stg` # yyyymmdd.hh.mm

  # バージョンタグ削除
  git tag -d $tag_version
  git push origin --delete $tag_version

  # stg.latestタグ削除
  git tag -d $tag_stg
  git push origin --delete $tag_stg
fi