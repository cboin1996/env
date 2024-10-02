.PHONY: install
install: byobu scripts tmux zshrc zshtheme post

.PHONY: pre
pre:
	mkdir ~/bin || true

.PHONY: post
post:
	chmod +x ~/bin/*

.PHONY: chmodder
chmodder:
	@echo chmodding your scripts!
	chmod +x configs/scripts/files/*

.PHONY: byobu
byobu:
	@echo running installer for byobu!
	./tools/install.sh -p configs/byobu \
	-f files \
	-t header.txt

.PHONY: scripts
scripts: chmodder pre
	@echo running installer for scripts!
	./tools/install.sh -p configs/scripts \
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

.PHONY: tmux
tmux:
	@echo running installer for tmux!
	./tools/install.sh -p configs/tmux \
	-f files \
	-t header.txt
