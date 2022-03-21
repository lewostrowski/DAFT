#!/bin/bash

FILEFORMAT='jpg'
DATENOW=$(date '+%s')

#list of files 
declare -a FILES
FILES=($(ls *.$FILEFORMAT))

if [[ "$1" = "--config" ]];then
    echo "CONFIG"
elif [[ ( "$1" = "-r" && $2 -gt 0 ) || ( "$1" = "-m" && -n $2 && -n $3 ) ]];then
    if [[ "$1" = "-r" ]];then
        SAVEDAYS=$2
    else
        SAVEDAYS=$3
    fi

    #check files' age
    for f in ${FILES[@]}; do
        FILEMODDATE=$(date -r $f '+%s')
        DAYS=$(( ($DATENOW - $FILEMODDATE) / 86400 ))

        #remove files
        if [[ "$1" = "-r" && $DAYS -gt $SAVEDAYS ]];then
            # rm $f
            echo "Remove file $f"

        #move file
        elif [[ "$1" = "-m" && $DAYS -gt $SAVEDAYS ]];then
            echo "Moving"
        fi
    done
else
    echo "Specify first argument"
fi

# "+%d-%m-%Y"


