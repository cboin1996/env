# env

This repository houses configuration, scripts, and theming
for mac/linux operating systems, along with an installation
tool.

```tree
.
├── byobu   - byobu configuration files
├── zshrc   - zshrc files
├── tools   - developer tools
├── scripts - scripts and utils
└── vscode  - vscode configuration files
```

## Setup

First, set your operating system as one of

```bash
export OS=linux
export OS=darwin
```

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

Currently, hidden files are not supported in the install script.
As such `~/.zshrc` needs manually installed.

## Development

### Setup a skeleton folder

```bash
./skeleton -p foldername -f files -s "summary of folder"
```
