#!/bin/bash
# defeine masked variable $GITHUB_TOKEN in gitlab webinterface: Reposetorry -> Settings -> CI/CD ->Variables
# GITHUB_TOKEN can be crataed at https://github.com/settings/tokens (from machine user account)
# set privileges to full repo
repo=LennardBoediger/fido2-webhook

version=$(git describe)
version="${version%-*-*}"
#a="${version%.*.*}"
#b="${version#*.*.}"
#a=$(echo $a | awk -F. -v OFS=. 'NF==1{print ++$NF}; NF>1{$NF=sprintf("%0*d", length($NF), ($NF+1)); print}')
#version=$a.$b

upload_url=$(curl -s -H "Authorization: token $GITHUB_TOKEN" -d '{"tag_name": "'"$version"'", "name":"'"$version"'","body":""}' "https://api.github.com/repos/$repo/releases" | jq -r '.upload_url')

upload_url="${upload_url%\{*}"

zip -r builds/release.zip builds/release
zip -r builds/debug.zip builds/debug

echo "uploading asset to release to url : $upload_url"

curl -s -H "Authorization: token $GITHUB_TOKEN"  \
        -H "Content-Type: application/zip" \
        --data-binary @builds/release.zip  \
        "$upload_url?name=release.zip"

curl -s -H "Authorization: token $GITHUB_TOKEN"  \
        -H "Content-Type: application/zip" \
        --data-binary @builds/debug.zip  \
        "$upload_url?name=debug.zip"