tag_stg=stg.temp
git tag | grep stg.temp

# stg.tempタグが存在する場合、最新コミットにタグを付け替え
if [ $? = 0 ]; then
  commit_log=$(git show $tag_stg | grep commit) # commit afea0fcbd41559c0326998a5ff93b46a74d982f6
  commit_hash=${commit_log#commit } # afea0fcbd41559c0326998a5ff93b46a74d982f6
  tag_target=$(git tag -l --contains $commit_hash | grep -v $tag_stg) # 20230215.1

  git tag -d $tag_target
  git push origin --delete $tag_target

  git tag -d $tag_stg
  git push origin --delete $tag_stg
fi

git tag $tag_stg
git push origin $tag_stg

yyyymmddhhmm=$(date "+%Y%m%d.%H.%M")
git tag $yyyymmddhhmm
git push origin $yyyymmddhhmm
