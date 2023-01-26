generated=$(ghch --latest)
# generated=$(ghch --from=20230101.12.24 --to=20230115.15.37)
filtered=$(echo $generated | jq '. | { changed_at: .changed_at, from_revision: .from_revision, to_revision: .to_revision, pull_requests: .pull_requests | map({title: .title}) }')
filter_untaged=$(echo $filtered | jq '. | select(.to_revision != "")')
filter_empty=$(echo $filter_untaged | jq '. | select(.pull_requests | length != 0)')
filter_type=$(echo $filter_empty | jq 'del(. | .pull_requests[] | select(.title | test("(feat|fix)") | not))')
result=$(echo $filter_type | jq -s .)
echo $result
echo $result > latest_changelog.json
jq -s '.[0] + .[1]' latest_changelog.json changelog.json > pre_generated.json
mv pre_generated.json changelog.json