#!/bin/bash -eu

BACKUP_DIR="./backup"

backup() {
	local src="${1?No file to backup}"
	local dst=""
	dst="$BACKUP_DIR/$(basename "$src")"
	if [ ! -f "$src" ]; then
	echo "backup: $src is not a regular file"
		return 1
	fi
	mkdir -p "$BACKUP_DIR"
	echo "Creating $dst"
	cp "$src" "$dst"
}

symlink() {
	local src="${1?No src}"
	local dst="$HOME/$src"
	if [ ! -f "$src" ]; then
		echo "symlink: $src is not a regular file"
		return 1
	fi
	if [ -e "$dst" ]; then
		if [ -h "$dst" ]; then
			echo "Ignoring symbolic link $dst"
			return
		fi
		echo "$dst already exists"
		backup "$dst"
	fi
	echo "Adding link $dst"
	ln -frs "$src" "$dst"
}

symlink .bash_aliases
symlink .bashrc
symlink .gitconfig
mkdir -p "$HOME/.local/bin"
for file in .local/bin/*; do
	symlink "$file"
done
symlink .profile
symlink .vimrc
