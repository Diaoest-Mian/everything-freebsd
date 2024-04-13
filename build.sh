#!/usr/bin/env bash

appName="ntfy"
builtAt="$(date +'%F %T %z')"
goVersion=$(go version | awk '{print $3}')
gitAuthor="Rajesh <rajesh@gs.serv00.net>"
gitCommit=$(git log --pretty=format:"%h" -1)
version=$(git describe --long --tags --dirty --always)
webVersion=$(wget -qO- -t1 -T2 "https://api.github.com/repos/binwiederhier/ntfy/releases/latest" | grep "tag_name" | head -n 1 | awk -F ":" '{print $2}' | sed 's/\"//g;s/,//g;s/ //g')

ldflags="\
-w -s \
-X 'github.com/binwiederhier/ntfy/internal/conf.BuiltAt=$builtAt' \
-X 'github.com/binwiederhier/ntfy/internal/conf.GoVersion=$goVersion' \
-X 'github.com/binwiederhier/ntfy/internal/conf.GitAuthor=$gitAuthor' \
-X 'github.com/binwiederhier/ntfy/internal/conf.GitCommit=$gitCommit' \
-X 'github.com/binwiederhier/ntfy/internal/conf.Version=$version' \
-X 'github.com/binwiederhier/ntfy/internal/conf.WebVersion=$webVersion' \
"

go build -ldflags="$ldflags" -tags=jsoniter .
