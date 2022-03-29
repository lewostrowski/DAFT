#!/bin/bash

CURRENTSTRING="DAFT current file type: "

if [[ "$1" = "--config" ]];then
    if [[ -n $2 ]];then
        if [[ -n daft_config.cfg ]];then
            echo "FORMAT=\"$2\"" > "daft_config.cfg"
            . daft_config.cfg
            echo $CURRENTSTRING $FORMAT
        else
            touch daft_config.cfg; echo "FORMAT=\"$2\"" > daft_config.cfg
            . daft_config.cfg
            echo $CURRENTSTRING $FORMAT
        fi
    else
        echo "File type: $FORMAT"
    fi
elif [[ ( "$1" = "-r" && $2 -gt -1 ) || ( "$1" = "-m" && -n $2 && $3 -gt -1 ) ]];then
    #list of files 
    . daft_config.cfg
    declare -a FILES
    FILES=($(ls *.$FORMAT))

    #determine savedays position
    if [[ "$1" = "-r" ]];then
        SAVEDAYS=$2
        TABLE="Since the last modification; removed"
    elif [[ "$1" = "-m" ]];then
        SAVEDAYS=$3
        TABLE="Since the last modification; moved"
    fi

    echo $TABLE
    #check files' age
    for f in ${FILES[@]}; do
        DATENOW=$(date '+%s')
        FILEMODDATE=$(date -r $f '+%s')
        DAYS=$(( ($DATENOW - $FILEMODDATE) / 86400 ))

        #remove files
        if [[ "$1" = "-r" && $DAYS -gt $SAVEDAYS ]];then
            rm $f
            echo "$2 days ago; $f"

        #move file
        elif [[ "$1" = "-m" && $DAYS -gt $SAVEDAYS ]];then
            if [[ -d $2 ]]; then
                CURRENTDIR=$( pwd )
                mv $f $CURRENTDIR/$2
                echo "$3 days ago; /$2 <--- $f"
            else
                mkdir $2
                mv $f $CURRENTDIR/$2
                echo "$3 days ago; /$2 <--- $f"
            fi
        fi
    done
else
    echo " "
    echo "--------------- U S A G E ---------------"
    echo " "
    echo "1. Remove files (both arguments are mandatory)"
    echo "  $ ./daft.sh -r [days since the last modification]"
    echo " "
    echo "2.Move files (all arguments are mandatory)"
    echo "  $ ./daft.sh -m [directory] [days since the last modification]"
    echo " "
    echo "-----------------------------------------"
fi


