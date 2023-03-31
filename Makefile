.PHONY: install
install: chmodder byobu scripts

.PHONY: chmodder
chmodder:
	@echo chmodding your scripts!
	sudo chmod +x scripts/files/*.sh

.PHONY: byobu
byobu:
	@echo running installer for byobu!
	./tools/install.sh -p byobu \
	-f files \
	-t header.txt

.PHONY: scripts
scripts:
	@echo running installer for scripts!
	sudo ./tools/install.sh -p scripts \
	-f files \
	-t header.txt

.PHONY: zshrc
zshrc:
	@echo running installer for zshrc!
	./tools/install.sh -p zshrc \
	-f files \
	-t header.txt
