#!/bin/bash

help=$(cat <<EOF
usage: install [-p path to folder containing *.conf files]
[-f name of the folder containing files to install]
[-s summary of what this skeleton is]
[-h help]
EOF
)
# this key will be used to parse
# and replace values with actual
# absolute paths up to the home dir
HOME_KEY="~HOME~"

while getopts 'p:f:s:h' flag; do
        case "${flag}" in
		p) _PATH=${OPTARG};;
        f) INSTALL_FILES_DIRNAME=${OPTARG};;
        s) SUMMARY=${OPTARG};;
		h) echo ${help} && exit 0;;
        esac
done
shift $((OPTIND -1))

if [ _PATH == "" ]; then
	echo "Must supply -p flag with a path to where the skeleton should go!"
	exit 1
fi

if ! [ $INSTALL_FILES_DIRNAME ]; then
    echo "Must supply -f flag with folder name that will house files!"
    exit 1
fi

# create folder structure
echo "Initializing folder structure under $_PATH"
mkdir -p $_PATH/$INSTALL_FILES_DIRNAME

# generate readme.md
echo "Creating a readme"
cat <<EOF > $_PATH/README.md
# $_PATH

$SUMMARY

EOF

# slap in the config stub
echo "Setting up default configs"
cp *.default.conf $_PATH

echo "Setup complete under $_PATH :)
