#!/bin/sh

git config user.name $user_name
git config user.email $user_email

# 最新コミットにバージョンタグを付与
tag_version=$(date "+%Y%m%d.%H.%M")
git tag $tag_version
git push origin $tag_version