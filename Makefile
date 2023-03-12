install: setup mac

setup: 
	bash scripts/setup.sh

mac:
	zsh scripts/mac.zsh

backup:
	bash scripts/backup.sh

.PHONY: install
