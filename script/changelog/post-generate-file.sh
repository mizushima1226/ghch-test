#!/bin/sh

# 過去のstgの目印は除去
cat public/changelog.json | jq '.[] | select(.is_staging | not)' | jq -s . > temp/generate/current.json
jq -s '.[0] + .[1]' temp/generate/latest_changelog.json temp/generate/current.json > temp/generate/pre_changelog.json
mv temp/generate/pre_changelog.json public/changelog.json