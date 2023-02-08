#!/bin/sh

# Changelog生成のための一時ファイル(gitignore)
mkdir generate

echo $1 > generate/latest_changelog.json

# 過去のstgの目印は除去
cat changelog.json | jq '.[] | select(.is_staging | not)' | jq -s . > generate/current.json
jq -s '.[0] + .[1]' generate/latest_changelog.json generate/current.json > generate/pre_changelog.json
mv generate/pre_changelog.json changelog.json