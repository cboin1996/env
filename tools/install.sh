#!/bin/bash

help=$(cat <<EOF
usage: install [-o operating system code name]
[-p path to folder containing *.conf files]
[-f name of the folder containing files to install]
[-t header to include. comments characters will be added automatically via relevant *.conf file]
[-h help]
EOF
)
# this key will be used to parse
# and replace values with actual
# absolute paths up to the home dir
HOME_KEY="~HOME~"

while getopts 'o:p:f:t:a:h' flag; do
        case "${flag}" in
		o) OS=${OPTARG};;
		p) _PATH=${OPTARG};;
        f) INSTALL_FILES_DIRNAME=${OPTARG};;
        t) HEADER_FILE=${OPTARG};;
		h) echo ${help} && exit 0;;
        esac
done
shift $((OPTIND -1))

if [ ! -d $_PATH ]; then
	echo "ERROR: Must supply -p flag with a valid path to install files. Received $_PATH!"
	exit 1
fi

if [ $OS == "" ]; then
	echo "ERROR: Must supply -o flag specifying the operating system!"
	exit 1
fi

if [ $OS != "darwin" ] && [ $OS != "linux" ]; then
	echo "ERROR: os not supported yet. must be one of [darwin, linux]!"
	exit 1
fi

if [ ! -d $_PATH/$INSTALL_FILES_DIRNAME ] || [ $INSTALL_FILES_DIRNAME == "" ]; then
    echo "ERROR: Must supply -f flag with folder name containing files to install!"
    exit 1
fi

if [ ! -f $HEADER_FILE ]; then
    echo "ERROR: Must supply -t flag valid header file path!"
    exit 1
fi

echo -e "\nINFO: starting installation process!\n"
# load the config path
CONFPATH=$_PATH/$OS.conf

# parse location of where files should be placed
DISK_LOCATION=$(grep 'PATH' $CONFPATH | sed "s/PATH=//")

# parse the comment character
COMMENT_CHAR=$(grep 'COMMENT' $CONFPATH | sed "s/COMMENT=//")

# parse the install location
INSTALL_LOC=$(grep 'INSTALL' $CONFPATH | sed "s/INSTALL=//")

# prepare header
HEADER=$(cat $HEADER_FILE | sed "s/^/$COMMENT_CHAR /")
HEADER_LOC=1

# ensure files being placed into home directories
# have absolute paths.
# for substring checks we need double [[ ]]
if [[ "$DISK_LOCATION" == *"$HOME_KEY"* ]]; then
    # escape \ chars in $HOME for use in SED
    ESCAPED_HOME=$(echo $HOME | sed 's/\//\\\//g')
    DISK_LOCATION=$(echo $DISK_LOCATION | sed "s/$HOME_KEY/$ESCAPED_HOME/")
    echo -e "INFO: replaced $HOME_KEY in destination -> $DISK_LOCATION\n"
fi
# obtain local file location
FILESPATH=$_PATH/$INSTALL_FILES_DIRNAME
FILES=$(ls -d "$PWD"/$FILESPATH/*)
cat <<EOF
INFO: Will install the following files to '$DISK_LOCATION': $FILES

INFO: Header to add: $HEADER

EOF

echo -e "-------------------------"
for FILE in $FILES
do
    # get only the filename off the absolute
    FILE_NAME=$(basename $FILE)

    # add header
    # for shell scripts, header must be below shebang
    if [[ "$FILE_NAME" == *".sh"* ]]; then
        echo "INFO: inserting header below shebang for *.sh type!"
        HEADER_LOC=2
    fi
    FILE_DEST=$DISK_LOCATION/$FILE_NAME
    FILE_WITH_HEADER=$(cat $FILE | sed "$HEADER_LOC i $HEADER")
    # double check file exists
    if [ ! -f $FILE_DEST ]; then
        echo "WARN: $FILE_DEST not found. Attempting to load in $FILE."
        echo "$FILE_WITH_HEADER" > $FILE_DEST
        echo "WARN: To avoid this warning next time, checkout here: $INSTALL_LOC"
        continue
    fi
    # perform file system update
    cp $FILE_DEST $FILE_DEST.bak
    echo "INFO: Backed up $FILE_DEST -> $FILE_DEST.bak"
    echo "$FILE_WITH_HEADER" > $FILE_DEST
    echo "INFO: Installed $FILE to $FILE_DEST"
    echo -e "\n-------------------------"
done