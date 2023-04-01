.PHONY: install
install: chmodder byobu scripts zshrc zshtheme

.PHONY: chmodder
chmodder:
	@echo chmodding your scripts!
	sudo chmod +x configs/scripts/files/*.sh

.PHONY: byobu
byobu:
	@echo running installer for byobu!
	./tools/install.sh -p configs/byobu \
	-f files \
	-t header.txt

.PHONY: scripts
scripts:
	@echo running installer for scripts!
	sudo ./tools/install.sh -p configs/scripts \
	-f files \
	-t header.txt

.PHONY: zshrc
zshrc:
	@echo running installer for zshrc!
	./tools/install.sh -p configs/zshrc \
	-f files \
	-t header.txt

.PHONY: zshtheme
zshtheme:
	@echo running installer for zshtheme!
	./tools/install.sh -p configs/zsh-themes \
	-f files \
	-t header.txt