#!/usr/bin/env zsh

cd "$(dirname "$0")"

git pull origin main

function doIt() {
	rsync --exclude ".git/" \
		--exclude ".DS_Store" \
		--exclude ".osx" \
		--exclude "bootstrap.sh" \
		--exclude "README.md" \
		-avh --no-perms . ~
	source ~/.zshrc
}

if [[ "$1" == "--force" || "$1" == "-f" ]]; then
	doIt
else
	read "REPLY?This may overwrite existing files in your home directory. Are you sure? (y/n) "
	echo ""
	if [[ "$REPLY" =~ "^[Yy]$" ]]; then
		doIt
	fi
fi
unset -f doIt
