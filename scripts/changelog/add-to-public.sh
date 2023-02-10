#!/bin/sh

base_path="$1"
latest_file_name="$2"

# 過去のstgの目印は除去
cat public/changelog.json | jq '.[] | select(.is_staging | not)' | jq -s . > ${base_path}/current.json
jq -s '.[0] + .[1]' ${base_path}/${latest_file_name} ${base_path}/current.json > ${base_path}/pre_changelog.json
mv ${base_path}/pre_changelog.json public/changelog.json