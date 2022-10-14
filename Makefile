install: setup mac

setup: 
	bash scripts/setup.sh

mac:
	zsh scripts/mac.zsh

.PHONY: install
