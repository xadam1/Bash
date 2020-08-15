#!/bin/bash

CHECK_MARK="\033[0;32m\xE2\x9C\x94\033[0m"

main()
{
    for DIR in $(find ${PWD} -mindepth 1 -type d)
    do
        echo PROCESSING ${DIR}...
        renamePhotosInDir $DIR
        renameVidInDir $DIR
        echo ''
    done
}


renamePhotosInDir()
{
	if [ `ls "${1}"/*.jpg 2>/dev/null | wc -l` -eq 0 ]; then printf '\u274c NO PHOTOS FOUND\n'; return ; fi
	COUNTER=1
	PARENTDIR=$(basename "$1")
	for PHOTO in "${1}"/*.{jpg,jpeg}
	do
		EXT="${PHOTO#*.}"
		echo -n -e "\e[0K\r"
		echo -ne "Processing "$PHOTO"...\r"
		COUNT=$(printf %03d "${COUNTER}")
		mv "$PHOTO" "${DIR}/${PARENTDIR}_fotka${COUNT}.${EXT}" 2>/dev/null
		((COUNTER++))
	done

	echo -n -e "\e[0K\r"
	echo -e "\\r${CHECK_MARK} PHOTOS DONE"
}


renameVidInDir()
{
	if [ `ls "${1}"/*.mov 2>/dev/null | wc -l` -eq 0 ]; then printf '\u274c NO VIDEOS FOUND\n'; return ; fi
	VIDCOUNT=1
	PARENTDIR=$(basename "$1")
	for VID in "${1}"/*.{mov,avi,m4v,mp4,3gp}
	do
		EXT="${VID#*.}"
		echo -n -e "\e[0K\r"
		echo -ne "\e[KProcessing "$VID"...\r"
		COUNT=$(printf %03d "${VIDCOUNT}")
		mv "$VID" "${DIR}/${PARENTDIR}_video${COUNT}.${EXT}" 2>/dev/null
		((VIDCOUNT++))
	done

	echo -n -e "\e[0K\r"
	echo -e "\\r${CHECK_MARK} VIDEOS DONE"
}

main

echo -e "\\n\\n${CHECK_MARK} SCRIPT DONE ${CHECK_MARK}\\n\\n"
