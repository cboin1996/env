#!/bin/bash

help=$(cat <<EOF
usage: oink [-t text to display]
[-p optional prefix]
[-f specify font. see: http://www.figlet.org/examples.html]
[-d description]
[-h help]
EOF
)

while getopts 't:f:p:d:h' flag; do
        case "${flag}" in
		f) FONT=${OPTARG};;
		t) TEXT=${OPTARG};;
		p) PREFIX=${OPTARG};;
		d) DESC=${OPTARG};;
		h) echo ${help} && exit 0;;
        esac
done
shift $((OPTIND -1))

if [[ $TEXT == "" ]]; then
	echo "Must supply -t flag to render text!"
	exit 1
fi

if [[ $FONT != "" ]]; then
	FONT="-f ${FONT}"
fi

if [[ $DESC != "" ]]; then
	DESC="${PREFIX} -- Description: ${DESC}"
fi

# Generate ascii
figlet $FONT $TEXT | sed "s/^/${PREFIX} /"

# Add description
cat <<EOF
${PREFIX}
${PREFIX}
${DESC}
EOF

