# env

This repository houses configuration, scripts, and theming
for mac/linux operating systems, along with an installation
tool.

```tree
./configs
├── byobu        - byobu configuration files
├── zshrc        - zshrc files
├── zsh-themes   - zshrc files
├── tools        - developer tools
├── scripts      - scripts and utils
└── vscode       - vscode configuration files
```

## Setup

Make sure you have [realpath](https://man7.org/linux/man-pages/man3/realpath.3.html)
installed.

## Install your config

To install configuration files, run:

```bash
make install
```

This command runs the script
[install.sh](./tools/install.sh). The script
backs up any existing files that
are named exacly as what is defined in the folders.

To be more selective about what you want to install,
use the `install.sh` script directly or any of the targets
in the makefile individually.

## Development

### Setup a skeleton folder

```bash
./tools/skeleton -p foldername -f files -s "summary of folder"
```

## Reverting

Simply overwrite the new file with the backup.

```bash
mv installed-file.bak installed-file
```
