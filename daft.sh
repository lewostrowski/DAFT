#!/bin/bash

. config.cfg

if [[ "$1" = "--config" ]];then
    echo $FILEFORMAT
elif [[ ( "$1" = "-r" && $2 -gt 0 ) || ( "$1" = "-m" && -n $2 && $3 -gt 0 ) ]];then
    #list of files 
    declare -a FILES
    FILES=($(ls *.$FORMAT))

    #determine savedays position
    if [[ "$1" = "-r" ]];then
        SAVEDAYS=$2
    elif [[ "$1" = "-m" ]];then
        SAVEDAYS=$3
    fi

    #check files' age
    for f in ${FILES[@]}; do
        DATENOW=$(date '+%s')
        FILEMODDATE=$(date -r $f '+%s')
        DAYS=$(( ($DATENOW - $FILEMODDATE) / 86400 ))

        #remove files
        if [[ "$1" = "-r" && $DAYS -gt $SAVEDAYS ]];then
            rm $f
            echo "File $f removed"

        #move file
        elif [[ "$1" = "-m" && $DAYS -gt $SAVEDAYS ]];then
            if [[ -d $2 ]]; then
                mv $f $2
            else
                mkdir $2
                mv $f
            fi
        fi
    done
else
    echo "Specify arguments according to scheme:"
    echo "To remove files ./daft.sh -r [number of days from last modification]"
    echo "To move files ./daft.sh -m [destination directory name] [number of days from last modification]"
fi

# "+%d-%m-%Y"


